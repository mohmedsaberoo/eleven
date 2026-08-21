import { useCallback, useEffect, useRef, useState } from 'react'
import Editor, { type OnMount } from '@monaco-editor/react'
import { Check, Copy, Loader2, Play, RotateCcw, Trash2 } from 'lucide-react'
import { usePyodide } from '@/hooks/usePyodide'
import { useTheme } from '@/contexts/ThemeContext'

const lightThemeName = 'eleven-light'
const darkThemeName = 'eleven-dark'

function registerMonacoThemes(monaco: any) {
  monaco.editor.defineTheme(lightThemeName, {
    base: 'vs',
    inherit: true,
    rules: [
      { token: 'comment', foreground: '6a737d' },
      { token: 'string', foreground: '032f62' },
      { token: 'number', foreground: '005cc5' },
      { token: 'keyword', foreground: 'd73a49' },
      { token: 'function', foreground: '6f42c1' },
      { token: 'variable', foreground: '24292e' },
      { token: 'operator', foreground: 'd73a49' },
    ],
    colors: {
      'editor.background': '#ffffff',
      'editor.foreground': '#1f2937',
      'editorLineNumber.foreground': '#6b7280',
      'editorLineNumber.activeForeground': '#111827',
      'editorCursor.foreground': '#111827',
      'editor.selectionBackground': '#dbeafe',
      'editor.inactiveSelectionBackground': '#e5e7eb',
      'editor.lineHighlightBackground': '#f3f4f6',
      'editorIndentGuide.background': '#e5e7eb',
      'editorIndentGuide.activeBackground': '#9ca3af',
      'editorGutter.background': '#ffffff',
      'editorWidget.background': '#ffffff',
      'editorWidget.border': '#e5e7eb',
      'scrollbarSlider.background': '#cbd5e1',
      'scrollbarSlider.hoverBackground': '#94a3b8',
      'scrollbarSlider.activeBackground': '#64748b',
      'editorBracketMatch.background': '#dbeafe',
      'editorBracketMatch.border': '#60a5fa',
    },
  })

  monaco.editor.defineTheme(darkThemeName, {
    base: 'vs-dark',
    inherit: true,
    rules: [
      { token: 'comment', foreground: '6b7280' },
      { token: 'string', foreground: '9ecbff' },
      { token: 'number', foreground: '79c0ff' },
      { token: 'keyword', foreground: 'ff7b72' },
      { token: 'function', foreground: 'd2a8ff' },
      { token: 'variable', foreground: 'e5e7eb' },
      { token: 'operator', foreground: 'ffa657' },
    ],
    colors: {
      'editor.background': '#111827',
      'editor.foreground': '#f3f4f6',
      'editorLineNumber.foreground': '#9ca3af',
      'editorLineNumber.activeForeground': '#f3f4f6',
      'editorCursor.foreground': '#f9fafb',
      'editor.selectionBackground': '#334155',
      'editor.inactiveSelectionBackground': '#1f2937',
      'editor.lineHighlightBackground': '#1f2937',
      'editorIndentGuide.background': '#374151',
      'editorIndentGuide.activeBackground': '#9ca3af',
      'editorGutter.background': '#111827',
      'editorWidget.background': '#111827',
      'editorWidget.border': '#374151',
      'scrollbarSlider.background': '#475569',
      'scrollbarSlider.hoverBackground': '#64748b',
      'scrollbarSlider.activeBackground': '#94a3b8',
      'editorBracketMatch.background': '#274c77',
      'editorBracketMatch.border': '#7dd3fc',
    },
  })
}

function safeReadStorage(key: string): string | null {
  if (typeof window === 'undefined') return null

  try {
    return window.localStorage.getItem(key)
  } catch {
    return null
  }
}

function safeWriteStorage(key: string, value: string) {
  if (typeof window === 'undefined') return

  try {
    window.localStorage.setItem(key, value)
  } catch {
    // Ignore storage quota or privacy restrictions.
  }
}

