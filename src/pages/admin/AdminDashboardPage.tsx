import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'
import { Users, BookOpenCheck, Code2, TrendingUp } from 'lucide-react'

interface AdminStats {
  totalUsers: number
  completedLessons: number
  problemsSolved: number
  avgProgress: number
  recentUsers: { full_name: string; created_at: string; xp: number }[]
}

export default function AdminDashboardPage() {
  const [stats, setStats] = useState<AdminStats | null>(null)

  useEffect(() => {
    async function load() {
      const [{ count: totalUsers }, { count: completedLessons }, { count: problemsSolved }, { data: recentUsers }, { count: totalLessons }] =
        await Promise.all([
          supabase.from('profiles').select('*', { count: 'exact', head: true }),
          supabase.from('lesson_progress').select('*', { count: 'exact', head: true }).eq('completed', true),
          supabase.from('problem_submissions').select('*', { count: 'exact', head: true }).eq('status', 'passed'),
          supabase.from('profiles').select('full_name, created_at, xp').order('created_at', { ascending: false }).limit(8),
          supabase.from('lessons').select('*', { count: 'exact', head: true }),
        ])

      const avgProgress =
        totalUsers && totalLessons ? Math.round(((completedLessons ?? 0) / (totalUsers * totalLessons)) * 100) : 0

      setStats({
        totalUsers: totalUsers ?? 0,
        completedLessons: completedLessons ?? 0,
        problemsSolved: problemsSolved ?? 0,
        avgProgress,
        recentUsers: recentUsers ?? [],
      })
    }
    load()
  }, [])

  if (!stats) return <div className="h-64 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-extrabold">🛠️ Admin Dashboard</h1>

      <div className="grid grid-cols-2 gap-3 md:grid-cols-4">
        <AdminStat icon={Users} label="Total Users" value={stats.totalUsers} />
        <AdminStat icon={BookOpenCheck} label="Completed Lessons" value={stats.completedLessons} />
        <AdminStat icon={Code2} label="Problems Solved" value={stats.problemsSolved} />
        <AdminStat icon={TrendingUp} label="Average Progress" value={`${stats.avgProgress}%`} />
      </div>

      <div className="card p-5">
        <h3 className="mb-3 font-bold">Recent Users</h3>
        <div className="space-y-2">
          {stats.recentUsers.map((u, i) => (
            <div key={i} className="flex items-center justify-between rounded-lg bg-black/[0.02] px-3 py-2 text-sm dark:bg-white/[0.02]">
              <span>{u.full_name || 'مستخدم بدون اسم'}</span>
              <span className="text-xs text-gray-500">⚡ {u.xp} XP</span>
            </div>
          ))}
        </div>
      </div>

      <p className="text-xs text-gray-500">
        لإدارة الفصول/الدروس/المسائل بشكل كامل (إضافة/تعديل/حذف)، استخدم Supabase Table Editor مباشرة أو وسّع هذه
        الصفحة بنماذج CRUD — كل الجداول محمية بالفعل بصلاحيات RLS الخاصة بـ Admin فقط.
      </p>
    </div>
  )
}

function AdminStat({ icon: Icon, label, value }: { icon: any; label: string; value: string | number }) {
  return (
    <div className="card p-4">
      <Icon className="text-eleven-500" size={20} />
      <p className="mt-2 text-xl font-extrabold">{value}</p>
      <p className="text-xs text-gray-500 dark:text-gray-400">{label}</p>
    </div>
  )
}
