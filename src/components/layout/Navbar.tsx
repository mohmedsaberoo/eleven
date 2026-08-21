import { NavLink, useNavigate } from 'react-router-dom'
import { Home, BookOpen, Code2, Trophy, User, Sun, Moon, LogOut, Terminal } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { useTheme } from '@/contexts/ThemeContext'
import clsx from 'clsx'

const links = [
  { to: '/dashboard', label: 'الرئيسية', icon: Home },
  { to: '/roadmap', label: 'التعلم', icon: BookOpen },
  { to: '/ai-assistant', label: 'مساعد Eleven AI', icon: Terminal },
  { to: '/problems', label: 'المسائل', icon: Code2 },
  { to: '/playground', label: 'Playground', icon: Terminal },
  { to: '/achievements', label: 'الإنجازات', icon: Trophy },
  { to: '/profile', label: 'حسابي', icon: User },
]

export function Navbar() {
  const { profile, signOut } = useAuth()
  const { theme, toggleTheme } = useTheme()
  const navigate = useNavigate()

  return (
    <>
      {/* Desktop top nav */}
      <header className="sticky top-0 z-40 hidden border-b border-black/5 bg-white/80 glass dark:border-white/5 dark:bg-night-950/80 md:block">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-3">
          <NavLink to="/dashboard" className="flex items-center gap-2 text-xl font-extrabold">
            <span className="text-gradient">ELEVEN</span>
            <span className="text-lg">🐍</span>
          </NavLink>
          <nav className="flex items-center gap-1">
            {links.map((l) => (
              <NavLink
                key={l.to}
                to={l.to}
                className={({ isActive }) =>
                  clsx(
                    'flex items-center gap-1.5 rounded-full px-3.5 py-2 text-sm font-medium transition-colors',
                    isActive
                      ? 'bg-eleven-500/10 text-eleven-600 dark:text-eleven-400'
                      : 'text-gray-600 hover:bg-black/5 dark:text-gray-300 dark:hover:bg-white/5'
                  )
                }
              >
                <l.icon size={16} /> {l.label}
              </NavLink>
            ))}
          </nav>
          <div className="flex items-center gap-3">
            {profile && (
              <div className="hidden items-center gap-2 rounded-full bg-black/5 px-3 py-1.5 text-xs font-semibold dark:bg-white/5 lg:flex">
                <span>⚡ {profile.xp} XP</span>
                <span className="opacity-40">•</span>
                <span>🔥 {profile.streak}</span>
              </div>
            )}
            <button
              onClick={toggleTheme}
              className="rounded-full p-2 text-gray-500 hover:bg-black/5 dark:text-gray-300 dark:hover:bg-white/5"
              aria-label="تبديل الوضع الليلي"
            >
              {theme === 'dark' ? <Sun size={18} /> : <Moon size={18} />}
            </button>
            <button
              onClick={async () => {
                await signOut()
                navigate('/')
              }}
              className="rounded-full p-2 text-gray-500 hover:bg-black/5 dark:text-gray-300 dark:hover:bg-white/5"
              aria-label="تسجيل الخروج"
            >
              <LogOut size={18} />
            </button>
          </div>
        </div>
      </header>

      {/* Mobile bottom nav */}
      <nav className="fixed bottom-0 left-0 right-0 z-40 flex justify-around border-t border-black/5 bg-white/95 glass py-1.5 dark:border-white/5 dark:bg-night-950/95 md:hidden">
        {links.map((l) => (
          <NavLink
            key={l.to}
            to={l.to}
            className={({ isActive }) =>
              clsx(
                'flex flex-col items-center gap-0.5 rounded-lg px-3 py-1.5 text-[10px] font-medium',
                isActive ? 'text-eleven-500' : 'text-gray-500 dark:text-gray-400'
              )
            }
          >
            <l.icon size={19} />
            {l.label}
          </NavLink>
        ))}
      </nav>
    </>
  )
}
