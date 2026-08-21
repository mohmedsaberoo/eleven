import { Link } from 'react-router-dom'
import type { ReactNode } from 'react'

export function AuthShell({ title, subtitle, children }: { title: string; subtitle: string; children: ReactNode }) {
  return (
    <div className="flex min-h-screen items-center justify-center bg-white px-4 dark:bg-night-950">
      <div className="w-full max-w-md">
        <Link to="/" className="mb-8 flex items-center justify-center gap-2 text-2xl font-extrabold">
          <span className="text-gradient">ELEVEN</span> <span>🐍</span>
        </Link>
        <div className="rounded-2xl border border-black/5 bg-black/[0.015] p-8 shadow-sm dark:border-white/5 dark:bg-white/[0.02]">
          <h1 className="mb-1 text-2xl font-bold">{title}</h1>
          <p className="mb-6 text-sm text-gray-500 dark:text-gray-400">{subtitle}</p>
          {children}
        </div>
      </div>
    </div>
  )
}
