import { AlertCircle, CheckCircle2, Copy, Square, TerminalSquare } from 'lucide-react'

export type OutputTab = 'output' | 'terminal' | 'problems'

export interface IDEOutputProps {
  output: string
  terminalText: string
  error: string | null
  problems: string[]
  ready: boolean
  running: boolean
  activeTab: OutputTab
  onTabChange: (tab: OutputTab) => void
  onCopy: () => void
  onClear: () => void
  onStop: () => void
}

export function IDEOutput({
  output,
  terminalText,
  error,
  problems,
  ready,
  running,
  activeTab,
  onTabChange,
  onCopy,
  onClear,
  onStop,
}: IDEOutputProps) {
  const hasOutput = Boolean(output || error || terminalText || problems.length)
  const tabs: Array<{ id: OutputTab; label: string }> = [
    { id: 'output', label: 'OUTPUT' },
    { id: 'terminal', label: 'TERMINAL' },
    { id: 'problems', label: 'PROBLEMS' },
  ]

  const renderContent = () => {
    if (activeTab === 'terminal') {
      return (
        <pre className="max-h-56 min-h-[88px] overflow-auto whitespace-pre-wrap break-words bg-slate-950 p-3 font-mono text-xs leading-6 text-slate-100">
          {running ? 'Running Python...' : terminalText || 'No terminal output yet.'}
        </pre>
      )
    }

    if (activeTab === 'problems') {
      return (
        <div className="max-h-56 overflow-auto bg-slate-950 p-3 text-xs text-slate-100">
          {problems.map((problem, index) => (
            <div key={`${problem}-${index}`} className="mb-2 rounded-md border border-slate-700 bg-slate-900 p-2 text-slate-200">
              {problem}
            </div>
          ))}
          {!problems.length && <div className="text-slate-400">No active problems.</div>}
        </div>
      )
    }

    if (error) {
      return (
        <div className="max-h-56 overflow-auto bg-rose-500/10 p-3 text-left text-xs text-rose-100">
          <div className="mb-2 flex items-center gap-2 font-semibold uppercase tracking-[0.14em] text-rose-200">
            <AlertCircle size={12} /> Python Error
          </div>
          <pre className="whitespace-pre-wrap break-words font-mono leading-6 text-rose-100">{error}</pre>
        </div>
      )
    }

    return (
      <pre className="max-h-56 min-h-[88px] overflow-auto whitespace-pre-wrap break-words bg-slate-950 p-3 font-mono text-xs leading-6 text-slate-100">
        {running ? 'Running Python...' : ready && output ? output : output || 'No output yet.'}
      </pre>
    )
  }

  return (
    <div className="border-t border-slate-200 bg-slate-100/80 dark:border-slate-700 dark:bg-slate-900/80">
      <div className="flex items-center justify-between border-b border-slate-200 px-3 py-2 dark:border-slate-700">
        <div className="flex items-center gap-2">
          {tabs.map((tab) => (
            <button
              key={tab.id}
              type="button"
              onClick={() => onTabChange(tab.id)}
              className={`rounded-md px-2 py-1 text-[10px] font-bold uppercase tracking-[0.12em] transition ${
                activeTab === tab.id
                  ? 'bg-slate-900 text-white dark:bg-slate-100 dark:text-slate-900'
                  : 'text-slate-500 hover:bg-slate-200 dark:text-slate-400 dark:hover:bg-slate-700'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={onCopy}
            className="inline-flex items-center gap-1 rounded-md border border-slate-200 bg-white px-2 py-1 text-[10px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
            aria-label="Copy output"
          >
            <Copy size={11} /> Copy
          </button>
          <button
            type="button"
            onClick={onStop}
            className="inline-flex items-center gap-1 rounded-md border border-slate-200 bg-white px-2 py-1 text-[10px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
            aria-label="Stop execution"
            disabled={!running}
          >
            <Square size={11} /> Stop
          </button>
          <button
            type="button"
            onClick={onClear}
            className="inline-flex items-center gap-1 rounded-md border border-slate-200 bg-white px-2 py-1 text-[10px] font-medium text-slate-700 transition hover:bg-slate-100 disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
            aria-label="Clear output"
            disabled={!hasOutput}
          >
            Clear
          </button>
        </div>
      </div>

      {renderContent()}

      {ready && !running && !error && !output && activeTab === 'output' && (
        <div className="flex items-center gap-2 border-t border-slate-200 bg-slate-100/60 px-3 py-2 text-[11px] text-slate-500 dark:border-slate-700 dark:bg-slate-900/40 dark:text-slate-400">
          <CheckCircle2 size={12} className="text-eleven-500" />
          Python is ready.
        </div>
      )}

      {!ready && !running && (
        <div className="flex items-center gap-2 border-t border-slate-200 bg-slate-100/60 px-3 py-2 text-[11px] text-slate-500 dark:border-slate-700 dark:bg-slate-900/40 dark:text-slate-400">
          <TerminalSquare size={12} className="text-eleven-500" />
          Loading Python runtime...
        </div>
      )}
    </div>
  )
}
