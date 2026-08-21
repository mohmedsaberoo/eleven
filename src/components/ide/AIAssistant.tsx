import { useMemo, useState } from 'react'
import { ArrowRight, Bot, BrainCircuit, Check, Lightbulb, MessageSquareText, Sparkles, Wand2 } from 'lucide-react'
import { askAIAssistant, type AIAssistantAction } from '@/services/aiAssistant'

interface AIAssistantProps {
  code: string
  output: string
  error: string | null
  lessonName?: string
  chapterName?: string
  challengePrompt?: string
  onApplySuggestion?: (nextCode: string) => void
}

function extractPythonOnly(value: string) {
  const match = value.match(/```(?:python)?\s*([\s\S]*?)```/i)
  return match?.[1]?.trim() || value.trim()
}

export function AIAssistant({
  code,
  output,
  error,
  lessonName,
  chapterName,
  challengePrompt,
  onApplySuggestion,
}: AIAssistantProps) {
  const [loading, setLoading] = useState(false)
  const [answer, setAnswer] = useState('')
  const [suggestion, setSuggestion] = useState<string | null>(null)
  const [question, setQuestion] = useState('')

  const actions = useMemo(
    () => [
      { id: 'explain' as const, label: 'Explain Code', icon: BrainCircuit },
      { id: 'fix_error' as const, label: 'Fix Error', icon: Wand2 },
      { id: 'improve_code' as const, label: 'Improve Code', icon: Sparkles },
      { id: 'custom' as const, label: 'Ask AI', icon: MessageSquareText },
    ],
    [],
  )

  const runAction = async (action: AIAssistantAction) => {
    setLoading(true)
    setAnswer('')
    setSuggestion(null)

    const response = await askAIAssistant({
      action,
      code,
      output,
      error,
      lessonName,
      chapterName,
      challengePrompt,
      question: action === 'custom' ? (question || 'Explain this Python code for a beginner.') : undefined,
    })

    setAnswer(response.answer)
    setSuggestion(response.suggestion ?? null)
    setLoading(false)
  }

  const applySuggestion = () => {
    if (!suggestion) return
    onApplySuggestion?.(extractPythonOnly(suggestion))
  }

  return (
    <div className="border-t border-slate-200 bg-slate-50/80 dark:border-slate-700 dark:bg-slate-950/60">
      <div className="flex items-center justify-between gap-3 border-b border-slate-200 px-3 py-2 dark:border-slate-700">
        <div className="flex items-center gap-2">
          <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-eleven-500/10 text-eleven-600 dark:text-eleven-300">
            <Bot size={15} />
          </div>
          <div>
            <p className="text-[10px] font-bold uppercase tracking-[0.14em] text-slate-500 dark:text-slate-400">Claude AI Tutor</p>
            <p className="text-xs font-semibold text-slate-700 dark:text-slate-200">Python for beginners</p>
          </div>
        </div>
      </div>

      <div className="space-y-3 p-3">
        <div className="flex flex-wrap gap-2">
          {actions.map(({ id, label, icon: Icon }) => (
            <button
              key={id}
              type="button"
              onClick={() => runAction(id)}
              disabled={loading}
              className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-semibold text-slate-700 transition hover:bg-slate-100 disabled:cursor-not-allowed disabled:opacity-60 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
            >
              <Icon size={12} />
              {label}
            </button>
          ))}
        </div>

        <div className="space-y-2">
          <textarea
            value={question}
            onChange={(event) => setQuestion(event.target.value)}
            rows={3}
            placeholder="Ask a Python question for this lesson..."
            className="w-full rounded-xl border border-slate-200 bg-white px-3 py-2 text-sm text-slate-700 outline-none transition focus:border-eleven-500 focus:ring-2 focus:ring-eleven-500/20 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-100"
          />

          <button
            type="button"
            onClick={() => runAction('custom')}
            disabled={loading}
            className="inline-flex items-center gap-1.5 rounded-lg bg-eleven-500 px-3 py-2 text-xs font-semibold text-white transition hover:bg-eleven-600 disabled:cursor-not-allowed disabled:opacity-60"
          >
            <ArrowRight size={12} />
            Ask AI
          </button>
        </div>

        {loading && (
          <div className="rounded-xl border border-dashed border-eleven-500/30 bg-eleven-500/5 px-3 py-3 text-sm text-slate-700 dark:text-slate-200">
            I’m checking your current code, output, and lesson context to explain it clearly.
          </div>
        )}

        {answer && (
          <div className="rounded-xl border border-slate-200 bg-white p-3 text-sm leading-7 text-slate-700 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200">
            <div className="mb-2 flex items-center gap-2 text-[10px] font-bold uppercase tracking-[0.14em] text-eleven-600 dark:text-eleven-400">
              <Lightbulb size={12} /> Explanation
            </div>
            <div className="whitespace-pre-wrap">{answer}</div>
          </div>
        )}

        {suggestion && (
          <div className="space-y-2 rounded-xl border border-emerald-200 bg-emerald-50 p-3 dark:border-emerald-900/60 dark:bg-emerald-950/20">
            <div className="flex items-center gap-2 text-[10px] font-bold uppercase tracking-[0.14em] text-emerald-700 dark:text-emerald-300">
              <Sparkles size={12} /> Suggested Update
            </div>
            <pre className="max-h-44 overflow-auto whitespace-pre-wrap break-words rounded-lg bg-slate-950 p-3 font-mono text-[11px] leading-6 text-slate-100">
              {suggestion}
            </pre>
            <button
              type="button"
              onClick={applySuggestion}
              className="inline-flex items-center gap-1.5 rounded-lg bg-emerald-600 px-3 py-2 text-xs font-semibold text-white transition hover:bg-emerald-500"
            >
              <Check size={12} />
              Apply to IDE
            </button>
          </div>
        )}
      </div>
    </div>
  )
}
