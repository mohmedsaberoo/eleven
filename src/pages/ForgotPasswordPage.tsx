import { useState, type FormEvent } from 'react'
import { Link } from 'react-router-dom'
import toast from 'react-hot-toast'
import { useAuth } from '@/contexts/AuthContext'
import { AuthShell } from '@/components/layout/AuthShell'

export default function ForgotPasswordPage() {
  const { requestPasswordReset } = useAuth()
  const [email, setEmail] = useState('')
  const [sent, setSent] = useState(false)
  const [loading, setLoading] = useState(false)

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setLoading(true)
    const { error } = await requestPasswordReset(email)
    setLoading(false)
    if (error) {
      toast.error('حدث خطأ، حاول مجددًا')
      return
    }
    setSent(true)
  }

  return (
    <AuthShell title="استعادة كلمة المرور" subtitle="سنرسل لك رابط إعادة تعيين على بريدك">
      {sent ? (
        <p className="rounded-xl bg-eleven-500/10 p-4 text-sm text-eleven-700 dark:text-eleven-300">
          إذا كان هذا البريد مسجّلًا لدينا، فستصلك رسالة تحتوي رابط إعادة تعيين كلمة المرور خلال دقائق.
        </p>
      ) : (
        <form onSubmit={onSubmit} className="space-y-4">
          <label className="block">
            <span className="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">البريد الإلكتروني</span>
            <input type="email" required value={email} onChange={(e) => setEmail(e.target.value)} className="input" placeholder="you@example.com" />
          </label>
          <button disabled={loading} className="btn-primary w-full">
            {loading ? 'جارٍ الإرسال...' : 'إرسال رابط الاستعادة'}
          </button>
        </form>
      )}
      <p className="mt-6 text-center text-sm text-gray-500 dark:text-gray-400">
        <Link to="/login" className="font-semibold text-eleven-600 dark:text-eleven-400">
          العودة لتسجيل الدخول
        </Link>
      </p>
    </AuthShell>
  )
}
