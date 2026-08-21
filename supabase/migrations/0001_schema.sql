-- ============================================================
-- Eleven — Python Learning Platform
-- Migration 0001: Core schema
-- ============================================================

create extension if not exists "uuid-ossp";

-- ---------- ENUM TYPES ----------
do $$ begin
  create type user_role as enum ('student', 'admin');
exception when duplicate_object then null; end $$;

do $$ begin
  create type problem_difficulty as enum ('easy', 'hard');
exception when duplicate_object then null; end $$;

do $$ begin
  create type submission_status as enum ('pending', 'passed', 'failed');
exception when duplicate_object then null; end $$;

do $$ begin
  create type quiz_question_type as enum ('multiple_choice', 'true_false', 'predict_output');
exception when duplicate_object then null; end $$;

-- ---------- PROFILES ----------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  avatar_url text,
  role user_role not null default 'student',
  xp integer not null default 0,
  level integer not null default 1,
  streak integer not null default 0,
  last_active_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ---------- CHAPTERS ----------
create table if not exists public.chapters (
  id uuid primary key default uuid_generate_v4(),
  chapter_number integer not null unique,
  title text not null,
  description text not null default '',
  stage text not null default '',
  icon text default '🐍',
  created_at timestamptz not null default now()
);

create index if not exists idx_chapters_number on public.chapters(chapter_number);

-- ---------- LESSONS ----------
create table if not exists public.lessons (
  id uuid primary key default uuid_generate_v4(),
  chapter_id uuid not null references public.chapters(id) on delete cascade,
  lesson_number integer not null,
  title text not null,
  summary text not null default '',
  objectives jsonb not null default '[]'::jsonb,
  content jsonb not null default '{}'::jsonb, -- { explanation, code_examples[], common_mistakes[], tips[], challenge }
  duration_minutes integer not null default 10,
  xp_reward integer not null default 10,
  created_at timestamptz not null default now(),
  unique(chapter_id, lesson_number)
);

create index if not exists idx_lessons_chapter on public.lessons(chapter_id);

-- ---------- LESSON PROGRESS ----------
create table if not exists public.lesson_progress (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  completed boolean not null default false,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  unique(user_id, lesson_id)
);

create index if not exists idx_lesson_progress_user on public.lesson_progress(user_id);

-- ---------- QUIZZES ----------
create table if not exists public.quizzes (
  id uuid primary key default uuid_generate_v4(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  question text not null,
  question_type quiz_question_type not null default 'multiple_choice',
  options jsonb not null default '[]'::jsonb,
  correct_answer text not null,
  explanation text default '',
  order_index integer not null default 0
);

create index if not exists idx_quizzes_lesson on public.quizzes(lesson_id);

-- ---------- QUIZ ATTEMPTS ----------
create table if not exists public.quiz_attempts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  score integer not null,
  total integer not null,
  created_at timestamptz not null default now()
);

create index if not exists idx_quiz_attempts_user on public.quiz_attempts(user_id);

-- ---------- PROBLEMS ----------
create table if not exists public.problems (
  id uuid primary key default uuid_generate_v4(),
  problem_number integer not null unique,
  title text not null,
  description text not null,
  difficulty problem_difficulty not null,
  input_description text default '',
  output_description text default '',
  example_input text default '',
  example_output text default '',
  hint text default '',
  starter_code text default '',
  solution text not null,           -- never selected by anon role, see RLS below
  test_cases jsonb not null default '[]'::jsonb, -- [{input, expected_output}]
  xp integer not null default 20,
  created_at timestamptz not null default now()
);

create index if not exists idx_problems_difficulty on public.problems(difficulty);

-- ---------- PROBLEM SUBMISSIONS ----------
create table if not exists public.problem_submissions (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  problem_id uuid not null references public.problems(id) on delete cascade,
  code text not null,
  status submission_status not null default 'pending',
  created_at timestamptz not null default now()
);

create index if not exists idx_submissions_user on public.problem_submissions(user_id);

-- ---------- ACHIEVEMENTS ----------
create table if not exists public.achievements (
  id uuid primary key default uuid_generate_v4(),
  code text not null unique, -- e.g. 'first_step'
  title text not null,
  description text not null,
  icon text default '🏆'
);

-- ---------- USER ACHIEVEMENTS ----------
create table if not exists public.user_achievements (
  user_id uuid not null references public.profiles(id) on delete cascade,
  achievement_id uuid not null references public.achievements(id) on delete cascade,
  unlocked_at timestamptz not null default now(),
  primary key (user_id, achievement_id)
);

-- ---------- updated_at trigger ----------
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_profiles_updated_at on public.profiles;
create trigger trg_profiles_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

-- ---------- auto-create profile on signup ----------
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name, role)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', ''), 'student')
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists trg_on_auth_user_created on auth.users;
create trigger trg_on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
