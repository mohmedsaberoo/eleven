import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import Editor from '@monaco-editor/react'
import confetti from 'canvas-confetti'
import toast from 'react-hot-toast'
import { Play, Loader2, Lightbulb, CheckCircle2, XCircle } from 'lucide-react'
import { getProblem, submitProblem } from '@/services/content'
import { supabase } from '@/lib/supabase'
import { usePyodide } from '@/hooks/usePyodide'
import { useTheme } from '@/contexts/ThemeContext'
import { useAuth } from '@/contexts/AuthContext'
import { BackButton } from '@/components/common/BackButton'
import type { Problem } from '@/types/database.types'

interface TestCase {
  input: string
  expected_output: string
}

export default function ProblemDetailPage() {
  const { problemId } = useParams()
  const { theme } = useTheme()
  const { refreshProfile } = useAuth()
  const { ready, initializing, runPython } = usePyodide()
  const [problem, setProblem] = useState<Problem | null>(null)
  const [testCases, setTestCases] = useState<TestCase[]>([])
  const [code, setCode] = useState('')
  const [showHint, setShowHint] = useState(false)
  const [running, setRunning] = useState(false)
  const [results, setResults] = useState<{ pass: boolean; got: string; expected: string }[] | null>(null)
  const [solved, setSolved] = useState(false)

  useEffect(() => {
    if (!problemId) return
    getProblem(problemId).then(async (p) => {
      setProblem(p)
      setCode(p.starter_code || '')
      // Test cases live on the protected `problems` table (not the public view),
      // but RLS still allows select on it — only the `solution` column is meant
      // to stay out of the student-facing UI, which we simply never query.
      const { data } = await supabase.from('problems').select('test_cases').eq('id', p.id).maybeSingle()
      setTestCases((data?.test_cases as TestCase[]) ?? [])
    })
  }, [problemId])

  const handleRunTests = async () => {
    if (!problem) return
    setRunning(true)
    setResults(null)
    const runResults: { pass: boolean; got: string; expected: string }[] = []
    for (const tc of testCases) {
      const stdin = tc.input.split('\n')
      const res = await runPython(code, stdin)
      const got = res.stdout.trim()
      const expected = tc.expected_output.trim()
      runResults.push({ pass: !res.error && got === expected, got: res.error ? `Error: ${res.error}` : got, expected })
    }
    setResults(runResults)
    const allPassed = runResults.length > 0 && runResults.every((r) => r.pass)
    try {
      await submitProblem(problem.id, code, allPassed ? 'passed' : 'failed')
      if (allPassed) {
        setSolved(true)
        await refreshProfile()
        confetti({ particleCount: 100, spread: 75, origin: { y: 0.7 } })
        toast.success(`أحسنت! +${problem.xp} XP 🎉`)
      } else {
        toast.error('بعض الحالات لم تنجح، راجع الناتج وحاول مجددًا.')
      }
    } catch {
      toast.error('تعذّر تسجيل النتيجة، حاول مجددًا')
    }
    setRunning(false)
  }

  if (!problem) return <div className="h-96 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  return (
    <div className="space-y-5">
      <BackButton to="/problems" label="العودة إلى التحديات" />
      <div className="grid grid-cols-1 gap-5 lg:grid-cols-2">
        <div className="space-y-4">
          <div className="card p-5">
            <div className="mb-2 flex items-center gap-2">
              <h1 className="text-xl font-extrabold">
                #{problem.problem_number} {problem.title}
              </h1>
              <span
                className={`rounded-full px-2 py-0.5 text-xs font-semibold ${
                  problem.difficulty === 'easy' ? 'bg-eleven-500/10 text-eleven-600' : 'bg-red-500/10 text-red-500'
                }`}
              >
                {problem.difficulty === 'easy' ? 'Easy' : 'Hard'}
              </span>
            </div>
            <p className="leading-7 text-gray-700 dark:text-gray-300">{problem.description}</p>

          <div className="mt-4 grid grid-cols-2 gap-3 text-sm">
            <div>
              <p className="mb-1 font-semibold text-gray-500">Input</p>
              <p className="text-gray-700 dark:text-gray-300">{problem.input_description}</p>
            </div>
            <div>
              <p className="mb-1 font-semibold text-gray-500">Output</p>
              <p className="text-gray-700 dark:text-gray-300">{problem.output_description}</p>
            </div>
          </div>

          <div className="mt-4 rounded-lg bg-black/5 p-3 font-mono text-xs dark:bg-white/5">
            <p className="text-gray-500">Example Input:</p>
            <p className="mb-2 whitespace-pre-wrap">{problem.example_input}</p>
            <p className="text-gray-500">Example Output:</p>
            <p className="whitespace-pre-wrap">{problem.example_output}</p>
          </div>

          <button onClick={() => setShowHint((s) => !s)} className="mt-4 flex items-center gap-1.5 text-sm font-semibold text-eleven-600 dark:text-eleven-400">
            <Lightbulb size={15} /> {showHint ? 'إخفاء التلميح' : 'إظهار تلميح'}
          </button>
          {showHint && <p className="mt-2 rounded-lg bg-eleven-500/10 p-3 text-sm text-gray-700 dark:text-gray-300">{problem.hint}</p>}
        </div>

          {results && (
            <div className="card space-y-2 p-5">
              <h3 className="font-bold">نتائج الاختبار</h3>
              {results.map((r, i) => (
                <div key={i} className={`flex items-start gap-2 rounded-lg p-2 text-xs ${r.pass ? 'bg-eleven-500/10' : 'bg-red-500/10'}`}>
                  {r.pass ? <CheckCircle2 size={15} className="mt-0.5 shrink-0 text-eleven-500" /> : <XCircle size={15} className="mt-0.5 shrink-0 text-red-500" />}
                  <div className="font-mono">
                    <p>Expected: {r.expected}</p>
                    {!r.pass && <p>Got: {r.got}</p>}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="space-y-3">
          <div className="overflow-hidden rounded-xl border border-black/10 dark:border-white/10">
            <Editor
              height="420px"
              defaultLanguage="python"
              language="python"
              value={code}
              onChange={(v) => setCode(v ?? '')}
              theme={theme === 'dark' ? 'vs-dark' : 'vs'}
              options={{
                automaticLayout: true,
                fontSize: 14,
                minimap: { enabled: true },
                lineNumbers: 'on',
                scrollBeyondLastLine: false,
                padding: { top: 12, bottom: 12 },
                tabSize: 4,
                insertSpaces: true,
                wordWrap: 'off',
                readOnly: false,
                domReadOnly: false,
                contextmenu: true,
                cursorStyle: 'line',
              }}
            />
          </div>
          <button onClick={handleRunTests} disabled={!ready || running || solved} className="btn-primary flex w-full items-center justify-center gap-2">
            {running || initializing ? <Loader2 size={16} className="animate-spin" /> : <Play size={16} />}
            {solved ? 'تم الحل بنجاح ✅' : initializing ? 'تجهيز المحرك...' : running ? 'جارٍ التشغيل...' : 'Run & Submit'}
          </button>
        </div>
      </div>
    </div>
  )
}
