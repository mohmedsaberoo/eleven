import { useEffect, useMemo, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { motion } from 'framer-motion'
import confetti from 'canvas-confetti'
import toast from 'react-hot-toast'
import { ArrowLeft, ArrowRight, CheckCircle2, Lightbulb, Target, TriangleAlert, Zap } from 'lucide-react'
import { supabase } from '@/lib/supabase'
import { useAuth } from '@/contexts/AuthContext'
import { getLesson, getLessonQuizzes, completeLesson, getUserProgress } from '@/services/content'
// Note: interactive CodeRunner/IDE intentionally removed from lesson flow.
import { QuizWidget } from '@/components/lesson/QuizWidget'
import { CodeBlock } from '@/components/lesson/CodeBlock'
import { CodeExplanation } from '@/components/lesson/CodeExplanation'
import { BackButton } from '@/components/common/BackButton'
import type { Lesson, Quiz } from '@/types/database.types'

function renderInlineCode(text: string) {
  const pattern = /(print\(\)|input\(\)|if|else|for|while|len\(\)|range\(\)|int\(\)|float\(\)|str\(\)|list\(\)|True|False|None|and|or|not)/g
  const escaped = text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
  return escaped.replace(pattern, '<code class="inline-code">$1</code>')
}

function buildPedagogicLesson(lesson: Lesson) {
  const title = lesson.title
  const lessonNameLower = title.toLowerCase()
  const challengeText = lesson.content?.challenge?.prompt || 'جرب كودًا صغيرًا بنفسك.'
  const starterCode = lesson.content?.challenge?.starter_code || 'print("اكتب كودك هنا")'

  const learningGoal = `هنتعلم إيه؟\n${lesson.objectives?.[0] || `الفكرة الأساسية في ${title} من الصفر.`}`
  const simpleIdea = `الفكرة ببساطة:\n${lesson.summary || `في هذا الدرس هنتعرف على ${title} خطوة بخطوة.`}`
  const breakdown = [
    { label: 'الخطوة 1', text: 'نقرأ الكود ببطء، وليس كأنه جملة معقدة.' },
    { label: 'الخطوة 2', text: 'نلاحظ كل جزء من الكود: الكلمات، القوسين، القيم، والأوامر.' },
    { label: 'الخطوة 3', text: 'افهم الناتج المتوقّع من كل سطر؛ لا تحتاج للكتابة داخل المنصة.' },
  ]

  const exampleText = `مثال بسيط جدًا:\nلو عايز ${lessonNameLower.includes('print') ? 'تخلي الكمبيوتر يكتب كلمة على الشاشة' : lessonNameLower.includes('variable') ? 'تخزين قيمة في متغير' : lessonNameLower.includes('input') ? 'تخلي المستخدم يدخل قيمة' : lessonNameLower.includes('if') ? 'تحدّد قرار حسب شرط' : lessonNameLower.includes('loop') ? 'تكرار نفس الخطوة أكثر من مرة' : `تطبيق فكرة ${title}`}.`

  return {
    learningGoal,
    simpleIdea,
    breakdown,
    exampleText,
    challengeText,
    starterCode,
    quickQuestion: `سؤال سريع:\nلو غيرت قيمة المثال، هل ستتغير النتيجة؟ حاول تجريب ذلك بنفسك.`,
    hint: `💡 تلميح:\nابدأ من المثال الحالي، ثم غيّر قيمة واحدة فقط، وشغّل الكود مرة أخرى.`,
    success: '🏆 أحسنت! أنت الآن بدأت تفهم الفكرة بدل مجرد حفظ الكود.',
  }
}

export default function LessonPage() {
  const { lessonId } = useParams()
  const navigate = useNavigate()
  const { user, refreshProfile } = useAuth()
  const [lesson, setLesson] = useState<Lesson | null>(null)
  const [quizzes, setQuizzes] = useState<Quiz[]>([])
  const [siblingLessons, setSiblingLessons] = useState<{ id: string; lesson_number: number; title: string }[]>([])
  const [chapterNumber, setChapterNumber] = useState<number | null>(null)
  const [completed, setCompleted] = useState(false)
  const [loading, setLoading] = useState(true)
  const [marking, setMarking] = useState(false)

  useEffect(() => {
    if (!lessonId || !user) return
    setLoading(true)
    ;(async () => {
      const l = await getLesson(lessonId)
      const [qz, progress, { data: chapter }, { data: siblings }] = await Promise.all([
        getLessonQuizzes(lessonId),
        getUserProgress(user.id),
        supabase.from('chapters').select('chapter_number').eq('id', l.chapter_id).single(),
        supabase.from('lessons').select('id, lesson_number, title').eq('chapter_id', l.chapter_id).order('lesson_number'),
      ])
      setLesson(l)
      setQuizzes(qz)
      setChapterNumber(chapter?.chapter_number ?? null)
      setSiblingLessons(siblings ?? [])
      setCompleted(progress.some((p) => p.lesson_id === lessonId && p.completed))
      setLoading(false)
    })()
  }, [lessonId, user])

  const handleComplete = async () => {
    if (!lessonId || completed) return
    setMarking(true)
    try {
      await completeLesson(lessonId)
      setCompleted(true)
      await refreshProfile()
      confetti({ particleCount: 90, spread: 70, origin: { y: 0.7 }, colors: ['#43cb7c', '#79e0a1', '#20b060'] })
      toast.success(`+${lesson?.xp_reward ?? 10} XP 🎉`)
    } catch {
      toast.error('حدث خطأ، حاول مجددًا')
    } finally {
      setMarking(false)
    }
  }

  const explanationParagraphs = useMemo(
    () => (lesson?.content.explanation ?? '').split(/\n+/).map((p) => p.trim()).filter(Boolean),
    [lesson],
  )

  const pedagogicLesson = useMemo(
    () => buildPedagogicLesson(lesson ?? {
      id: 'loading',
      chapter_id: '',
      lesson_number: 1,
      title: 'جارٍ تحميل الدرس',
      summary: 'جارٍ تحميل المحتوى التعليمي.',
      objectives: ['تحميل المحتوى من الصفر'],
      content: {
        explanation: 'جارٍ التحميل...',
        code_examples: [],
        common_mistakes: [],
        tips: [],
        challenge: { prompt: 'جارٍ التحميل...', starter_code: 'print("جارٍ التحميل...")' },
      },
      duration_minutes: 5,
      xp_reward: 10,
      created_at: new Date().toISOString(),
    }),
    [lesson],
  )

  if (loading || !lesson) return <div className="h-96 animate-pulse rounded-2xl bg-black/5 dark:bg-white/5" />

  const currentIndex = siblingLessons.findIndex((s) => s.id === lesson.id)
  const prevLesson = currentIndex > 0 ? siblingLessons[currentIndex - 1] : null
  const nextLesson = currentIndex >= 0 && currentIndex < siblingLessons.length - 1 ? siblingLessons[currentIndex + 1] : null
  const progressPercent = ((currentIndex + 1) / Math.max(1, siblingLessons.length)) * 100

  return (
    <div className="mx-auto max-w-6xl space-y-6 pb-6">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <BackButton to={chapterNumber ? `/chapter/${chapterNumber}` : '/roadmap'} label="العودة إلى الفصل" />
        <div className="flex items-center gap-2 text-xs font-medium text-gray-500 dark:text-gray-400">
          <span>فصل {chapterNumber ?? 1}</span>
          <span>•</span>
          <span>الدرس {lesson.lesson_number} من {siblingLessons.length || lesson.lesson_number}</span>
        </div>
      </div>

      <header className="card overflow-hidden p-5 md:p-6">
        <div className="mb-4 flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.18em] text-eleven-600 dark:text-eleven-300">
              درس {lesson.lesson_number}
            </p>
            <h1 className="mt-2 text-2xl font-black text-slate-900 dark:text-white md:text-3xl">{lesson.title}</h1>
          </div>
          <div className="rounded-full border border-eleven-500/20 bg-eleven-500/10 px-3 py-1.5 text-xs font-semibold text-eleven-700 dark:text-eleven-300">
            +{lesson.xp_reward} XP
          </div>
        </div>

        <p className="mb-4 max-w-3xl text-sm leading-7 text-gray-600 dark:text-gray-300">{lesson.summary}</p>

        <div className="space-y-2">
          <div className="flex items-center justify-between text-xs font-medium text-gray-500 dark:text-gray-400">
            <span>التقدم</span>
            <span>{Math.round(progressPercent)}%</span>
          </div>
          <div className="h-2.5 w-full overflow-hidden rounded-full bg-black/5 dark:bg-white/10">
            <div className="h-full rounded-full bg-gradient-to-r from-eleven-400 to-eleven-600" style={{ width: `${progressPercent}%` }} />
          </div>
        </div>
      </header>

      <main className="grid gap-6 xl:grid-cols-[1.5fr_0.9fr]">
        <article className="space-y-6">
          {lesson.objectives?.length > 0 && (
            <section className="card p-5 md:p-6">
              <h2 className="mb-4 flex items-center gap-2 text-lg font-bold text-slate-900 dark:text-white">
                <Target size={18} className="text-eleven-500" /> أهداف التعلم
              </h2>
              <ul className="space-y-3 text-sm leading-7 text-gray-700 dark:text-gray-300">
                {lesson.objectives.map((o, index) => (
                  <li key={`${o}-${index}`} className="flex items-start gap-3">
                    <CheckCircle2 size={16} className="mt-1 shrink-0 text-eleven-500" />
                    <span>{o}</span>
                  </li>
                ))}
              </ul>
            </section>
          )}

          <section className="card p-5 md:p-6">
            <h2 className="mb-4 text-xl font-black text-slate-900 dark:text-white">🎯 {pedagogicLesson.learningGoal.split('\n')[0]}</h2>
            <div className="space-y-4 text-base leading-8 text-gray-700 dark:text-gray-300">
              <p className="rounded-2xl border border-eleven-500/20 bg-eleven-500/5 p-4 text-sm leading-7 text-slate-700 dark:text-slate-200">
                {pedagogicLesson.learningGoal.split('\n').slice(1).join(' ')}
              </p>
              <p className="rounded-2xl border border-sky-500/20 bg-sky-500/5 p-4 text-sm leading-7 text-slate-700 dark:text-slate-200">
                {pedagogicLesson.simpleIdea.split('\n').slice(1).join(' ')}
              </p>
            </div>
          </section>

          <section className="card p-5 md:p-6">
            <h2 className="mb-4 text-xl font-black text-slate-900 dark:text-white">🧠 الفكرة ببساطة</h2>
            <div className="space-y-4 text-base leading-8 text-gray-700 dark:text-gray-300">
              {explanationParagraphs.map((paragraph, index) => (
                <p key={`${paragraph.slice(0, 20)}-${index}`} dangerouslySetInnerHTML={{ __html: renderInlineCode(paragraph) }} />
              ))}
            </div>
          </section>

          <section className="card p-5 md:p-6">
            <h2 className="mb-4 text-xl font-black text-slate-900 dark:text-white">🔍 نفك الكود</h2>
            <CodeExplanation steps={pedagogicLesson.breakdown} />
          </section>

          {lesson.content.code_examples?.length > 0 && (
            <section className="space-y-4">
              {lesson.content.code_examples.map((example, index) => (
                <div key={`${example.code.slice(0, 20)}-${index}`} className="card p-5 md:p-6">
                  <h3 className="mb-3 flex items-center gap-2 text-base font-bold text-slate-900 dark:text-white">
                    <Zap size={16} className="text-eleven-500" /> مثال بسيط جدًا {index + 1}
                  </h3>
                  <CodeBlock code={example.code} title="Python" />
                  <p className="mt-4 text-sm leading-7 text-gray-600 dark:text-gray-300" dangerouslySetInnerHTML={{ __html: renderInlineCode(example.explanation) }} />
                </div>
              ))}
            </section>
          )}

          <section className="card p-5 md:p-6">
            <h2 className="mb-4 text-xl font-black text-slate-900 dark:text-white">▶️ مثال للقراءة</h2>
            <p className="mb-3 text-sm leading-7 text-gray-700 dark:text-gray-300">{pedagogicLesson.exampleText}</p>
            <p className="mb-4 text-sm leading-7 text-gray-700 dark:text-gray-300">اقرأ المثال ببطء. الكود هنا للقراءة فقط — تقدر تنسخه بجانبك لو حبيت تجرب خارجيًا.</p>
            <CodeBlock code={pedagogicLesson.starterCode} title="مثال" />
          </section>

          {lesson.content.common_mistakes?.length > 0 && (
            <section className="card border-orange-500/20 bg-orange-500/5 p-5 md:p-6">
              <h3 className="mb-3 flex items-center gap-2 text-lg font-bold text-orange-700 dark:text-orange-300">
                <TriangleAlert size={18} /> أخطاء شائعة
              </h3>
              <ul className="space-y-2 text-sm leading-7 text-gray-700 dark:text-gray-200">
                {lesson.content.common_mistakes.map((mistake, index) => (
                  <li key={`${mistake}-${index}`} className="flex items-start gap-2">
                    <span className="mt-1.5 h-2 w-2 rounded-full bg-orange-500" />
                    <span>{mistake}</span>
                  </li>
                ))}
              </ul>
            </section>
          )}

          {lesson.content.tips?.length > 0 && (
            <section className="card border-eleven-500/20 bg-eleven-500/5 p-5 md:p-6">
              <h3 className="mb-3 flex items-center gap-2 text-lg font-bold text-eleven-700 dark:text-eleven-300">
                <Lightbulb size={18} /> نصيحة
              </h3>
              <ul className="space-y-2 text-sm leading-7 text-gray-700 dark:text-gray-200">
                {lesson.content.tips.map((tip, index) => (
                  <li key={`${tip}-${index}`} className="flex items-start gap-2">
                    <span className="mt-1.5 h-2 w-2 rounded-full bg-eleven-500" />
                    <span>{tip}</span>
                  </li>
                ))}
              </ul>
            </section>
          )}

          {lesson.content.challenge && (
            <section className="card p-5 md:p-6">
              <h3 className="mb-3 text-xl font-black text-slate-900 dark:text-white">🎯 تحدي صغير</h3>
              <p className="mb-4 text-sm leading-7 text-gray-600 dark:text-gray-300">{pedagogicLesson.challengeText}</p>
              <CodeBlock code={pedagogicLesson.starterCode} title="Starter Code" />
              <div className="mt-5 rounded-2xl border border-dashed border-eleven-500/30 bg-eleven-500/5 p-4 text-sm text-gray-700 dark:text-gray-200">
                هذا المثال للقراءة فقط — انسخه وجربه خارج المنصة إذا رغبت. الهدف هنا هو الفهم والملاحظة، لا كتابة الكود داخل الدرس.
              </div>
            </section>
          )}

          <section className="card p-5 md:p-6">
            <h2 className="mb-3 text-xl font-black text-slate-900 dark:text-white">❓ سؤال سريع</h2>
            <p className="mb-3 text-sm leading-7 text-gray-700 dark:text-gray-300">{pedagogicLesson.quickQuestion.split('\n').slice(1).join(' ')}</p>
            <p className="text-sm leading-7 text-gray-700 dark:text-gray-300">{pedagogicLesson.hint.split('\n').slice(1).join(' ')}</p>
          </section>

          <div className="card p-5 md:p-6">
            <h4 className="mb-3 text-base font-black text-slate-900 dark:text-white">🏆 أحسنت</h4>
            <p className="text-sm leading-7 text-gray-700 dark:text-gray-300">{pedagogicLesson.success}</p>
          </div>

          {lesson.content.challenge && (
            <section className="card p-5 md:p-6">
              <div className="mb-4 flex items-center justify-between gap-3">
                <h3 className="text-xl font-black text-slate-900 dark:text-white">🐍 مثال</h3>
              </div>
              <CodeBlock code={lesson.content.challenge.starter_code} title="مثال" />
              <div className="mt-3 text-sm text-gray-700 dark:text-gray-300">
                <p className="font-semibold">💡 ببساطة:</p>
                <p>هنا مثال جاهز للقراءة فقط. لا تحتاج لكتابة أو تشغيل أي كود.</p>
              </div>
            </section>
          )}

          <div className="card p-5 md:p-6">
            <CodeExplanation
              steps={[
                { label: 'الخطوة الأولى', text: 'اقرأ الكود ببطء وفهم كل سطر.' },
                { label: 'التجربة', text: 'انسخ المثال إذا حبيت جرّبه خارج المنصة، لاحظ الناتج.' },
                { label: 'التأكيد', text: 'اسأل نفسك: هل فهمت لماذا هذا السطر موجود؟' },
              ]}
            />
          </div>

          <QuizWidget lessonId={lesson.id} quizzes={quizzes} />

          <div className="flex flex-col gap-3 rounded-2xl border border-black/10 bg-slate-50 p-4 dark:border-white/10 dark:bg-slate-900/40 sm:flex-row sm:items-center sm:justify-between">
            {!completed ? (
              <button onClick={handleComplete} disabled={marking} className="btn-primary w-full sm:w-auto">
                {marking ? 'جارٍ الحفظ...' : `إنهاء الدرس (+${lesson.xp_reward} XP)`}
              </button>
            ) : (
              <div className="flex items-center gap-2 text-sm font-semibold text-eleven-700 dark:text-eleven-300">
                <CheckCircle2 size={18} /> تم إكمال الدرس
              </div>
            )}

            <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
              <span>الدرس {lesson.lesson_number}</span>
              <span>•</span>
              <span>{lesson.duration_minutes} دقيقة</span>
            </div>
          </div>
        </article>

        <aside className="space-y-6">
          <div className="card p-5">
            <h3 className="mb-3 text-lg font-bold text-slate-900 dark:text-white">ملخص سريع</h3>
            <ul className="space-y-2 text-sm leading-7 text-gray-700 dark:text-gray-300">
              {lesson.objectives.map((objective, index) => (
                <li key={`${objective}-${index}`} className="flex gap-2">
                  <span className="text-eleven-500">•</span>
                  <span>{objective}</span>
                </li>
              ))}
            </ul>
          </div>

          <div className="card p-5">
            <h3 className="mb-3 text-lg font-bold text-slate-900 dark:text-white">🚀 التالي</h3>
            <p className="text-sm leading-7 text-gray-600 dark:text-gray-300">
              بعد فهم هذا الدرس، اذهب إلى التمرين التالي وجرّب كتابة كود مختلف بنفس الفكرة. كل تمرين يبني مهارتك خطوة بخطوة.
            </p>
          </div>
        </aside>
      </main>

      <div className="flex items-center justify-between gap-3 pt-2">
        {prevLesson ? (
          <button onClick={() => navigate(`/lesson/${prevLesson.id}`)} className="btn-secondary inline-flex items-center gap-2">
            <ArrowRight size={16} /> الدرس السابق
          </button>
        ) : (
          <span />
        )}

        {nextLesson ? (
          <button onClick={() => navigate(`/lesson/${nextLesson.id}`)} className="btn-primary inline-flex items-center gap-2">
            الدرس التالي <ArrowLeft size={16} />
          </button>
        ) : (
          <button onClick={() => navigate('/roadmap')} className="btn-primary inline-flex items-center gap-2">
            العودة إلى الخريطة <ArrowLeft size={16} />
          </button>
        )}
      </div>
    </div>
  )
}
