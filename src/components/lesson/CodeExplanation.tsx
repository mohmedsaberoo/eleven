interface CodeExplanationStep {
  label: string
  text: string
}

interface CodeExplanationProps {
  steps: CodeExplanationStep[]
}

export function CodeExplanation({ steps }: CodeExplanationProps) {
  return (
    <div className="space-y-3 rounded-2xl border border-black/10 bg-black/[0.02] p-4 dark:border-white/10 dark:bg-white/[0.02]">
      <h4 className="text-sm font-bold uppercase tracking-[0.12em] text-gray-600 dark:text-gray-300">شرح الكود</h4>
      <ol className="space-y-3">
        {steps.map((step, index) => (
          <li key={`${step.label}-${index}`} className="flex gap-3">
            <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-eleven-500/15 text-xs font-bold text-eleven-600 dark:text-eleven-300">
              {index + 1}
            </span>
            <div className="min-w-0 flex-1 rounded-xl border border-black/5 bg-white p-3 text-sm leading-7 text-gray-700 dark:border-white/10 dark:bg-slate-900 dark:text-gray-200">
              <span className="font-bold text-eleven-600 dark:text-eleven-300">{step.label}</span>
              <span className="text-gray-600 dark:text-gray-300"> {step.text}</span>
            </div>
          </li>
        ))}
      </ol>
    </div>
  )
}
