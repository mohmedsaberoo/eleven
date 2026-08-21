import { ArrowLeft } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

interface BackButtonProps {
  to?: string
  label?: string
  className?: string
}

export function BackButton({ to, label = 'العودة', className = '' }: BackButtonProps) {
  const navigate = useNavigate()

  const handleClick = () => {
    if (to) {
      navigate(to)
      return
    }
    navigate(-1)
  }

  return (
    <button
      type="button"
      onClick={handleClick}
      className={`inline-flex items-center gap-2 rounded-full border border-black/10 bg-white px-3 py-2 text-sm font-semibold text-gray-700 transition hover:bg-black/5 focus:outline-none focus:ring-2 focus:ring-eleven-500/40 dark:border-white/10 dark:bg-slate-900 dark:text-gray-200 dark:hover:bg-white/5 ${className}`}
      aria-label={label}
    >
      <ArrowLeft size={16} />
      <span>{label}</span>
    </button>
  )
}
