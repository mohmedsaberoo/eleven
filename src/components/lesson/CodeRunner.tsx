import { useState } from 'react'
import Editor from '@monaco-editor/react'
import { Play, Loader2 } from 'lucide-react'
import { usePyodide } from '@/hooks/usePyodide'
import { useTheme } from '@/contexts/ThemeContext'

export function CodeRunner({ initialCode, height = '160px' }: { initialCode: string; height?: string }) {
  const { theme } = useTheme()
  const { ready, initializing, runPython } = usePyodide()
  const [code, setCode] = useState(initialCode)
  const [output, setOutput] = useState<string>('')
  const [error, setError] = useState<string | null>(null)
  const [running, setRunning] = useState(false)

  const handleRun = async () => {
    setRunning(true)
    setError(null)
    const result = await runPython(code)
    setOutput(result.stdout)
    setError(result.error)
    setRunning(false)
  }

  return (
    <div className="overflow-hidden rounded-xl border border-black/10 dark:border-white/10">
      <Editor
        height={height}
        defaultLanguage="python"
        value={code}
        onChange={(v) => setCode(v ?? '')}
        theme={theme === 'dark' ? 'vs-dark' : 'light'}
        options={{ fontSize: 13, minimap: { enabled: false }, scrollBeyondLastLine: false, padding: { top: 10 } }}
      />
      <div className="flex items-center justify-between border-t border-black/10 bg-black/[0.02] px-3 py-2 dark:border-white/10 dark:bg-white/[0.02]">
        <button
          onClick={handleRun}
          disabled={!ready || running}
          className="flex items-center gap-1.5 rounded-lg bg-eleven-500 px-3 py-1.5 text-xs font-semibold text-white disabled:opacity-50"
        >
          {running || initializing ? <Loader2 size={13} className="animate-spin" /> : <Play size={13} />}
          {initializing ? 'تجهيز المحرك...' : running ? 'تشغيل...' : 'Run Code'}
        </button>
      </div>
      {(output || error) && (
        <pre className="max-h-40 overflow-auto whitespace-pre-wrap border-t border-black/10 bg-night-950 p-3 font-mono text-xs text-eleven-300 dark:border-white/10">
          {output}
          {error && <span className="text-red-400">{'\n' + error}</span>}
        </pre>
      )}
    </div>
  )
}
