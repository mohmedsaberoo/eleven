import { Check, Copy } from 'lucide-react'
import { useState } from 'react'

interface CodeBlockProps {
  code: string
  title?: string
}

const KEYWORDS = /\b(def|return|print\(|input\(|if|else|for|while|len\(|range\(|in|not|and|or|True|False|None|class|try|except|import|from|as)\b/g
const STRINGS = /("[^"]*"|'[^']*')/g
const NUMBERS = /\b\d+(?:\.\d+)?\b/g

function highlightCode(value: string) {
  const escaped = value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')

  const withStrings = escaped.replace(STRINGS, '<span class="text-amber-500">$1</span>')
  const withNumbers = withStrings.replace(NUMBERS, '<span class="text-sky-500">$1</span>')
  const withKeywords = withNumbers.replace(KEYWORDS, '<span class="text-violet-500 font-semibold">$1</span>')

  return withKeywords
}

export function CodeBlock({ code, title = 'Python' }: CodeBlockProps) {
  const [copied, setCopied] = useState(false)

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(code)
      setCopied(true)
      window.setTimeout(() => setCopied(false), 1200)
    } catch {
      // no-op if clipboard is unavailable
    }
  }

  return (
    <div className="overflow-hidden rounded-2xl border border-black/10 bg-slate-950 text-slate-50 shadow-sm dark:border-white/10">
      <div className="flex items-center justify-between border-b border-white/10 bg-slate-900 px-3 py-2 text-[10px] font-bold uppercase tracking-[0.14em] text-slate-300">
        <span>{title}</span>
        <button
          type="button"
          onClick={handleCopy}
          className="inline-flex items-center gap-1 rounded-md border border-white/10 bg-slate-800 px-2 py-1 text-[10px] font-semibold text-slate-200 transition hover:bg-slate-700"
          aria-label="Copy code"
        >
          {copied ? <Check size={11} /> : <Copy size={11} />}
          {copied ? 'تم النسخ' : 'نسخ'}
        </button>
      </div>
      <pre
        dir="ltr"
        className="overflow-x-auto p-8 font-mono text-lg leading-8 text-slate-100"
        dangerouslySetInnerHTML={{ __html: highlightCode(code) }}
      />
    </div>
  )
}
