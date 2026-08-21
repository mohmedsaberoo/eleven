import { useState, type FormEvent } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import toast from 'react-hot-toast'
import { z } from 'zod'
import { useAuth } from '@/contexts/AuthContext'
import { AuthShell } from '@/components/layout/AuthShell'

const schema = z
  .object({
    fullName: z.string().min(2, 'الاسم قصير جدًا'),
    email: z.string().email('بريد إلكتروني غير صالح'),
    password: z.string().min(6, 'كلمة المرور 6 أحرف على الأقل'),
    confirmPassword: z.string(),
  })
  .refine((d) => d.password === d.confirmPassword, {
    message: 'كلمتا المرور غير متطابقتين',
    path: ['confirmPassword'],
  })

export default function SignupPage() {
  const { signUp } = useAuth()
  const navigate = useNavigate()
  const [form, setForm] = useState({ fullName: '', email: '', password: '', confirmPassword: '' })
  const [errors, setErrors] = useState<Record<string, string>>({})
  const [loading, setLoading] = useState(false)

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault()
    const parsed = schema.safeParse(form)
    if (!parsed.success) {
      const fieldErrors: Record<string, string> = {}
      parsed.error.issues.forEach((i) => (fieldErrors[i.path[0] as string] = i.message))
      setErrors(fieldErrors)
      return
    }
    setErrors({})
    setLoading(true)
    const { error } = await signUp(form.email, form.password, form.fullName)
    setLoading(false)
    if (error) {
      const e = error.toLowerCase()
      if (e.includes('already') || e.includes('duplicate') || e.includes('unique')) {
        toast.error('هذا البريد مستخدم بالفعل')
      } else if (e.includes('password') || e.includes('weak') || e.includes('length')) {
        toast.error('كلمة المرور ضعيفة أو لا تفي بالمتطلبات')
      } else if (e.includes('email') || e.includes('invalid')) {
        toast.error('البريد الإلكتروني غير صالح')
      } else if (e.includes('network') || e.includes('fetch') || e.includes('failed to fetch')) {
        toast.error('خطأ في الاتصال بـ Supabase')
      } else {
        // Generic but include server message for debugging clarity
        toast.error(error)
      }
      return
    }
    toast.success('تم إنشاء الحساب! تحقق من بريدك للتأكيد إن لزم.')
    navigate('/dashboard')
  }

  return (
    <AuthShell title="إنشاء حساب" subtitle="ابدأ رحلتك مع Python اليوم">
      <form onSubmit={onSubmit} className="space-y-4">
        <Field label="الاسم الكامل" error={errors.fullName}>
          <input value={form.fullName} onChange={(e) => setForm({ ...form, fullName: e.target.value })} className="input" placeholder="اسمك" />
        </Field>
        <Field label="البريد الإلكتروني" error={errors.email}>
          <input type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} className="input" placeholder="you@example.com" />
        </Field>
        <Field label="كلمة المرور" error={errors.password}>
          <input type="password" value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} className="input" placeholder="••••••••" />
        </Field>
        <Field label="تأكيد كلمة المرور" error={errors.confirmPassword}>
          <input type="password" value={form.confirmPassword} onChange={(e) => setForm({ ...form, confirmPassword: e.target.value })} className="input" placeholder="••••••••" />
        </Field>
        <button disabled={loading} className="btn-primary w-full">
          {loading ? 'جارٍ الإنشاء...' : 'إنشاء الحساب'}
        </button>
      </form>
      <p className="mt-6 text-center text-sm text-gray-500 dark:text-gray-400">
        لديك حساب بالفعل؟{' '}
        <Link to="/login" className="font-semibold text-eleven-600 dark:text-eleven-400">
          سجّل الدخول
        </Link>
      </p>
    </AuthShell>
  )
}

function Field({ label, error, children }: { label: string; error?: string; children: React.ReactNode }) {
  return (
    <label className="block">
      <span className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">{label}</span>
      {children}
      {error && <span className="mt-1 block text-xs text-red-500">{error}</span>}
    </label>
  )
}