function deriveLessonStorageKey(code: string) {
  const normalized = code.replace(/\s+/g, ' ').trim()
  const seed = normalized.slice(0, 32).replace(/[^a-zA-Z0-9]/g, '').toLowerCase() || 'lesson'
  return `eleven-lesson-${seed}`
}

export function PythonEditor({
  starterCode,
  storageKey,
  height = '360px',
  title = 'Python',
}: {
  starterCode: string
  storageKey?: string
  height?: string
  title?: string
}) {
  const { theme } = useTheme()
  const { ready, initializing, runPython } = usePyodide()
  const editorRef = useRef<any>(null)
  const [code, setCode] = useState(() => {
    const key = storageKey ?? deriveLessonStorageKey(starterCode)
    const saved = safeReadStorage(key)
    return saved ?? starterCode
  })
  const [output, setOutput] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [running, setRunning] = useState(false)
  const [copied, setCopied] = useState(false)

  const resolvedStorageKey = storageKey ?? deriveLessonStorageKey(starterCode)

  useEffect(() => {
    safeWriteStorage(resolvedStorageKey, code)
  }, [code, resolvedStorageKey])

  const handleRun = useCallback(async () => {
    if (!ready || running) return

    setRunning(true)
    setError(null)

    try {
      const result = await runPython(code)
      setOutput(result.stdout || '')
      setError(result.error)
    } catch (err) {
      setOutput('')
      setError(err instanceof Error ? err.message : 'Unexpected Python runtime error')
    } finally {
      setRunning(false)
    }
  }, [code, ready, runPython, running])

  const handleReset = useCallback(() => {
    setCode(starterCode)
    setOutput('')
    setError(null)
  }, [starterCode])

  const handleClearOutput = useCallback(() => {
    setOutput('')
    setError(null)
  }, [])

  const handleCopy = useCallback(async () => {
    try {
      await navigator.clipboard.writeText(code)
      setCopied(true)
      window.setTimeout(() => setCopied(false), 1200)
    } catch {
      const textarea = document.createElement('textarea')
      textarea.value = code
      textarea.setAttribute('readonly', 'true')
      textarea.style.position = 'fixed'
      textarea.style.left = '-9999px'
      document.body.appendChild(textarea)
      textarea.select()
      try {
        document.execCommand('copy')
        setCopied(true)
        window.setTimeout(() => setCopied(false), 1200)
      } catch {
        setError('Unable to copy code to clipboard.')
      }
      document.body.removeChild(textarea)
    }
  }, [code])

  const handleEditorMount: OnMount = useCallback(
    (editor, monaco) => {
      editorRef.current = editor
      registerMonacoThemes(monaco)

      editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.Enter, () => {
        handleRun()
      })

      editor.focus()
    },
    [handleRun],
  )

  const statusText = initializing ? 'Preparing Python...' : ready ? 'Python is ready.' : 'Loading Python runtime...'
  const hasOutput = output.trim().length > 0 || Boolean(error)

  return (
    <div className="editor-shell overflow-hidden rounded-2xl border border-black/10 bg-white dark:border-white/10 dark:bg-[#1e1e1e]">
      <div className="flex flex-wrap items-center justify-between gap-2 border-b border-black/10 bg-black/[0.02] px-3 py-2 dark:border-white/10 dark:bg-white/[0.02]">
        <div className="flex items-center gap-2">
          <span className="text-[11px] font-bold uppercase tracking-[0.18em] text-gray-600 dark:text-gray-300">{title}</span>
          <span className="rounded-full border border-eleven-500/25 bg-eleven-500/10 px-2 py-0.5 text-[10px] font-semibold text-eleven-600 dark:text-eleven-400">
            {statusText}
          </span>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          <button
            onClick={handleRun}
            disabled={!ready || running || initializing}
            className="inline-flex items-center gap-1.5 rounded-lg bg-eleven-500 px-3 py-1.5 text-xs font-semibold text-white transition hover:bg-eleven-600 disabled:cursor-not-allowed disabled:opacity-60"
          >
            {running || initializing ? <Loader2 size={13} className="animate-spin" /> : <Play size={13} />}
            {running ? 'Running...' : 'Run'}
          </button>

          <button
            onClick={handleReset}
            className="inline-flex items-center gap-1.5 rounded-lg border border-black/10 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 transition hover:bg-black/5 dark:border-white/10 dark:bg-transparent dark:text-gray-200 dark:hover:bg-white/5"
          >
            <RotateCcw size={13} /> Reset
          </button>

          <button
            onClick={handleCopy}
            className="inline-flex items-center gap-1.5 rounded-lg border border-black/10 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 transition hover:bg-black/5 dark:border-white/10 dark:bg-transparent dark:text-gray-200 dark:hover:bg-white/5"
          >
            {copied ? <Check size={13} /> : <Copy size={13} />}
            {copied ? 'Copied!' : 'Copy'}
          </button>

          <button
            onClick={handleClearOutput}
            className="inline-flex items-center gap-1.5 rounded-lg border border-black/10 bg-white px-3 py-1.5 text-xs font-semibold text-gray-700 transition hover:bg-black/5 dark:border-white/10 dark:bg-transparent dark:text-gray-200 dark:hover:bg-white/5"
          >
            <Trash2 size={13} /> Clear Output
          </button>
        </div>
      </div>

      <div className="relative w-full overflow-hidden" style={{ height, minHeight: height }}>
        <Editor
          height="100%"
          width="100%"
          defaultLanguage="python"
          language="python"
          value={code}
          theme={theme === 'dark' ? darkThemeName : lightThemeName}
          beforeMount={(monaco) => registerMonacoThemes(monaco)}
          onMount={handleEditorMount}
          onChange={(value) => setCode(value ?? '')}
          options={{
            automaticLayout: true,
            minimap: { enabled: true },
            scrollBeyondLastLine: false,
            wordWrap: 'off',
            fontSize: 14,
            lineNumbers: 'on',
            lineNumbersMinChars: 3,
            fontFamily: 'JetBrains Mono, Fira Code, monospace',
            padding: { top: 14, bottom: 14 },
            glyphMargin: false,
            folding: true,
            bracketPairColorization: { enabled: true },
            smoothScrolling: true,
            renderLineHighlight: 'all',
            cursorBlinking: 'smooth',
            roundedSelection: true,
            tabSize: 4,
            insertSpaces: true,
            contextmenu: true,
            quickSuggestions: true,
            autoClosingBrackets: 'always',
            autoClosingQuotes: 'always',
            formatOnPaste: true,
            formatOnType: true,
            fixedOverflowWidgets: true,
          }}
        />
      </div>

      <div className="border-t border-black/10 bg-zinc-950 px-3 py-3 dark:border-white/10 dark:bg-[#111827]">
        <div className="mb-2 flex items-center justify-between">
          <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-gray-400">Output</span>
          {!hasOutput && <span className="text-[10px] text-gray-500">No output yet.</span>}
        </div>

        {error ? (
          <div className="max-h-56 overflow-auto rounded-xl border border-red-500/20 bg-red-500/10 p-3 text-left">
            <p className="mb-1 text-[10px] font-bold uppercase tracking-[0.2em] text-red-300">Python Error</p>
            <pre className="whitespace-pre-wrap break-words font-mono text-xs leading-6 text-red-100">{error}</pre>
          </div>
        ) : (
          <pre className="max-h-56 min-h-[82px] overflow-auto whitespace-pre-wrap break-words font-mono text-xs leading-6 text-gray-100">
            {output || 'No output yet.'}
          </pre>
        )}
      </div>
    </div>
  )
}
