import { useState, type FormEvent } from 'react'
import toast from 'react-hot-toast'
import { useAuth } from '@/contexts/AuthContext'
import { supabase } from '@/lib/supabase'
import { BackButton } from '@/components/common/BackButton'

export default function ProfilePage() {
  const { user, profile, refreshProfile } = useAuth()
  const [fullName, setFullName] = useState(profile?.full_name ?? '')
  const [saving, setSaving] = useState(false)

  const handleSave = async (e: FormEvent) => {
    e.preventDefault()
    if (!user) return
    setSaving(true)
    const { error } = await supabase.from('profiles').update({ full_name: fullName }).eq('id', user.id)
    setSaving(false)
    if (error) {
      toast.error('تعذّر حفظ التعديلات')
      return
    }
    await refreshProfile()
    toast.success('تم تحديث الملف الشخصي')
  }

  if (!profile) return null

  return (
    <div className="mx-auto max-w-xl space-y-6">
      <BackButton to="/dashboard" label="العودة إلى لوحة التحكم" />
      <h1 className="text-2xl font-extrabold">حسابي</h1>

      <div className="card flex items-center gap-4 p-5">
        <div className="flex h-16 w-16 items-center justify-center rounded-full bg-eleven-500/10 text-2xl font-extrabold text-eleven-600 dark:text-eleven-400">
          {profile.full_name?.[0]?.toUpperCase() || '🐍'}
        </div>
        <div>
          <p className="font-bold">{profile.full_name || 'طالب Eleven'}</p>
          <p className="text-sm text-gray-500 dark:text-gray-400">{user?.email}</p>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
        <StatBox label="Level" value={profile.level} />
        <StatBox label="XP" value={profile.xp} />
        <StatBox label="Streak" value={profile.streak} />
        <StatBox label="الدور" value={profile.role === 'admin' ? 'Admin' : 'Student'} />
      </div>

      <form onSubmit={handleSave} className="card space-y-4 p-5">
        <h3 className="font-bold">تعديل الاسم</h3>
        <input value={fullName} onChange={(e) => setFullName(e.target.value)} className="input" />
        <button disabled={saving} className="btn-primary">
          {saving ? 'جارٍ الحفظ...' : 'حفظ التعديلات'}
        </button>
      </form>
    </div>
  )
}

function StatBox({ label, value }: { label: string; value: string | number }) {
  return (
    <div className="card p-4 text-center">
      <p className="text-xl font-extrabold">{value}</p>
      <p className="text-xs text-gray-500 dark:text-gray-400">{label}</p>
    </div>
  )
}
