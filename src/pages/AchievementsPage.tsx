import { useEffect, useState } from 'react'
import { Lock } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { getAllAchievements, getUserAchievements } from '@/services/content'
import type { Achievement } from '@/types/database.types'

export default function AchievementsPage() {
  const { user } = useAuth()
  const [all, setAll] = useState<Achievement[]>([])
  const [unlockedIds, setUnlockedIds] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    Promise.all([getAllAchievements(), getUserAchievements(user.id)])
      .then(([a, ua]) => {
        setAll(a)
        setUnlockedIds(new Set(ua.map((u) => u.achievement_id)))
      })
      .finally(() => setLoading(false))
  }, [user])

  if (loading) {
    return (
      <div className="grid grid-cols-2 gap-3 md:grid-cols-3">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="h-32 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />
        ))}
      </div>
    )
  }

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-2xl font-extrabold">🏆 الإنجازات</h1>
        <p className="text-gray-500 dark:text-gray-400">
          فتحت {unlockedIds.size} من {all.length} إنجازًا.
        </p>
      </div>
      <div className="grid grid-cols-2 gap-3 md:grid-cols-3">
        {all.map((a) => {
          const unlocked = unlockedIds.has(a.id)
          return (
            <div key={a.id} className={`card flex flex-col items-center p-5 text-center ${!unlocked && 'opacity-50'}`}>
              <span className="text-4xl">{unlocked ? a.icon : <Lock size={32} className="text-gray-400" />}</span>
              <p className="mt-2 font-bold">{a.title}</p>
              <p className="mt-1 text-xs text-gray-500 dark:text-gray-400">{a.description}</p>
            </div>
          )
        })}
      </div>
    </div>
  )
}
