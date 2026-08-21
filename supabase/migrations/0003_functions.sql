-- ============================================================
-- Eleven — Migration 0003: Server-side game logic (RPC)
-- All XP / level / streak / achievement changes MUST go through
-- these SECURITY DEFINER functions so RLS on profiles (which blocks
-- direct xp/level edits) cannot be bypassed by the client.
-- ============================================================

-- Recompute level from xp using a simple curve: level = floor(xp/100) + 1
create or replace function public.recompute_level(p_xp integer)
returns integer language sql immutable as $$
  select greatest(1, floor(p_xp / 100.0)::integer + 1);
$$;

create or replace function public.bump_streak(p_user_id uuid)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_last date;
begin
  select last_active_date into v_last from public.profiles where id = p_user_id;

  if v_last is null then
    update public.profiles set streak = 1, last_active_date = current_date where id = p_user_id;
  elsif v_last = current_date then
    -- already active today, no change
    null;
  elsif v_last = current_date - interval '1 day' then
    update public.profiles set streak = streak + 1, last_active_date = current_date where id = p_user_id;
  else
    update public.profiles set streak = 1, last_active_date = current_date where id = p_user_id;
  end if;
end;
$$;

create or replace function public.grant_xp(p_user_id uuid, p_amount integer)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_new_xp integer;
begin
  update public.profiles
    set xp = xp + p_amount
    where id = p_user_id
    returning xp into v_new_xp;

  update public.profiles set level = public.recompute_level(v_new_xp) where id = p_user_id;
  perform public.bump_streak(p_user_id);
end;
$$;

create or replace function public.award_achievement(p_user_id uuid, p_code text)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_ach_id uuid;
begin
  select id into v_ach_id from public.achievements where code = p_code;
  if v_ach_id is not null then
    insert into public.user_achievements (user_id, achievement_id)
    values (p_user_id, v_ach_id)
    on conflict do nothing;
  end if;
end;
$$;

-- Complete a lesson: marks progress, grants XP, checks achievements.
create or replace function public.complete_lesson(p_lesson_id uuid)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_user uuid := auth.uid();
  v_xp integer;
  v_chapter_id uuid;
  v_total_in_chapter integer;
  v_completed_in_chapter integer;
  v_total_lessons_done integer;
  v_total_chapters_done integer;
begin
  if v_user is null then
    raise exception 'not authenticated';
  end if;

  select xp_reward, chapter_id into v_xp, v_chapter_id from public.lessons where id = p_lesson_id;

  insert into public.lesson_progress (user_id, lesson_id, completed, completed_at)
  values (v_user, p_lesson_id, true, now())
  on conflict (user_id, lesson_id)
    do update set completed = true, completed_at = now();

  perform public.grant_xp(v_user, coalesce(v_xp, 10));

  -- first lesson ever
  select count(*) into v_total_lessons_done from public.lesson_progress
    where user_id = v_user and completed = true;
  if v_total_lessons_done = 1 then
    perform public.award_achievement(v_user, 'first_step');
  end if;

  -- chapter completed?
  select count(*) into v_total_in_chapter from public.lessons where chapter_id = v_chapter_id;
  select count(*) into v_completed_in_chapter
    from public.lesson_progress lp
    join public.lessons l on l.id = lp.lesson_id
    where lp.user_id = v_user and l.chapter_id = v_chapter_id and lp.completed = true;

  if v_completed_in_chapter >= v_total_in_chapter then
    select count(distinct l.chapter_id) into v_total_chapters_done
      from public.lesson_progress lp
      join public.lessons l on l.id = lp.lesson_id
      where lp.user_id = v_user and lp.completed = true
      group by l.chapter_id
      having count(*) = (select count(*) from public.lessons l2 where l2.chapter_id = l.chapter_id);

    if v_total_chapters_done = 1 then
      perform public.award_achievement(v_user, 'python_starter');
    end if;
    if v_total_chapters_done >= 10 then
      perform public.award_achievement(v_user, 'python_explorer');
    end if;
    if v_total_chapters_done >= (select count(*) from public.chapters) then
      perform public.award_achievement(v_user, 'python_master');
    end if;
  end if;
end;
$$;

-- Submit a quiz attempt. Grading happens server-side against quizzes.correct_answer
-- so the client never needs to see/trust the answer key.
create or replace function public.submit_quiz(p_lesson_id uuid, p_answers jsonb)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_user uuid := auth.uid();
  v_score integer := 0;
  v_total integer := 0;
  q record;
  v_given text;
begin
  if v_user is null then raise exception 'not authenticated'; end if;

  for q in select id, correct_answer from public.quizzes where lesson_id = p_lesson_id loop
    v_total := v_total + 1;
    v_given := p_answers->>q.id::text;
    if v_given is not null and v_given = q.correct_answer then
      v_score := v_score + 1;
    end if;
  end loop;

  insert into public.quiz_attempts (user_id, lesson_id, score, total)
  values (v_user, p_lesson_id, v_score, v_total);

  if v_total > 0 then
    perform public.grant_xp(v_user, greatest(1, round(v_score::numeric / v_total * 5))::integer);
  end if;

  return jsonb_build_object('score', v_score, 'total', v_total);
end;
$$;

-- Submit a problem solution. The Python execution/testing itself happens in the
-- browser sandbox (Pyodide); this RPC only records the verified result and
-- grants XP once, preventing XP farming via repeated client-only claims.
create or replace function public.submit_problem(p_problem_id uuid, p_code text, p_status submission_status)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_user uuid := auth.uid();
  v_already_passed boolean;
  v_xp integer;
  v_easy_solved integer;
  v_hard_solved integer;
begin
  if v_user is null then raise exception 'not authenticated'; end if;

  select exists(
    select 1 from public.problem_submissions
    where user_id = v_user and problem_id = p_problem_id and status = 'passed'
  ) into v_already_passed;

  insert into public.problem_submissions (user_id, problem_id, code, status)
  values (v_user, p_problem_id, p_code, p_status);

  if p_status = 'passed' and not v_already_passed then
    select xp into v_xp from public.problems where id = p_problem_id;
    perform public.grant_xp(v_user, coalesce(v_xp, 20));

    select count(distinct ps.problem_id) into v_easy_solved
      from public.problem_submissions ps join public.problems p on p.id = ps.problem_id
      where ps.user_id = v_user and ps.status = 'passed';

    if v_easy_solved >= 5 then
      perform public.award_achievement(v_user, 'problem_solver');
    end if;
    if v_easy_solved >= 15 then
      perform public.award_achievement(v_user, 'challenger');
    end if;
  end if;
end;
$$;

grant execute on function public.complete_lesson(uuid) to authenticated;
grant execute on function public.submit_quiz(uuid, jsonb) to authenticated;
grant execute on function public.submit_problem(uuid, text, submission_status) to authenticated;
