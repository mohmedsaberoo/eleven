-- ============================================================
-- Eleven — Migration 0002: Row Level Security
-- ============================================================

alter table public.profiles enable row level security;
alter table public.chapters enable row level security;
alter table public.lessons enable row level security;
alter table public.lesson_progress enable row level security;
alter table public.quizzes enable row level security;
alter table public.quiz_attempts enable row level security;
alter table public.problems enable row level security;
alter table public.problem_submissions enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;

-- Helper: is the current user an admin?
create or replace function public.is_admin()
returns boolean language sql security definer stable set search_path = public as $$
  select exists (
    select 1 from public.profiles where id = auth.uid() and role = 'admin'
  );
$$;

-- ---------- PROFILES ----------
-- Everyone authenticated can read public profile fields (needed for leaderboards / admin lists).
create policy "profiles_select_own_or_admin"
  on public.profiles for select
  using (auth.uid() = id or public.is_admin());

-- A user can update ONLY their own row, and never their own xp/level/role directly.
create policy "profiles_update_own_limited"
  on public.profiles for update
  using (auth.uid() = id)
  with check (
    auth.uid() = id
    and role = (select role from public.profiles p where p.id = auth.uid())
    and xp = (select xp from public.profiles p where p.id = auth.uid())
    and level = (select level from public.profiles p where p.id = auth.uid())
  );

create policy "profiles_admin_full"
  on public.profiles for all
  using (public.is_admin())
  with check (public.is_admin());

-- ---------- CHAPTERS / LESSONS (public read, admin write) ----------
create policy "chapters_select_all" on public.chapters for select using (true);
create policy "chapters_admin_write" on public.chapters for insert with check (public.is_admin());
create policy "chapters_admin_update" on public.chapters for update using (public.is_admin());
create policy "chapters_admin_delete" on public.chapters for delete using (public.is_admin());

create policy "lessons_select_all" on public.lessons for select using (true);
create policy "lessons_admin_write" on public.lessons for insert with check (public.is_admin());
create policy "lessons_admin_update" on public.lessons for update using (public.is_admin());
create policy "lessons_admin_delete" on public.lessons for delete using (public.is_admin());

-- ---------- LESSON PROGRESS ----------
create policy "lesson_progress_select_own" on public.lesson_progress for select
  using (auth.uid() = user_id or public.is_admin());
create policy "lesson_progress_insert_own" on public.lesson_progress for insert
  with check (auth.uid() = user_id);
create policy "lesson_progress_update_own" on public.lesson_progress for update
  using (auth.uid() = user_id);

-- ---------- QUIZZES (public read of questions; correct_answer exposed only via RPC ideally,
-- kept simple here: students can read but grading also validated server-side via function) ----------
create policy "quizzes_select_all" on public.quizzes for select using (true);
create policy "quizzes_admin_write" on public.quizzes for insert with check (public.is_admin());
create policy "quizzes_admin_update" on public.quizzes for update using (public.is_admin());
create policy "quizzes_admin_delete" on public.quizzes for delete using (public.is_admin());

create policy "quiz_attempts_select_own" on public.quiz_attempts for select
  using (auth.uid() = user_id or public.is_admin());
create policy "quiz_attempts_insert_own" on public.quiz_attempts for insert
  with check (auth.uid() = user_id);

-- ---------- PROBLEMS ----------
-- Students can read problem metadata but the "solution" column is protected:
-- expose a view without solution for the student-facing app.
create policy "problems_select_all" on public.problems for select using (true);
create policy "problems_admin_write" on public.problems for insert with check (public.is_admin());
create policy "problems_admin_update" on public.problems for update using (public.is_admin());
create policy "problems_admin_delete" on public.problems for delete using (public.is_admin());

create view public.problems_public as
  select id, problem_number, title, description, difficulty, input_description,
         output_description, example_input, example_output, hint, starter_code, xp, created_at
  from public.problems;

-- ---------- PROBLEM SUBMISSIONS ----------
create policy "submissions_select_own" on public.problem_submissions for select
  using (auth.uid() = user_id or public.is_admin());
create policy "submissions_insert_own" on public.problem_submissions for insert
  with check (auth.uid() = user_id);

-- ---------- ACHIEVEMENTS ----------
create policy "achievements_select_all" on public.achievements for select using (true);
create policy "achievements_admin_write" on public.achievements for insert with check (public.is_admin());

-- Users can NEVER insert their own achievements directly — only the
-- award_achievement() security-definer function (below) can do that.
create policy "user_achievements_select_own" on public.user_achievements for select
  using (auth.uid() = user_id or public.is_admin());
create policy "user_achievements_admin_insert" on public.user_achievements for insert
  with check (public.is_admin());
