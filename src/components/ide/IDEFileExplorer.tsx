import { FileCode2, FolderPlus, Plus, X } from 'lucide-react'

export interface IDEFileExplorerProps {
  files: Array<{ id: string; name: string; content: string }>
  activeFileId: string
  onSelectFile: (id: string) => void
  onNewFile: () => void
  onRenameFile: () => void
  onDeleteFile: () => void
}

export function IDEFileExplorer({
  files,
  activeFileId,
  onSelectFile,
  onNewFile,
  onRenameFile,
  onDeleteFile,
}: IDEFileExplorerProps) {
  return (
    <aside className="flex min-h-[200px] flex-col border-r border-slate-200 bg-slate-100/70 dark:border-slate-700 dark:bg-slate-900/80">
      <div className="flex items-center justify-between border-b border-slate-200 px-3 py-2 dark:border-slate-700">
        <span className="text-[10px] font-bold uppercase tracking-[0.18em] text-slate-500 dark:text-slate-400">Explorer</span>
        <div className="flex items-center gap-1">
          <button
            type="button"
            onClick={onNewFile}
            className="rounded-md p-1 text-slate-600 transition hover:bg-slate-200 dark:text-slate-300 dark:hover:bg-slate-700"
            aria-label="Create new file"
            title="New file"
          >
            <Plus size={14} />
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-auto p-2">
        <div className="space-y-1">
          {files.map((file) => {
            const isActive = file.id === activeFileId
            return (
              <button
                key={file.id}
                type="button"
                onClick={() => onSelectFile(file.id)}
                className={`flex w-full items-center justify-between gap-2 rounded-lg px-2 py-1.5 text-left text-sm transition ${
                  isActive
                    ? 'bg-eleven-500/10 text-eleven-700 dark:bg-eleven-500/10 dark:text-eleven-300'
                    : 'text-slate-700 hover:bg-slate-200 dark:text-slate-200 dark:hover:bg-slate-700'
                }`}
              >
                <span className="flex items-center gap-2 truncate">
                  <FileCode2 size={14} />
                  <span className="truncate">{file.name}</span>
                </span>
              </button>
            )
          })}
        </div>
      </div>

      <div className="flex items-center justify-between border-t border-slate-200 px-3 py-2 dark:border-slate-700">
        <button
          type="button"
          onClick={onRenameFile}
          className="flex items-center gap-1 text-[10px] font-medium uppercase tracking-[0.12em] text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-slate-100"
        >
          <FolderPlus size={12} /> Rename
        </button>
        <button
          type="button"
          onClick={onDeleteFile}
          className="flex items-center gap-1 text-[10px] font-medium uppercase tracking-[0.12em] text-rose-600 hover:text-rose-700 dark:text-rose-300 dark:hover:text-rose-200"
        >
          <X size={12} /> Delete
        </button>
      </div>
    </aside>
  )
}
