import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'
import { Flame, Zap, BookOpenCheck, Code2, ArrowLeft } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { getChapters, getUserProgress } from '@/services/content'
import { getUserSolvedProblemIds } from '@/services/content'
import type { Chapter, LessonProgress } from '@/types/database.types'

export default function DashboardPage() {
  const { profile, user } = useAuth()
  const [chapters, setChapters] = useState<Chapter[]>([])
  const [progress, setProgress] = useState<LessonProgress[]>([])
  const [solvedCount, setSolvedCount] = useState(0)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    Promise.all([getChapters(), getUserProgress(user.id), getUserSolvedProblemIds(user.id)])
      .then(([ch, prog, solved]) => {
        setChapters(ch)
        setProgress(prog)
        setSolvedCount(solved.size)
      })
      .finally(() => setLoading(false))
  }, [user])

  const completedLessons = progress.filter((p) => p.completed).length

  if (loading) return <DashboardSkeleton />

  return (
    <div className="space-y-8">
      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}>
        <h1 className="text-2xl font-extrabold">
          أهلًا بعودتك، {profile?.full_name || 'يا مبرمج'} 👋
        </h1>
        <p className="text-gray-500 dark:text-gray-400">أكمل رحلتك في تعلم Python.</p>
      </motion.div>

      <div className="grid grid-cols-2 gap-3 md:grid-cols-4">
        <StatCard icon={Zap} label="XP" value={profile?.xp ?? 0} color="text-yellow-500" />
        <StatCard icon={Flame} label="Streak" value={profile?.streak ?? 0} color="text-orange-500" />
        <StatCard icon={BookOpenCheck} label="دروس مكتملة" value={completedLessons} color="text-eleven-500" />
        <StatCard icon={Code2} label="مسائل محلولة" value={solvedCount} color="text-sky-500" />
      </div>

      <div className="card p-5">
        <div className="mb-1 flex items-center justify-between text-sm font-semibold">
          <span>Level {profile?.level ?? 1} — Python Explorer</span>
          <span className="text-gray-500">{completedLessons}/160 درس</span>
        </div>
        <div className="h-2.5 w-full overflow-hidden rounded-full bg-black/5 dark:bg-white/10">
          <motion.div
            className="h-full rounded-full bg-gradient-to-r from-eleven-400 to-eleven-600"
            initial={{ width: 0 }}
            animate={{ width: `${Math.min(100, (completedLessons / 160) * 100)}%` }}
            transition={{ duration: 0.8 }}
          />
        </div>
      </div>

      <div>
        <div className="mb-3 flex items-center justify-between">
          <h2 className="text-lg font-bold">أكمل التعلم</h2>
          <Link to="/roadmap" className="flex items-center gap-1 text-sm font-semibold text-eleven-600 dark:text-eleven-400">
            كل الفصول <ArrowLeft size={14} />
          </Link>
        </div>
        <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
          {chapters.slice(0, 6).map((c) => (
            <Link
              key={c.id}
              to={`/chapter/${c.chapter_number}`}
              className="card flex items-center gap-3 p-4 transition hover:-translate-y-0.5 hover:shadow-md"
            >
              <span className="text-2xl">{c.icon}</span>
              <div>
                <p className="text-xs text-gray-500">فصل {c.chapter_number}</p>
                <p className="font-semibold">{c.title}</p>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  )
}

function StatCard({ icon: Icon, label, value, color }: { icon: any; label: string; value: number; color: string }) {
  return (
    <div className="card p-4">
      <Icon className={color} size={20} />
      <p className="mt-2 text-xl font-extrabold">{value}</p>
      <p className="text-xs text-gray-500 dark:text-gray-400">{label}</p>
    </div>
  )
}

function DashboardSkeleton() {
  return (
    <div className="space-y-8 animate-pulse">
      <div className="h-8 w-64 rounded-lg bg-black/5 dark:bg-white/5" />
      <div className="grid grid-cols-2 gap-3 md:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="h-24 rounded-2xl bg-black/5 dark:bg-white/5" />
        ))}
      </div>
      <div className="h-20 rounded-2xl bg-black/5 dark:bg-white/5" />
    </div>
  )
}
