import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import confetti from 'canvas-confetti'
import toast from 'react-hot-toast'
import { Lightbulb, CheckCircle2, XCircle } from 'lucide-react'
import { getProblem, submitProblem } from '@/services/content'
import { supabase } from '@/lib/supabase'
import { CodeBlock } from '@/components/lesson/CodeBlock'
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
  const [problem, setProblem] = useState<Problem | null>(null)
  const [testCases, setTestCases] = useState<TestCase[]>([])
  const [showHint, setShowHint] = useState(false)
  const [selected, setSelected] = useState<string | null>(null)
  const [submittedResult, setSubmittedResult] = useState<{ correct: boolean; correctOption: string } | null>(null)

  useEffect(() => {
    if (!problemId) return
    getProblem(problemId).then(async (p) => {
      setProblem(p)
      // Test cases live on the protected `problems` table (not the public view),
      // but RLS still allows select on it — only the `solution` column is meant
      // to stay out of the student-facing UI, which we simply never query.
      const { data } = await supabase.from('problems').select('test_cases').eq('id', p.id).maybeSingle()
      setTestCases((data?.test_cases as TestCase[]) ?? [])
    })
  }, [problemId])



  if (!problem) return <div className="h-96 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  // Determine correct answer from example_output (preferred).
  const correct = (problem.example_output ?? '').toString().trim() || (problem.starter_code ?? '').toString().trim() || ''

  function generateOptions(answer: string) {
    const opts: string[] = []
    if (!answer) {
      return ['لا يوجد ناتج', '0', 'Error', 'محتوى مختلف']
    }

    const num = Number(answer)
    if (!Number.isNaN(num) && String(num) === answer) {
      // numeric: create numeric distractors
      opts.push(answer)
      opts.push(String(num + 1))
      opts.push(String(Math.max(0, num - 1)))
      opts.push('Error')
      return opts
    }

    // text output: create safe distractors
    opts.push(answer)
    // quoted version
    opts.push(`"${answer}"`)
    // generic wrong answer
    opts.push('Error')
    // another simple different text
    opts.push('محتوى مختلف')
    return opts
  }

  const options = generateOptions(correct)

  const handleSelect = async (opt: string) => {
    if (!problem) return
    if (submittedResult) return
    setSelected(opt)
    const isCorrect = opt === correct
    setSubmittedResult({ correct: isCorrect, correctOption: correct })
    try {
      await submitProblem(problem.id, opt, isCorrect ? 'passed' : 'failed')
      if (isCorrect) {
        confetti({ particleCount: 80, spread: 60, origin: { y: 0.7 } })
        toast.success(`أحسنت! +${problem.xp} XP 🎉`)
      } else {
        toast.error('حاول تاني — الإجابة الصحيحة معروضة.')
      }
    } catch {
      toast.error('تعذّر تسجيل النتيجة، حاول مجددًا')
    }
  }

  return (
    <div className="space-y-5">
      <BackButton to="/problems" label="العودة إلى التحديات" />

      <div className="grid grid-cols-1 gap-5 lg:grid-cols-2">
        <div className="card p-5">
          <h1 className="text-xl font-extrabold">#{problem.problem_number} {problem.title}</h1>
          <p className="mt-3 text-sm text-gray-700 dark:text-gray-300">{problem.description}</p>

          <div className="mt-4 grid grid-cols-1 gap-3 text-sm">
            <div>
              <p className="mb-1 font-semibold text-gray-500">مثال مدخل:</p>
              <p className="text-gray-700 dark:text-gray-300">{problem.example_input}</p>
            </div>
            <div>
              <p className="mb-1 font-semibold text-gray-500">مثال مخرج:</p>
              <p className="text-gray-700 dark:text-gray-300">{problem.example_output}</p>
            </div>
          </div>

          <div className="mt-4">
            <button onClick={() => setShowHint((s) => !s)} className="text-sm font-semibold text-eleven-600">
              <Lightbulb size={15} /> {showHint ? 'إخفاء التلميح' : 'إظهار تلميح'}
            </button>
            {showHint && <p className="mt-2 rounded-lg bg-eleven-500/10 p-3 text-sm text-gray-700 dark:text-gray-300">{problem.hint}</p>}
          </div>
        </div>

        <div className="card p-5">
          <h3 className="mb-3 font-bold">📌 مثال كود للقراءة</h3>
          <CodeBlock code={correct} title="Python" />
          <p className="mt-3 text-sm text-gray-700 dark:text-gray-300">هذا الكود للقراءة فقط. اختر الإجابة الصحيحة من الأسفل.</p>

          <div className="mt-4 space-y-3">
            {options.map((opt, idx) => {
              const disabled = !!submittedResult
              const isSelected = selected === opt
              const showCorrectness = !!submittedResult
              const isCorrect = opt === correct
              const isWrongSelected = showCorrectness && isSelected && !isCorrect
              const btnClass = showCorrectness ? (isCorrect ? 'border-eleven-500 bg-eleven-500/10' : isWrongSelected ? 'border-red-400 bg-red-500/10' : 'border-black/10 bg-transparent') : isSelected ? 'border-eleven-500/60 bg-eleven-500/5' : 'border-black/10 hover:bg-black/5'

              return (
                <button key={idx} disabled={disabled} onClick={() => handleSelect(opt)} className={`flex w-full items-center justify-between rounded-lg border px-3 py-3 text-right text-sm transition ${btnClass}`}>
                  <span className="flex-1 text-sm font-mono whitespace-pre-wrap text-left">{opt}</span>
                </button>
              )
            })}
          </div>
        </div>
      </div>
    </div>
  )
}
