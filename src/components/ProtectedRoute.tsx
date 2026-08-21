import { Navigate, Outlet } from 'react-router-dom'
import { useAuth } from '@/contexts/AuthContext'

export function ProtectedRoute() {
  const { user, loading } = useAuth()
  if (loading) return <FullScreenLoader />
  if (!user) return <Navigate to="/login" replace />
  return <Outlet />
}

export function AdminRoute() {
  const { isAdmin, loading, user } = useAuth()
  if (loading) return <FullScreenLoader />
  if (!user) return <Navigate to="/login" replace />
  if (!isAdmin) return <Navigate to="/dashboard" replace />
  return <Outlet />
}

export function FullScreenLoader() {
  return (
    <div className="flex h-screen w-full items-center justify-center bg-white dark:bg-night-950">
      <div className="h-10 w-10 animate-spin rounded-full border-4 border-eleven-500 border-t-transparent" />
    </div>
  )
}
