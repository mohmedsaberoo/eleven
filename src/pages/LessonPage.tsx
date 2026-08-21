import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { motion } from 'framer-motion'
import confetti from 'canvas-confetti'
import toast from 'react-hot-toast'
import { ArrowRight, ArrowLeft, Lightbulb, AlertTriangle, Target, CheckCircle2 } from 'lucide-react'
import { supabase } from '@/lib/supabase'
import { useAuth } from '@/contexts/AuthContext'
import { getLesson, getLessonQuizzes, completeLesson, getUserProgress } from '@/services/content'
import { CodeRunner } from '@/components/lesson/CodeRunner'
import { QuizWidget } from '@/components/lesson/QuizWidget'
import type { Lesson, Quiz } from '@/types/database.types'

export default function LessonPage() {
  const { lessonId } = useParams()
  const navigate = useNavigate()
  const { user, refreshProfile } = useAuth()
  const [lesson, setLesson] = useState<Lesson | null>(null)
  const [quizzes, setQuizzes] = useState<Quiz[]>([])
  const [siblingLessons, setSiblingLessons] = useState<{ id: string; lesson_number: number; title: string }[]>([])
  const [chapterNumber, setChapterNumber] = useState<number | null>(null)
  const [completed, setCompleted] = useState(false)
  const [loading, setLoading] = useState(true)
  const [marking, setMarking] = useState(false)

  useEffect(() => {
    if (!lessonId || !user) return
    setLoading(true)
    ;(async () => {
      const l = await getLesson(lessonId)
      const [qz, progress, { data: chapter }, { data: siblings }] = await Promise.all([
        getLessonQuizzes(lessonId),
        getUserProgress(user.id),
        supabase.from('chapters').select('chapter_number').eq('id', l.chapter_id).single(),
        supabase.from('lessons').select('id, lesson_number, title').eq('chapter_id', l.chapter_id).order('lesson_number'),
      ])
      setLesson(l)
      setQuizzes(qz)
      setChapterNumber(chapter?.chapter_number ?? null)
      setSiblingLessons(siblings ?? [])
      setCompleted(progress.some((p) => p.lesson_id === lessonId && p.completed))
      setLoading(false)
    })()
  }, [lessonId, user])

  const handleComplete = async () => {
    if (!lessonId || completed) return
    setMarking(true)
    try {
      await completeLesson(lessonId)
      setCompleted(true)
      await refreshProfile()
      confetti({ particleCount: 90, spread: 70, origin: { y: 0.7 }, colors: ['#43cb7c', '#79e0a1', '#20b060'] })
      toast.success(`+${lesson?.xp_reward ?? 10} XP 🎉`)
    } catch {
      toast.error('حدث خطأ، حاول مجددًا')
    } finally {
      setMarking(false)
    }
  }

  if (loading || !lesson) return <div className="h-96 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  const currentIndex = siblingLessons.findIndex((s) => s.id === lesson.id)
  const prevLesson = currentIndex > 0 ? siblingLessons[currentIndex - 1] : null
  const nextLesson = currentIndex >= 0 && currentIndex < siblingLessons.length - 1 ? siblingLessons[currentIndex + 1] : null

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      {/* Progress indicator */}
      <div className="flex items-center gap-2 text-xs text-gray-500">
        <span>فصل {chapterNumber}</span>
        <span>•</span>
        <span>
          درس {lesson.lesson_number} من {siblingLessons.length}
        </span>
        <div className="ml-auto h-1.5 w-32 overflow-hidden rounded-full bg-black/5 dark:bg-white/10">
          <div
            className="h-full rounded-full bg-eleven-500"
            style={{ width: `${((currentIndex + 1) / Math.max(1, siblingLessons.length)) * 100}%` }}
          />
        </div>
      </div>

      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}>
        <h1 className="text-2xl font-extrabold">{lesson.title}</h1>
        <p className="mt-1 text-gray-500 dark:text-gray-400">{lesson.summary}</p>
      </motion.div>

      {lesson.objectives?.length > 0 && (
        <div className="card p-5">
          <h3 className="mb-2 flex items-center gap-2 font-bold">
            <Target size={17} className="text-eleven-500" /> أهداف التعلم
          </h3>
          <ul className="space-y-1.5 text-sm text-gray-600 dark:text-gray-400">
            {lesson.objectives.map((o, i) => (
              <li key={i} className="flex items-start gap-2">
                <CheckCircle2 size={14} className="mt-0.5 shrink-0 text-eleven-500" /> {o}
              </li>
            ))}
          </ul>
        </div>
      )}

      <div className="card p-5">
        <h3 className="mb-2 font-bold">💡 الشرح</h3>
        <p className="leading-8 text-gray-700 dark:text-gray-300">{lesson.content.explanation}</p>
      </div>

      {lesson.content.code_examples?.map((ex, i) => (
        <div key={i} className="space-y-2">
          <CodeRunner initialCode={ex.code} />
          <p className="text-sm leading-7 text-gray-600 dark:text-gray-400">{ex.explanation}</p>
        </div>
      ))}

      {lesson.content.common_mistakes?.length > 0 && (
        <div className="card border-orange-500/20 bg-orange-500/5 p-5">
          <h3 className="mb-2 flex items-center gap-2 font-bold text-orange-600 dark:text-orange-400">
            <AlertTriangle size={17} /> أخطاء شائعة
          </h3>
          <ul className="list-inside list-disc space-y-1 text-sm text-gray-700 dark:text-gray-300">
            {lesson.content.common_mistakes.map((m, i) => (
              <li key={i}>{m}</li>
            ))}
          </ul>
        </div>
      )}

      {lesson.content.tips?.length > 0 && (
        <div className="card border-eleven-500/20 bg-eleven-500/5 p-5">
          <h3 className="mb-2 flex items-center gap-2 font-bold text-eleven-600 dark:text-eleven-400">
            <Lightbulb size={17} /> نصائح
          </h3>
          <ul className="list-inside list-disc space-y-1 text-sm text-gray-700 dark:text-gray-300">
            {lesson.content.tips.map((t, i) => (
              <li key={i}>{t}</li>
            ))}
          </ul>
        </div>
      )}

      {lesson.content.challenge && (
        <div className="card p-5">
          <h3 className="mb-2 font-bold">🎯 Challenge</h3>
          <p className="mb-3 text-sm text-gray-600 dark:text-gray-400">{lesson.content.challenge.prompt}</p>
          <CodeRunner initialCode={lesson.content.challenge.starter_code} height="140px" />
        </div>
      )}

      <QuizWidget lessonId={lesson.id} quizzes={quizzes} />

      {!completed ? (
        <button onClick={handleComplete} disabled={marking} className="btn-primary w-full">
          {marking ? 'جارٍ الحفظ...' : `إنهاء الدرس (+${lesson.xp_reward} XP)`}
        </button>
      ) : (
        <div className="flex items-center justify-center gap-2 rounded-xl bg-eleven-500/10 p-3 font-semibold text-eleven-600 dark:text-eleven-400">
          <CheckCircle2 size={18} /> تم إنهاء هذا الدرس
        </div>
      )}

      <div className="flex items-center justify-between pt-2">
        <button
          disabled={!prevLesson}
          onClick={() => prevLesson && navigate(`/lesson/${prevLesson.id}`)}
          className="btn-secondary flex items-center gap-1.5 disabled:opacity-30"
        >
          <ArrowRight size={15} /> السابق
        </button>
        <button
          disabled={!nextLesson}
          onClick={() => nextLesson && navigate(`/lesson/${nextLesson.id}`)}
          className="btn-primary flex items-center gap-1.5 disabled:opacity-30"
        >
          التالي <ArrowLeft size={15} />
        </button>
      </div>
    </div>
  )
}
