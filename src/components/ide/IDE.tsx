import { useCallback, useEffect, useMemo, useState } from 'react'
import { useTheme } from '@/contexts/ThemeContext'
import { usePyodide } from '@/hooks/usePyodide'
import { IDEEditor } from './IDEEditor'
import { IDEFileExplorer } from './IDEFileExplorer'
import { IDEOutput, type OutputTab } from './IDEOutput'
import { IDEStatusBar } from './IDEStatusBar'
import { IDEToolbar } from './IDEToolbar'
import { AIAssistant } from './AIAssistant'

export interface IDEFile {
  id: string
  name: string
  content: string
}

export interface IDEProps {
  initialCode?: string
  fileName?: string
  storageKey?: string
  title?: string
  height?: string
  className?: string
  lessonName?: string
  chapterName?: string
  challengePrompt?: string
  assistantEnabled?: boolean
  onCodeChange?: (code: string) => void
  onRunResult?: (result: { stdout: string; error: string | null }) => void
}

const DEFAULT_NEW_CODE = 'print("Hello from ELEVEN")\n'

function generateFileName(files: IDEFile[]) {
  let index = 1
  let next = `file_${index}.py`
  while (files.some((file) => file.name === next)) {
    index += 1
    next = `file_${index}.py`
  }
  return next
}

function normalizeFileName(value: string) {
  const trimmed = value.trim()
  if (!trimmed) return 'untitled.py'
  const safe = trimmed.replace(/\\s+/g, '_').replace(/[^a-zA-Z0-9_.-]/g, '_')
  return safe.endsWith('.py') ? safe : `${safe}.py`
}

function readStoredProject(storageKey: string, initialCode: string, fileName: string) {
  if (typeof window === 'undefined') {
    return {
      files: [{ id: fileName, name: fileName, content: initialCode }],
      activeFileId: fileName,
      openFiles: [fileName],
    }
  }

  try {
    const raw = window.localStorage.getItem(storageKey)
    if (!raw) {
      const file = { id: fileName, name: fileName, content: initialCode }
      return { files: [file], activeFileId: file.id, openFiles: [file.id] }
    }

    const parsed = JSON.parse(raw)
    if (parsed && Array.isArray(parsed.files) && parsed.files.length > 0) {
      const files = parsed.files.map((file: { id?: string; name?: string; content?: string }) => ({
        id: String(file.id ?? file.name ?? 'main.py'),
        name: String(file.name ?? 'main.py'),
        content: String(file.content ?? ''),
      }))
      const activeFileId = typeof parsed.activeFileId === 'string' && files.some((file: IDEFile) => file.id === parsed.activeFileId)
        ? parsed.activeFileId
        : files[0].id

      const openFiles = Array.isArray(parsed.openFiles) && parsed.openFiles.length > 0
        ? parsed.openFiles.filter((id: string) => files.some((file: IDEFile) => file.id === id))
        : [activeFileId]

      return { files, activeFileId, openFiles }
    }
  } catch {
    // ignore malformed storage and fallback to defaults
  }

  const file = { id: fileName, name: fileName, content: initialCode }
  return { files: [file], activeFileId: file.id, openFiles: [file.id] }
}

function persistProject(storageKey: string, files: IDEFile[], activeFileId: string, openFiles: string[]) {
  if (typeof window === 'undefined') return

  try {
    window.localStorage.setItem(
      storageKey,
      JSON.stringify({
        files,
        activeFileId,
        openFiles,
      }),
    )
  } catch {
    // Ignore localStorage quota/privacy restrictions.
  }
}

