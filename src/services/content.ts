import { supabase } from '@/lib/supabase'
import type { Chapter, Lesson, LessonProgress, Problem, Quiz, Achievement, UserAchievement } from '@/types/database.types'

export async function getChapters(): Promise<Chapter[]> {
  const { data, error } = await supabase.from('chapters').select('*').order('chapter_number')
  if (error) throw error
  return data as Chapter[]
}

export async function getChapterWithLessons(chapterNumber: number) {
  const { data: chapter, error: chErr } = await supabase
    .from('chapters')
    .select('*')
    .eq('chapter_number', chapterNumber)
    .single()
  if (chErr) throw chErr

  const { data: lessons, error: lErr } = await supabase
    .from('lessons')
    .select('*')
    .eq('chapter_id', chapter.id)
    .order('lesson_number')
  if (lErr) throw lErr

  return { chapter: chapter as Chapter, lessons: lessons as Lesson[] }
}

export async function getLesson(lessonId: string): Promise<Lesson> {
  const { data, error } = await supabase.from('lessons').select('*').eq('id', lessonId).single()
  if (error) throw error
  return data as Lesson
}

export async function getLessonQuizzes(lessonId: string): Promise<Quiz[]> {
  const { data, error } = await supabase
    .from('quizzes')
    .select('*')
    .eq('lesson_id', lessonId)
    .order('order_index')
  if (error) throw error
  return data as Quiz[]
}

export async function getUserProgress(userId: string): Promise<LessonProgress[]> {
  const { data, error } = await supabase.from('lesson_progress').select('*').eq('user_id', userId)
  if (error) throw error
  return data as LessonProgress[]
}

export async function completeLesson(lessonId: string) {
  const { error } = await supabase.rpc('complete_lesson', { p_lesson_id: lessonId })
  if (error) throw error
}

export async function submitQuiz(lessonId: string, answers: Record<string, string>) {
  const { data, error } = await supabase.rpc('submit_quiz', {
    p_lesson_id: lessonId,
    p_answers: answers,
  })
  if (error) throw error
  return data as { score: number; total: number }
}

export async function getProblems(): Promise<Problem[]> {
  // Uses the problems_public VIEW which never exposes the `solution` column.
  const { data, error } = await supabase
    .from('problems_public')
    .select('*')
    .order('problem_number')
  if (error) throw error
  return data as Problem[]
}

export async function getProblem(id: string): Promise<Problem> {
  const { data, error } = await supabase.from('problems_public').select('*').eq('id', id).single()
  if (error) throw error
  return data as Problem
}

export async function submitProblem(problemId: string, code: string, status: 'passed' | 'failed') {
  const { error } = await supabase.rpc('submit_problem', {
    p_problem_id: problemId,
    p_code: code,
    p_status: status,
  })
  if (error) throw error
}

export async function getUserSolvedProblemIds(userId: string): Promise<Set<string>> {
  const { data, error } = await supabase
    .from('problem_submissions')
    .select('problem_id, status')
    .eq('user_id', userId)
    .eq('status', 'passed')
  if (error) throw error
  return new Set((data as { problem_id: string }[]).map((d) => d.problem_id))
}

export async function getAllAchievements(): Promise<Achievement[]> {
  const { data, error } = await supabase.from('achievements').select('*')
  if (error) throw error
  return data as Achievement[]
}

export async function getUserAchievements(userId: string): Promise<UserAchievement[]> {
  const { data, error } = await supabase
    .from('user_achievements')
    .select('*, achievement:achievements(*)')
    .eq('user_id', userId)
  if (error) throw error
  return data as unknown as UserAchievement[]
}
