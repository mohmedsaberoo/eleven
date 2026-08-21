export interface IDEStatusBarProps {
  line: number
  column: number
  language: string
  encoding: string
  status: string
}

export function IDEStatusBar({ line, column, language, encoding, status }: IDEStatusBarProps) {
  return (
    <div className="flex items-center justify-between border-t border-slate-200 bg-slate-200/80 px-3 py-1.5 text-[10px] font-medium text-slate-700 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200">
      <div className="flex items-center gap-3">
        <span>Ln {line}</span>
        <span>Col {column}</span>
        <span>{language}</span>
        <span>{encoding}</span>
      </div>
      <span className="rounded-full border border-eleven-500/20 bg-eleven-500/10 px-2 py-0.5 text-[9px] font-semibold text-eleven-600 dark:text-eleven-300">
        {status}
      </span>
    </div>
  )
}
