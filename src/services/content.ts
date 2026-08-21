import { supabase } from '@/lib/supabase'
import type { Chapter, Lesson, LessonProgress, Problem, Quiz, Achievement, UserAchievement } from '@/types/database.types'

function normalizeBeginnerLesson(lesson: Lesson): Lesson {
  const title = lesson.title || 'درس جديد'
  const upgradedSummary = lesson.summary || `هذا درس عن ${title} بطريقة بسيطة جدًا للمبتدئين.`
  const goals = lesson.objectives?.length ? lesson.objectives : [
    `فهْم فكرة ${title} من الصفر`,
    'تطبيق الفكرة في كود Python بسيط',
    'تجربة المثال خارج المنصة على جهازك',
  ]

  const conceptText = `بص 👀\n\nفي هذا الدرس هنتعلّم ${title} بطريقة سهلة جدًا، من الصفر.\n\nالفكرة ببساطة: ${upgradedSummary}.\n\nبنستخدم مثال عملي للقراءة والشرح. اقرأ كل سطر ببطء وفهم المقصود.`

  const explanation = [
    conceptText,
    'الهدف مش إنك تحفظ الكود، الهدف إنك تفهم ليه مكتوب كده، وإيه اللي بيحدث في كل خط.',
    'لو واجهتك فكرة جديدة، خليك هادئ وامشِ في المثال خطوة بخطوة. كل مبرمج يبدأ من الصفر، وكل Error أو خطأ يعتبر جزء من التعلم.',
  ].join('\n\n')

    const codeExamples = Array.isArray(lesson.content?.code_examples) && lesson.content.code_examples.length > 0
    ? lesson.content.code_examples
    : [
        {
          code: 'print("Hello, Eleven!")',
          explanation: 'هذا المثال يوضح الفكرة بشكل بسيط جدًا. اقرأ الكود خطوة بخطوة.',
        },
      ]

  const challenge = lesson.content?.challenge || {
    prompt: `اقرأ المطلوب التالي وقرّر أي سطر سيعطي الناتج المطلوب. لا تحتاج لكتابة كود.`,
    starter_code: 'print("اكتب كودك هنا")',
  }

  return {
    ...lesson,
    summary: upgradedSummary,
    objectives: goals,
    content: {
      ...lesson.content,
      explanation,
      code_examples: codeExamples,
      challenge,
      common_mistakes: lesson.content?.common_mistakes?.length ? lesson.content.common_mistakes : [
        'عدم فهم الفكرة الأساسية قبل كتابة الكود.',
        'محاولة حفظ الكود من غير فهم.',
      ],
      tips: lesson.content?.tips?.length ? lesson.content.tips : [
        'اقرأ المثال ببطء، ثم انسخه وجربه خارج المنصة على جهازك.',
        'لا تخف من الأخطاء، كل خطأ يساعدك تتعلّم.',
      ],
    },
  }
}

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
  return normalizeBeginnerLesson(data as Lesson)
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
