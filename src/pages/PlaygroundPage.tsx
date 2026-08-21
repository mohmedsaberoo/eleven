import { useState } from 'react'
import Editor from '@monaco-editor/react'
import { Play, Loader2, RotateCcw } from 'lucide-react'
import { usePyodide } from '@/hooks/usePyodide'
import { useTheme } from '@/contexts/ThemeContext'

const DEFAULT_CODE = `name = input("What is your name? ")
print("Hello", name)
print("Welcome to the Eleven Python Playground 🐍")
`

export default function PlaygroundPage() {
  const { theme } = useTheme()
  const { ready, initializing, runPython } = usePyodide()
  const [code, setCode] = useState(DEFAULT_CODE)
  const [stdinText, setStdinText] = useState('Eleven Learner')
  const [output, setOutput] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [running, setRunning] = useState(false)

  const handleRun = async () => {
    setRunning(true)
    setError(null)
    const stdinLines = stdinText.split('\n')
    const result = await runPython(code, stdinLines)
    setOutput(result.stdout)
    setError(result.error)
    setRunning(false)
  }

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-2xl font-extrabold">🧪 Python Playground</h1>
        <p className="text-gray-500 dark:text-gray-400">
          اكتب وشغّل كود Python حقيقي مباشرة من المتصفح — لا حاجة لأي تثبيت.
        </p>
      </div>

      <div className="grid grid-cols-1 gap-4 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <div className="overflow-hidden rounded-xl border border-black/10 dark:border-white/10">
            <Editor
              height="420px"
              defaultLanguage="python"
              value={code}
              onChange={(v) => setCode(v ?? '')}
              theme={theme === 'dark' ? 'vs-dark' : 'light'}
              options={{ fontSize: 14, minimap: { enabled: false }, padding: { top: 12 } }}
            />
          </div>
        </div>

        <div className="space-y-3">
          <div className="card p-4">
            <label className="mb-1.5 block text-xs font-semibold text-gray-500">
              قيم input() (سطر لكل استدعاء)
            </label>
            <textarea
              value={stdinText}
              onChange={(e) => setStdinText(e.target.value)}
              className="input h-24 resize-none font-mono text-xs"
            />
          </div>
          <div className="flex gap-2">
            <button
              onClick={handleRun}
              disabled={!ready || running}
              className="btn-primary flex flex-1 items-center justify-center gap-2"
            >
              {running || initializing ? <Loader2 size={15} className="animate-spin" /> : <Play size={15} />}
              {initializing ? 'تجهيز المحرك...' : running ? 'تشغيل...' : 'Run Code'}
            </button>
            <button onClick={() => setCode(DEFAULT_CODE)} className="btn-secondary" aria-label="إعادة تعيين">
              <RotateCcw size={15} />
            </button>
          </div>
          <div className="card min-h-[140px] p-4">
            <p className="mb-2 text-xs font-semibold text-gray-500">Output</p>
            <pre className="max-h-64 overflow-auto whitespace-pre-wrap font-mono text-xs text-eleven-600 dark:text-eleven-400">
              {output || (error ? '' : '// شغّل الكود لترى الناتج هنا')}
              {error && <span className="text-red-500">{error}</span>}
            </pre>
          </div>
        </div>
      </div>
    </div>
  )
}