export function IDE({
  initialCode = 'print("Hello ELEVEN")\n',
  fileName = 'main.py',
  storageKey = 'eleven_ide_project',
  title = 'ELEVEN IDE',
  height = '420px',
  className = '',
  lessonName,
  chapterName,
  challengePrompt,
  assistantEnabled = true,
  onCodeChange,
  onRunResult,
}: IDEProps) {
  const { theme, toggleTheme } = useTheme()
  const { ready, initializing, runPython } = usePyodide()
  const [showExplorer, setShowExplorer] = useState(true)
  const [outputTab, setOutputTab] = useState<OutputTab>('output')
  const [files, setFiles] = useState<IDEFile[]>(() => {
    const project = readStoredProject(storageKey, initialCode, fileName)
    return project.files
  })
  const [activeFileId, setActiveFileId] = useState<string>(() => readStoredProject(storageKey, initialCode, fileName).activeFileId)
  const [openFiles, setOpenFiles] = useState<string[]>(() => readStoredProject(storageKey, initialCode, fileName).openFiles)
  const [status, setStatus] = useState('Ready')
  const [line, setLine] = useState(1)
  const [column, setColumn] = useState(1)
  const [output, setOutput] = useState('')
  const [terminalText, setTerminalText] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [running, setRunning] = useState(false)
  const [wordWrap, setWordWrap] = useState<'on' | 'off'>('on')
  const [problems, setProblems] = useState<string[]>(['No active Python issues detected.'])

  const activeFile = useMemo(
    () => files.find((file) => file.id === activeFileId) ?? files[0] ?? { id: fileName, name: fileName, content: '' },
    [files, activeFileId, fileName],
  )

  useEffect(() => {
    if (files.length === 0) {
      const fallback = [{ id: fileName, name: fileName, content: initialCode }]
      setFiles(fallback)
      setActiveFileId(fallback[0].id)
      setOpenFiles([fallback[0].id])
      return
    }

    persistProject(storageKey, files, activeFileId, openFiles)
  }, [files, activeFileId, openFiles, storageKey, fileName, initialCode])

  useEffect(() => {
    if (activeFile) {
      onCodeChange?.(activeFile.content)
    }
  }, [activeFile, onCodeChange])

  useEffect(() => {
    if (!openFiles.includes(activeFileId) && files.length > 0) {
      setOpenFiles((prev) => (prev.includes(activeFileId) ? prev : [...prev, activeFileId]))
    }
  }, [activeFileId, openFiles, files])

  const handleUpdateFile = useCallback((nextContent: string) => {
    setFiles((prev) => prev.map((file) => (file.id === activeFileId ? { ...file, content: nextContent } : file)))
  }, [activeFileId])

  const handleRun = useCallback(async () => {
    if (!ready || running || !activeFile) return

    setRunning(true)
    setError(null)
    setOutput('')
    setTerminalText(`Running ${activeFile.name}...`)
    setOutputTab('output')
    setStatus('Running')

    try {
      const result = await runPython(activeFile.content)
      const nextOutput = result.stdout || ''
      const nextError = result.error
      setOutput(nextOutput)
      setTerminalText(nextOutput || (nextError ? `Error: ${nextError}` : 'No output.'))
      setError(nextError)
      setProblems(nextError ? [nextError] : ['No active Python issues detected.'])
      onRunResult?.({ stdout: nextOutput, error: nextError })
      setStatus(nextError ? 'Error' : 'Success')
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Unexpected Python runtime error'
      setOutput('')
      setTerminalText(`Error: ${message}`)
      setError(message)
      setProblems([message])
      setStatus('Error')
      onRunResult?.({ stdout: '', error: message })
    } finally {
      setRunning(false)
    }
  }, [activeFile, onRunResult, ready, runPython, running])

  const handleReset = useCallback(() => {
    const fallback = initialCode
    setFiles((prev) => prev.map((file) => (file.id === activeFileId ? { ...file, content: fallback } : file)))
    setOutput('')
    setTerminalText('')
    setError(null)
    setProblems(['No active Python issues detected.'])
    setStatus('Reset')
  }, [activeFileId, initialCode])

  const handleSave = useCallback(() => {
    persistProject(storageKey, files, activeFileId, openFiles)
    setStatus('Saved')
    setTerminalText(`Saved project to ${storageKey}`)
  }, [activeFileId, files, openFiles, storageKey])

  const handleApplySuggestion = useCallback((nextCode: string) => {
    if (!nextCode.trim()) return
    setFiles((prev) => prev.map((file) => (file.id === activeFileId ? { ...file, content: nextCode } : file)))
    setStatus('Suggestion applied')
    setTerminalText('Applied AI suggestion to the active file.')
  }, [activeFileId])

  const handleCopy = useCallback(async () => {
    try {
      await navigator.clipboard.writeText(activeFile.content)
      setStatus('Copied')
      setTerminalText(`Copied ${activeFile.name} to clipboard`)
    } catch {
      setStatus('Copy failed')
    }
  }, [activeFile])

  const handleClearOutput = useCallback(() => {
    setOutput('')
    setError(null)
    setTerminalText('')
    setProblems(['No active Python issues detected.'])
    setStatus('Output cleared')
  }, [])

  const handleNewFile = useCallback(() => {
    const nextName = generateFileName(files)
    const newFile = { id: nextName, name: nextName, content: DEFAULT_NEW_CODE }
    setFiles((prev) => [...prev, newFile])
    setOpenFiles((prev) => [...prev, nextName])
    setActiveFileId(nextName)
    setOutputTab('output')
    setStatus('New file created')
  }, [files])

  const handleRenameFile = useCallback(() => {
    const nextName = window.prompt('Rename file', activeFile.name)
    if (!nextName) return

    const sanitized = normalizeFileName(nextName)
    setFiles((prev) => prev.map((file) => (file.id === activeFile.id ? { ...file, name: sanitized, id: sanitized } : file)))
    setOpenFiles((prev) => prev.map((id) => (id === activeFile.id ? sanitized : id)))
    setActiveFileId(sanitized)
    setStatus('File renamed')
  }, [activeFile])

  const handleDeleteFile = useCallback(() => {
    if (files.length <= 1) {
      setStatus('At least one file is required')
      return
    }

    const filteredFiles = files.filter((file) => file.id !== activeFile.id)
    const nextOpen = openFiles.filter((id) => id !== activeFile.id)
    const nextActive = filteredFiles[0]?.id ?? activeFile.id
    setFiles(filteredFiles)
    setOpenFiles(nextOpen.length > 0 ? nextOpen : [nextActive])
    setActiveFileId(nextActive)
    setStatus('File deleted')
  }, [activeFile, files, openFiles])

  const handleCloseTab = useCallback((tabId: string) => {
    if (openFiles.length <= 1) {
      setStatus('Keep at least one file open')
      return
    }

    const nextOpen = openFiles.filter((id) => id !== tabId)
    setOpenFiles(nextOpen)
    if (activeFileId === tabId) {
      setActiveFileId(nextOpen[nextOpen.length - 1])
    }
    if (files.length > 1) {
      setFiles((prev) => prev.filter((file) => file.id !== tabId))
    }
  }, [activeFileId, files.length, openFiles])

  const handleToggleWordWrap = useCallback(() => {
    setWordWrap((prev) => (prev === 'on' ? 'off' : 'on'))
    setStatus(wordWrap === 'on' ? 'Word wrap off' : 'Word wrap on')
  }, [wordWrap])

  return (
    <div className={`eleven-ide overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm dark:border-slate-700 dark:bg-slate-950 ${className}`}>
      <IDEToolbar
        title={title}
        theme={theme}
        ready={ready}
        initializing={initializing}
        running={running}
        hasOutput={Boolean(output || error)}
        showExplorer={showExplorer}
        wordWrap={wordWrap}
        onRun={handleRun}
        onSave={handleSave}
        onReset={handleReset}
        onCopy={handleCopy}
        onClearOutput={handleClearOutput}
        onToggleTheme={toggleTheme}
        onToggleExplorer={() => setShowExplorer((prev) => !prev)}
        onNewFile={handleNewFile}
        onRenameFile={handleRenameFile}
        onDeleteFile={handleDeleteFile}
      />

      <div className="flex items-center gap-1 overflow-x-auto border-b border-slate-200 bg-slate-100/80 px-2 py-1.5 dark:border-slate-700 dark:bg-slate-900/80">
        {openFiles.map((tabId) => {
          const tabFile = files.find((file) => file.id === tabId)
          if (!tabFile) return null

          const isActive = tabFile.id === activeFileId
          return (
            <div
              key={tabId}
              className={`flex items-center gap-2 rounded-t-md border px-2.5 py-1.5 text-[11px] font-medium ${
                isActive
                  ? 'border-slate-300 bg-white text-slate-800 dark:border-slate-600 dark:bg-slate-800 dark:text-slate-100'
                  : 'border-transparent bg-transparent text-slate-500 hover:bg-slate-200 dark:text-slate-400 dark:hover:bg-slate-700'
              }`}
            >
              <button type="button" onClick={() => setActiveFileId(tabFile.id)} className="flex items-center gap-2">
                <span>{tabFile.name}</span>
              </button>
              <button
                type="button"
                onClick={() => handleCloseTab(tabFile.id)}
                className="rounded-sm p-0.5 text-slate-400 hover:text-slate-700 dark:hover:text-slate-200"
                aria-label={`Close ${tabFile.name}`}
              >
                ×
              </button>
            </div>
          )
        })}
      </div>

      <div className="grid min-h-[360px] grid-cols-1 lg:grid-cols-[220px_minmax(0,1fr)]">
        {showExplorer && (
          <IDEFileExplorer
            files={files}
            activeFileId={activeFile.id}
            onSelectFile={setActiveFileId}
            onNewFile={handleNewFile}
            onRenameFile={handleRenameFile}
            onDeleteFile={handleDeleteFile}
          />
        )}

        <div className="min-w-0">
          <div className="flex items-center justify-between border-b border-slate-200 bg-slate-100/80 px-3 py-2 text-[11px] font-medium text-slate-600 dark:border-slate-700 dark:bg-slate-900/80 dark:text-slate-300">
            <div className="flex items-center gap-2">
              <span>{activeFile.name}</span>
              {running && <span className="text-eleven-500">Running…</span>}
            </div>
            <button
              type="button"
              onClick={handleToggleWordWrap}
              className="rounded-md border border-slate-200 bg-white px-2 py-1 text-[10px] font-medium text-slate-700 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-200"
            >
              {wordWrap === 'on' ? 'Wrap: ON' : 'Wrap: OFF'}
            </button>
          </div>

          <IDEEditor
            value={activeFile.content}
            onChange={handleUpdateFile}
            onRun={handleRun}
            onSave={handleSave}
            onCursorChange={({ lineNumber, column: cursorColumn }) => {
              setLine(lineNumber)
              setColumn(cursorColumn)
            }}
            theme={theme}
            height={height}
            wordWrap={wordWrap}
          />
        </div>
      </div>

      <IDEOutput
        output={output}
        terminalText={terminalText}
        error={error}
        problems={problems}
        ready={ready}
        running={running}
        activeTab={outputTab}
        onTabChange={setOutputTab}
        onCopy={() => {
          const value = outputTab === 'output' ? output : outputTab === 'terminal' ? terminalText : problems.join('\n')
          if (!value) return
          navigator.clipboard.writeText(value).catch(() => undefined)
        }}
        onClear={handleClearOutput}
        onStop={() => setStatus('Stopped')}
      />

      {assistantEnabled && (
        <AIAssistant
          code={activeFile.content}
          output={output}
          error={error}
          lessonName={lessonName}
          chapterName={chapterName}
          challengePrompt={challengePrompt}
          onApplySuggestion={handleApplySuggestion}
        />
      )}

      <IDEStatusBar line={line} column={column} language="Python" encoding="UTF-8" status={status} />
    </div>
  )
}
