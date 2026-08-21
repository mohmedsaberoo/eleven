export type UserRole = 'student' | 'admin'
export type ProblemDifficulty = 'easy' | 'hard'
export type SubmissionStatus = 'pending' | 'passed' | 'failed'
export type QuizQuestionType = 'multiple_choice' | 'true_false' | 'predict_output'

export interface Profile {
  id: string
  full_name: string
  avatar_url: string | null
  role: UserRole
  xp: number
  level: number
  streak: number
  last_active_date: string | null
  created_at: string
  updated_at: string
}

export interface Chapter {
  id: string
  chapter_number: number
  title: string
  description: string
  stage: string
  icon: string | null
  created_at: string
}

export interface LessonContent {
  explanation: string
  code_examples: { code: string; explanation: string }[]
  common_mistakes: string[]
  tips: string[]
  challenge: { prompt: string; starter_code: string }
}

export interface Lesson {
  id: string
  chapter_id: string
  lesson_number: number
  title: string
  summary: string
  objectives: string[]
  content: LessonContent
  duration_minutes: number
  xp_reward: number
  created_at: string
}

export interface LessonProgress {
  id: string
  user_id: string
  lesson_id: string
  completed: boolean
  completed_at: string | null
  created_at: string
}

export interface Quiz {
  id: string
  lesson_id: string
  question: string
  question_type: QuizQuestionType
  options: string[]
  correct_answer: string
  explanation: string
  order_index: number
}

export interface Problem {
  id: string
  problem_number: number
  title: string
  description: string
  difficulty: ProblemDifficulty
  input_description: string
  output_description: string
  example_input: string
  example_output: string
  hint: string
  starter_code: string
  xp: number
  created_at: string
}

export interface Achievement {
  id: string
  code: string
  title: string
  description: string
  icon: string
}

export interface UserAchievement {
  user_id: string
  achievement_id: string
  unlocked_at: string
  achievement?: Achievement
}

// NOTE: no `Database` type is exported here. See the comment in
// `src/lib/supabase.ts` for why we don't pass a hand-written Database
// generic into the Supabase client. The row types above are the source
// of truth for each table's shape and are cast explicitly at call sites.
