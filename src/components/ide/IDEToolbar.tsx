import { Copy, FileText, FolderPlus, Moon, Play, RotateCcw, Save, Sun, Trash2, WrapText, X } from 'lucide-react'

export interface IDEToolbarProps {
  title: string
  theme: 'light' | 'dark'
  ready: boolean
  initializing: boolean
  running: boolean
  hasOutput: boolean
  showExplorer: boolean
  wordWrap: 'on' | 'off'
  onRun: () => void
  onSave: () => void
  onReset: () => void
  onCopy: () => void
  onClearOutput: () => void
  onToggleTheme: () => void
  onToggleExplorer: () => void
  onNewFile: () => void
  onRenameFile: () => void
  onDeleteFile: () => void
}

export function IDEToolbar({
  title,
  theme,
  ready,
  initializing,
  running,
  hasOutput,
  showExplorer,
  wordWrap,
  onRun,
  onSave,
  onReset,
  onCopy,
  onClearOutput,
  onToggleTheme,
  onToggleExplorer,
  onNewFile,
  onRenameFile,
  onDeleteFile,
}: IDEToolbarProps) {
  const statusLabel = initializing ? 'Preparing Python...' : ready ? 'Python ready' : 'Loading runtime...'

  return (
    <div className="flex flex-wrap items-center justify-between gap-2 border-b border-slate-200 bg-slate-100/80 px-3 py-2 dark:border-slate-700 dark:bg-slate-900/90">
      <div className="flex items-center gap-2">
        <div className="flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-2 py-1 dark:border-slate-700 dark:bg-slate-800">
          <FileText size={14} className="text-eleven-500" />
          <span className="text-[11px] font-bold uppercase tracking-[0.14em] text-slate-600 dark:text-slate-300">{title}</span>
        </div>
        <span className="rounded-full border border-eleven-500/20 bg-eleven-500/10 px-2 py-0.5 text-[10px] font-semibold text-eleven-600 dark:text-eleven-400">
          {statusLabel}
        </span>
      </div>

      <div className="flex flex-wrap items-center gap-1.5">
        <button
          type="button"
          onClick={onNewFile}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Create a new Python file"
          title="New file"
        >
          <FolderPlus size={13} />
          New
        </button>

        <button
          type="button"
          onClick={onRenameFile}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Rename current file"
          title="Rename"
        >
          <FileText size={13} />
          Rename
        </button>

        <button
          type="button"
          onClick={onDeleteFile}
          className="inline-flex items-center gap-1.5 rounded-lg border border-rose-200 bg-rose-50 px-2.5 py-1.5 text-[11px] font-medium text-rose-700 transition hover:bg-rose-100 dark:border-rose-900/70 dark:bg-rose-950/40 dark:text-rose-300 dark:hover:bg-rose-900/60"
          aria-label="Delete current file"
          title="Delete file"
        >
          <Trash2 size={13} />
          Delete
        </button>

        <button
          type="button"
          onClick={onRun}
          disabled={!ready || running || initializing}
          className="inline-flex items-center gap-1.5 rounded-lg bg-eleven-500 px-2.5 py-1.5 text-[11px] font-semibold text-white transition hover:bg-eleven-600 disabled:cursor-not-allowed disabled:opacity-60"
          aria-label="Run current Python code"
          title="Run (Ctrl+Enter)"
        >
          <Play size={13} />
          {running ? 'Running...' : 'Run'}
        </button>

        <button
          type="button"
          onClick={onSave}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Save current code"
          title="Save (Ctrl+S)"
        >
          <Save size={13} />
          Save
        </button>

        <button
          type="button"
          onClick={onReset}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Reset code to starter content"
          title="Reset"
        >
          <RotateCcw size={13} />
          Reset
        </button>

        <button
          type="button"
          onClick={onCopy}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Copy current code"
          title="Copy"
        >
          <Copy size={13} />
          Copy
        </button>

        <button
          type="button"
          onClick={onClearOutput}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Clear output"
          title="Clear output"
          disabled={!hasOutput}
        >
          <X size={13} />
          Clear
        </button>

        <button
          type="button"
          onClick={() => onToggleExplorer()}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Toggle file explorer"
          title="Toggle explorer"
        >
          {showExplorer ? 'Hide' : 'Show'}
        </button>

        <button
          type="button"
          onClick={onToggleTheme}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Toggle light and dark theme"
          title="Toggle theme"
        >
          {theme === 'dark' ? <Sun size={13} /> : <Moon size={13} />}
        </button>

        <button
          type="button"
          onClick={() => {}}
          className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-2.5 py-1.5 text-[11px] font-medium text-slate-700 transition hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700"
          aria-label="Toggle word wrap"
          title={wordWrap === 'on' ? 'Word wrap on' : 'Word wrap off'}
        >
          <WrapText size={13} />
          {wordWrap === 'on' ? 'Wrap' : 'No Wrap'}
        </button>
      </div>
    </div>
  )
}
