import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Lock, CheckCircle2, PlayCircle } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { getChapters, getUserProgress } from '@/services/content'
import { supabase } from '@/lib/supabase'
import type { Chapter } from '@/types/database.types'

interface ChapterStat {
  chapter: Chapter
  totalLessons: number
  completedLessons: number
}

export default function RoadmapPage() {
  const { user } = useAuth()
  const [stats, setStats] = useState<ChapterStat[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')

  useEffect(() => {
    if (!user) return
    async function load() {
      const [chapters, progress, { data: lessons }] = await Promise.all([
        getChapters(),
        getUserProgress(user!.id),
        supabase.from('lessons').select('id, chapter_id'),
      ])
      const completedLessonIds = new Set(progress.filter((p) => p.completed).map((p) => p.lesson_id))
      const rows: ChapterStat[] = chapters.map((c) => {
        const chapterLessons = (lessons ?? []).filter((l: any) => l.chapter_id === c.id)
        const completed = chapterLessons.filter((l: any) => completedLessonIds.has(l.id)).length
        return { chapter: c, totalLessons: chapterLessons.length, completedLessons: completed }
      })
      setStats(rows)
      setLoading(false)
    }
    load()
  }, [user])

  const filtered = useMemo(
    () => stats.filter((s) => s.chapter.title.includes(search) || String(s.chapter.chapter_number).includes(search)),
    [stats, search]
  )

  // A chapter unlocks once the previous chapter (that actually has lessons) is fully completed.
  const isUnlocked = (index: number) => {
    if (index === 0) return true
    const prev = stats[index - 1]
    if (!prev) return true
    if (prev.totalLessons === 0) return true // chapters without seeded lessons yet don't block progress
    return prev.completedLessons >= prev.totalLessons
  }

  if (loading) {
    return (
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 9 }).map((_, i) => (
          <div key={i} className="h-28 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />
        ))}
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-extrabold">🗺️ خارطة تعلم Python</h1>
        <p className="text-gray-500 dark:text-gray-400">20 فصلًا يأخذك من الصفر حتى البرمجة الكائنية.</p>
      </div>
      <input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="ابحث عن فصل..."
        className="input max-w-sm"
      />
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {filtered.map((s) => {
          const idx = stats.indexOf(s)
          const unlocked = isUnlocked(idx)
          const done = s.totalLessons > 0 && s.completedLessons >= s.totalLessons
          const CardInner = (
            <div
              className={`card relative flex items-start gap-3 p-4 transition ${
                unlocked ? 'hover:-translate-y-0.5 hover:shadow-md' : 'opacity-50'
              }`}
            >
              <span className="text-2xl">{s.chapter.icon}</span>
              <div className="min-w-0 flex-1">
                <p className="text-xs text-gray-500">فصل {s.chapter.chapter_number} • {s.chapter.stage}</p>
                <p className="truncate font-semibold">{s.chapter.title}</p>
                {s.totalLessons > 0 && (
                  <p className="mt-1 text-xs text-gray-500">
                    {s.completedLessons}/{s.totalLessons} دروس
                  </p>
                )}
              </div>
              <span className="shrink-0">
                {!unlocked ? (
                  <Lock size={18} className="text-gray-400" />
                ) : done ? (
                  <CheckCircle2 size={18} className="text-eleven-500" />
                ) : (
                  <PlayCircle size={18} className="text-eleven-500" />
                )}
              </span>
            </div>
          )
          return unlocked ? (
            <Link key={s.chapter.id} to={`/chapter/${s.chapter.chapter_number}`}>
              {CardInner}
            </Link>
          ) : (
            <div key={s.chapter.id}>{CardInner}</div>
          )
        })}
      </div>
    </div>
  )
}
