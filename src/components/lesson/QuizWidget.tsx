import { useState } from 'react'
import { CheckCircle2, XCircle } from 'lucide-react'
import toast from 'react-hot-toast'
import type { Quiz } from '@/types/database.types'
import { submitQuiz } from '@/services/content'

export function QuizWidget({ lessonId, quizzes }: { lessonId: string; quizzes: Quiz[] }) {
  const [answers, setAnswers] = useState<Record<string, string>>({})
  const [result, setResult] = useState<{ score: number; total: number } | null>(null)
  const [submitting, setSubmitting] = useState(false)

  if (quizzes.length === 0) return null

  const allAnswered = quizzes.every((q) => answers[q.id])

  const handleSubmit = async () => {
    setSubmitting(true)
    try {
      const res = await submitQuiz(lessonId, answers)
      setResult(res)
      toast.success(`النتيجة: ${res.score}/${res.total} 🎯`)
    } catch {
      toast.error('حدث خطأ أثناء تسليم الاختبار')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="card space-y-5 p-5">
      <h3 className="font-bold">📝 Quiz قصير</h3>
      {quizzes.map((q, idx) => (
        <div key={q.id}>
          <p className="mb-2 text-sm font-medium">
            {idx + 1}. {q.question}
          </p>
          <div className="space-y-1.5">
            {q.options.map((opt) => {
              const selected = answers[q.id] === opt
              const showCorrectness = !!result
              const isCorrect = showCorrectness && opt === q.correct_answer
              const isWrongSelected = showCorrectness && selected && opt !== q.correct_answer
              return (
                <button
                  key={opt}
                  disabled={!!result}
                  onClick={() => setAnswers({ ...answers, [q.id]: opt })}
                  className={`flex w-full items-center justify-between rounded-lg border px-3 py-2 text-right text-sm transition ${
                    isCorrect
                      ? 'border-eleven-500 bg-eleven-500/10'
                      : isWrongSelected
                      ? 'border-red-400 bg-red-500/10'
                      : selected
                      ? 'border-eleven-500/60 bg-eleven-500/5'
                      : 'border-black/10 hover:bg-black/5 dark:border-white/10 dark:hover:bg-white/5'
                  }`}
                >
                  {opt}
                  {isCorrect && <CheckCircle2 size={16} className="text-eleven-500" />}
                  {isWrongSelected && <XCircle size={16} className="text-red-400" />}
                </button>
              )
            })}
          </div>
        </div>
      ))}
      {!result ? (
        <button disabled={!allAnswered || submitting} onClick={handleSubmit} className="btn-primary w-full">
          {submitting ? 'جارٍ التسليم...' : 'تسليم الإجابات'}
        </button>
      ) : (
        <div className="rounded-xl bg-eleven-500/10 p-3 text-center font-bold text-eleven-600 dark:text-eleven-400">
          النتيجة: {result.score} / {result.total}
        </div>
      )}
    </div>
  )
}
