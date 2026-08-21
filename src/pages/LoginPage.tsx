import { useState, type FormEvent } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import toast from 'react-hot-toast'
import { z } from 'zod'
import { useAuth } from '@/contexts/AuthContext'
import { AuthShell } from '@/components/layout/AuthShell'

const schema = z.object({
  email: z.string().email('بريد إلكتروني غير صالح'),
  password: z.string().min(6, 'كلمة المرور 6 أحرف على الأقل'),
})

export default function LoginPage() {
  const { signIn } = useAuth()
  const navigate = useNavigate()
  const [form, setForm] = useState({ email: '', password: '' })
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
    const { error } = await signIn(form.email, form.password)
    setLoading(false)
    if (error) {
      toast.error('فشل تسجيل الدخول: تحقق من البريد وكلمة المرور')
      return
    }
    toast.success('تم تسجيل الدخول بنجاح 🎉')
    navigate('/dashboard')
  }

  return (
    <AuthShell title="تسجيل الدخول" subtitle="أكمل رحلتك في تعلم Python">
      <form onSubmit={onSubmit} className="space-y-4">
        <Field label="البريد الإلكتروني" error={errors.email}>
          <input
            type="email"
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
            className="input"
            placeholder="you@example.com"
          />
        </Field>
        <Field label="كلمة المرور" error={errors.password}>
          <input
            type="password"
            value={form.password}
            onChange={(e) => setForm({ ...form, password: e.target.value })}
            className="input"
            placeholder="••••••••"
          />
        </Field>
        <div className="text-left">
          <Link to="/forgot-password" className="text-xs font-medium text-eleven-600 hover:underline dark:text-eleven-400">
            نسيت كلمة المرور؟
          </Link>
        </div>
        <button disabled={loading} className="btn-primary w-full">
          {loading ? 'جارٍ الدخول...' : 'دخول'}
        </button>
      </form>
      <p className="mt-6 text-center text-sm text-gray-500 dark:text-gray-400">
        ليس لديك حساب؟{' '}
        <Link to="/signup" className="font-semibold text-eleven-600 dark:text-eleven-400">
          أنشئ حسابًا
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
