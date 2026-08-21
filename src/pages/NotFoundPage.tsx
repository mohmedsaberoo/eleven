import { Link } from 'react-router-dom'

export default function NotFoundPage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-4 bg-white text-center dark:bg-night-950">
      <p className="text-6xl">🐍</p>
      <h1 className="text-2xl font-bold">404 — الصفحة غير موجودة</h1>
      <Link to="/" className="btn-primary">
        العودة للرئيسية
      </Link>
    </div>
  )
}
