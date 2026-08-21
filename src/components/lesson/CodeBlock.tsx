import { Check, Copy } from 'lucide-react'
import { useState } from 'react'

interface CodeBlockProps {
  code: string
  title?: string
}

export function CodeBlock({ code, title = 'Python' }: CodeBlockProps) {
  const [copied, setCopied] = useState(false)

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(code)
      setCopied(true)
      window.setTimeout(() => setCopied(false), 1200)
    } catch {
      // Clipboard unavailable
    }
  }

  return (
    <div className="overflow-hidden rounded-2xl border border-black/10 bg-slate-950 text-slate-50 shadow-sm dark:border-white/10">
      {/* Header */}
      <div className="flex items-center justify-between border-b border-white/10 bg-slate-900 px-4 py-3">
        <span className="text-xs font-bold tracking-wide text-slate-300">
          {title}
        </span>

        <button
          type="button"
          onClick={handleCopy}
          className="inline-flex items-center gap-2 rounded-lg border border-white/10 bg-slate-800 px-3 py-1.5 text-xs font-semibold text-slate-200 transition hover:bg-slate-700"
          aria-label="نسخ الكود"
        >
          {copied ? <Check size={14} /> : <Copy size={14} />}
          {copied ? 'تم النسخ' : 'نسخ'}
        </button>
      </div>

      {/* Code */}
      <pre
        dir="ltr"
        className="overflow-x-auto p-6 font-mono text-base leading-8 text-slate-100"
      >
        <code>{code}</code>
      </pre>
    </div>
  )
}