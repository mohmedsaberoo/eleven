import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { CheckCircle2, Circle } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { getProblems, getUserSolvedProblemIds } from '@/services/content'
import type { Problem } from '@/types/database.types'

export default function ProblemsPage() {
  const { user } = useAuth()
  const [problems, setProblems] = useState<Problem[]>([])
  const [solved, setSolved] = useState<Set<string>>(new Set())
  const [filter, setFilter] = useState<'all' | 'easy' | 'hard'>('all')
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    Promise.all([getProblems(), getUserSolvedProblemIds(user.id)])
      .then(([p, s]) => {
        setProblems(p)
        setSolved(s)
      })
      .finally(() => setLoading(false))
  }, [user])

  const filtered = problems.filter(
    (p) => (filter === 'all' || p.difficulty === filter) && p.title.includes(search)
  )

  if (loading) {
    return (
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="h-24 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />
        ))}
      </div>
    )
  }

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-2xl font-extrabold">🎯 Problem Solving</h1>
        <p className="text-gray-500 dark:text-gray-400">
          حللت {solved.size} من {problems.length} مسألة متاحة.
        </p>
      </div>

      <div className="flex flex-wrap items-center gap-2">
        <input value={search} onChange={(e) => setSearch(e.target.value)} placeholder="ابحث عن مسألة..." className="input max-w-xs" />
        {(['all', 'easy', 'hard'] as const).map((f) => (
          <button
            key={f}
            onClick={() => setFilter(f)}
            className={`rounded-full px-4 py-2 text-sm font-semibold ${
              filter === f ? 'bg-eleven-500 text-white' : 'bg-black/5 text-gray-600 dark:bg-white/5 dark:text-gray-300'
            }`}
          >
            {f === 'all' ? 'الكل' : f === 'easy' ? 'Easy' : 'Hard'}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
        {filtered.map((p) => (
          <Link key={p.id} to={`/problems/${p.id}`} className="card flex items-center gap-3 p-4 hover:-translate-y-0.5 hover:shadow-md">
            {solved.has(p.id) ? <CheckCircle2 className="text-eleven-500" size={20} /> : <Circle className="text-gray-400" size={20} />}
            <div className="min-w-0 flex-1">
              <p className="truncate font-semibold">
                #{p.problem_number} {p.title}
              </p>
              <p className="mt-0.5 flex items-center gap-2 text-xs text-gray-500">
                <span
                  className={`rounded-full px-2 py-0.5 font-semibold ${
                    p.difficulty === 'easy' ? 'bg-eleven-500/10 text-eleven-600' : 'bg-red-500/10 text-red-500'
                  }`}
                >
                  {p.difficulty === 'easy' ? 'Easy' : 'Hard'}
                </span>
                <span>⚡ {p.xp} XP</span>
              </p>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}
