import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { CheckCircle2, Circle, Clock } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { getChapterWithLessons, getUserProgress } from '@/services/content'
import type { Chapter, Lesson, LessonProgress } from '@/types/database.types'

export default function ChapterPage() {
  const { chapterNumber } = useParams()
  const { user } = useAuth()
  const [chapter, setChapter] = useState<Chapter | null>(null)
  const [lessons, setLessons] = useState<Lesson[]>([])
  const [progress, setProgress] = useState<LessonProgress[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!chapterNumber || !user) return
    Promise.all([getChapterWithLessons(Number(chapterNumber)), getUserProgress(user.id)])
      .then(([res, prog]) => {
        setChapter(res.chapter)
        setLessons(res.lessons)
        setProgress(prog)
      })
      .finally(() => setLoading(false))
  }, [chapterNumber, user])

  if (loading) return <div className="h-48 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  if (!chapter) return <p>لم يتم العثور على هذا الفصل.</p>

  if (lessons.length === 0) {
    return (
      <div className="card p-8 text-center">
        <p className="text-3xl">{chapter.icon}</p>
        <h1 className="mt-2 text-xl font-bold">{chapter.title}</h1>
        <p className="mt-2 text-gray-500 dark:text-gray-400">
          دروس هذا الفصل قيد الإضافة حاليًا من فريق Eleven — تابعنا قريبًا.
        </p>
      </div>
    )
  }

  const isCompleted = (lessonId: string) => progress.some((p) => p.lesson_id === lessonId && p.completed)

  return (
    <div className="space-y-6">
      <div className="card p-6">
        <p className="text-sm text-gray-500">فصل {chapter.chapter_number} • {chapter.stage}</p>
        <h1 className="mt-1 flex items-center gap-2 text-2xl font-extrabold">
          <span>{chapter.icon}</span> {chapter.title}
        </h1>
        <p className="mt-2 text-gray-600 dark:text-gray-400">{chapter.description}</p>
      </div>

      <div className="space-y-3">
        {lessons.map((l, i) => {
          const done = isCompleted(l.id)
          const prevDone = i === 0 || isCompleted(lessons[i - 1].id)
          return (
            <Link
              key={l.id}
              to={prevDone ? `/lesson/${l.id}` : '#'}
              className={`card flex items-center gap-4 p-4 ${prevDone ? 'hover:-translate-y-0.5 hover:shadow-md' : 'pointer-events-none opacity-50'}`}
            >
              {done ? <CheckCircle2 className="text-eleven-500" size={22} /> : <Circle className="text-gray-400" size={22} />}
              <div className="min-w-0 flex-1">
                <p className="text-xs text-gray-500">درس {l.lesson_number}</p>
                <p className="font-semibold">{l.title}</p>
                <p className="truncate text-xs text-gray-500 dark:text-gray-400">{l.summary}</p>
              </div>
              <div className="flex items-center gap-1 text-xs text-gray-500">
                <Clock size={13} /> {l.duration_minutes} د
              </div>
            </Link>
          )
        })}
      </div>
    </div>
  )
}
