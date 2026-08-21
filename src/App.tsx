import { Routes, Route } from 'react-router-dom'
import { Toaster } from 'react-hot-toast'
import { ProtectedRoute, AdminRoute } from '@/components/ProtectedRoute'
import { AppLayout } from '@/layouts/AppLayout'

import LandingPage from '@/pages/LandingPage'
import LoginPage from '@/pages/LoginPage'
import SignupPage from '@/pages/SignupPage'
import ForgotPasswordPage from '@/pages/ForgotPasswordPage'
import DashboardPage from '@/pages/DashboardPage'
import RoadmapPage from '@/pages/RoadmapPage'
import ChapterPage from '@/pages/ChapterPage'
import LessonPage from '@/pages/LessonPage'
import PlaygroundPage from '@/pages/PlaygroundPage'
import ProblemsPage from '@/pages/ProblemsPage'
import ProblemDetailPage from '@/pages/ProblemDetailPage'
import AchievementsPage from '@/pages/AchievementsPage'
import ProfilePage from '@/pages/ProfilePage'
import AdminDashboardPage from '@/pages/admin/AdminDashboardPage'
import NotFoundPage from '@/pages/NotFoundPage'

export default function App() {
  return (
    <>
      <Toaster position="top-center" toastOptions={{ style: { fontFamily: 'Cairo, Inter, sans-serif' } }} />
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/forgot-password" element={<ForgotPasswordPage />} />

        <Route element={<ProtectedRoute />}>
          <Route element={<AppLayout />}>
            <Route path="/dashboard" element={<DashboardPage />} />
            <Route path="/roadmap" element={<RoadmapPage />} />
            <Route path="/chapter/:chapterNumber" element={<ChapterPage />} />
            <Route path="/lesson/:lessonId" element={<LessonPage />} />
            <Route path="/playground" element={<PlaygroundPage />} />
            <Route path="/problems" element={<ProblemsPage />} />
            <Route path="/problems/:problemId" element={<ProblemDetailPage />} />
            <Route path="/achievements" element={<AchievementsPage />} />
            <Route path="/profile" element={<ProfilePage />} />

            <Route element={<AdminRoute />}>
              <Route path="/admin" element={<AdminDashboardPage />} />
            </Route>
          </Route>
        </Route>

        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </>
  )
}
