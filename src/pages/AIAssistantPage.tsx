import { useCallback, useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { BackButton } from '@/components/common/BackButton'
import { useTheme } from '@/contexts/ThemeContext'

type Message = { role: 'user' | 'assistant' | 'system'; content: string }

const SYSTEM_PROMPT = `أنت مساعد Eleven AI، مدرس Python للمبتدئين.
أنت تتحدث مع طلاب بدأوا Python من الصفر.
اشرح باللغة العربية وبأسلوب بسيط جدًا.
لا تفترض أن الطالب يعرف أي شيء مسبقًا.
استخدم أمثلة قصيرة.
عند شرح الكود، اشرح الكود جزءًا جزءًا.
إذا كان السؤال صعبًا، قسمه إلى خطوات صغيرة.
لا تستخدم مصطلحات تقنية بدون شرحها.
لا تعطِ إجابات طويلة بدون داعٍ.
هدفك أن تجعل الطالب يفهم الفكرة وليس فقط يحصل على الإجابة.
إذا طلب الطالب حل تمرين، حاول أولًا توجيهه وتوضيح الفكرة بدلًا من إعطائه الحل مباشرة، إلا إذا طلب الحل صراحة.
اجعل أسلوبك ودودًا وتشجيعيًا.`

const QUICK_QUESTIONS = [
  'يعني إيه متغير؟',
  'اشرحلي print',
  'يعني إيه if؟',
  'إيه الفرق بين list و tuple؟',
  'إزاي أعمل loop؟',
  'أنا مبتدئ، أبدأ Python منين؟',
]

export default function AIAssistantPage() {
  const navigate = useNavigate()
  const { theme } = useTheme()
  const [messages, setMessages] = useState<Message[]>([{ role: 'system', content: SYSTEM_PROMPT }])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const containerRef = useRef<HTMLDivElement | null>(null)

  useEffect(() => {
    // scroll to bottom on new assistant message
    const el = containerRef.current
    if (!el) return
    el.scrollTop = el.scrollHeight
  }, [messages])

  const sendMessage = useCallback(async (text: string) => {
    if (!text.trim()) return
    setError(null)
    const userMsg: Message = { role: 'user', content: text }
    setMessages((m) => [...m, userMsg])
    setInput('')
    setLoading(true)

    try {
      // send last N messages as context
      const history = [...messages, userMsg].slice(-10)
      const payload = { messages: history }

      const res = await fetch('/supabase/functions/v1/eleven-ai', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      })

      if (!res.ok) {
        // fallback: local simple responder to allow testing without Supabase function
        const textReply = await fallbackResponder(text)
        setMessages((m) => [...m, { role: 'assistant', content: textReply }])
        setLoading(false)
        return
      }

      const data = await res.json()
      const assistantText = data?.answer ?? data?.result ?? data?.message ?? 'المساعد غير متاح الآن.'
      setMessages((m) => [...m, { role: 'assistant', content: assistantText }])
    } catch (err: any) {
      const textReply = await fallbackResponder(text)
      setMessages((m) => [...m, { role: 'assistant', content: textReply }])
    } finally {
      setLoading(false)
    }
  }, [messages])

  const onSubmit = (e?: React.FormEvent) => {
    e?.preventDefault()
    if (loading) return
    sendMessage(input)
  }

  const handleQuick = (q: string) => {
    sendMessage(q)
  }

  return (
    <div className="mx-auto max-w-5xl p-4">
      <div className="flex items-center gap-3">
        <button onClick={() => navigate(-1)} className="text-sm font-medium text-gray-600 dark:text-gray-200">
          ← رجوع
        </button>
        <h1 className="text-xl font-extrabold text-slate-900 dark:text-white">مساعد Eleven AI 🤖</h1>
      </div>

      <p className="mt-2 text-sm text-gray-600 dark:text-gray-300">مساعدك في تعلم Python — اسألني عن أي حاجة في Python وهشرحها لك خطوة بخطوة وبطريقة بسيطة جدًا.</p>

      <div className="mt-4 grid gap-4 md:grid-cols-[1fr_320px]">
        <div className="space-y-3">
          <div className="card h-[60vh] overflow-hidden p-3">
            <div ref={containerRef} className="flex h-full flex-col gap-3 overflow-auto p-2">
              {messages.filter(m => m.role !== 'system').map((m, idx) => (
                <div key={idx} className={m.role === 'user' ? 'self-end max-w-[85%]' : 'self-start max-w-[85%]'}>
                  <div className={`rounded-lg p-3 text-sm leading-6 ${m.role === 'user' ? 'bg-eleven-500/10 text-slate-900 dark:bg-eleven-500/20' : 'bg-gray-100 text-slate-900 dark:bg-slate-800 dark:text-slate-100'}`}>
                    <div dangerouslySetInnerHTML={{ __html: escapeHtml(m.content).replace(/\n/g, '<br/>') }} />
                  </div>
                </div>
              ))}
              {loading && (
                <div className="self-start">
                  <div className="rounded-lg bg-gray-100 p-3 text-sm dark:bg-slate-800">المساعد بيفكر...</div>
                </div>
              )}
            </div>
          </div>

          <form onSubmit={onSubmit} className="flex gap-2">
            <textarea
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault()
                  onSubmit()
                }
              }}
              placeholder="اكتب سؤالك عن Python..."
              className="h-24 w-full resize-none rounded-lg border px-3 py-2 text-sm focus:outline-none dark:bg-slate-900"
            />
            <button
              type="submit"
              disabled={loading}
              className="inline-flex items-center gap-2 rounded-lg bg-eleven-500 px-4 py-2 text-sm font-semibold text-white disabled:opacity-60"
            >
              إرسال
            </button>
          </form>
        </div>

        <aside className="space-y-4">
          <div className="card p-3">
            <h3 className="mb-2 text-sm font-bold">أسئلة سريعة</h3>
            <div className="flex flex-col gap-2">
              {QUICK_QUESTIONS.map((q) => (
                <button key={q} onClick={() => handleQuick(q)} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">
                  {q}
                </button>
              ))}
            </div>
          </div>

          <div className="card p-3">
            <h3 className="mb-2 text-sm font-bold">إجراءات سريعة</h3>
            <div className="flex flex-col gap-2">
              <button onClick={() => sendQuickAction('اشرح أبسط')} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">اشرح أبسط</button>
              <button onClick={() => sendQuickAction('اديني مثال')} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">اديني مثال</button>
              <button onClick={() => sendQuickAction('اديني تمرين')} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">اديني تمرين</button>
              <button onClick={() => sendQuickAction('اشرح الكود')} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">اشرح الكود</button>
              <button onClick={() => sendQuickAction('فين الغلط؟')} className="rounded-md px-3 py-2 text-sm text-left hover:bg-slate-100 dark:hover:bg-slate-800">فين الغلط؟</button>
            </div>
          </div>
        </aside>
      </div>
    </div>
  )

  async function sendQuickAction(action: string) {
    // reuse last user message as context
    const lastUser = messages.slice().reverse().find(m => m.role === 'user')
    const text = lastUser ? `${lastUser.content}\n\n${action}` : action
    await sendMessage(text)
  }
}

function escapeHtml(unsafe: string) {
  return unsafe.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
}

async function fallbackResponder(text: string) {
  // Very small heuristic-based responder for local testing when server isn't configured.
  const t = text.toLowerCase()
  if (t.includes('print')) {
    return `السطر ده بيستخدم أمر اسمه print.\nوظيفة print إنه يعرض حاجة على الشاشة.\nمثال:\nprint("Hello")\nالنتيجة هتكون:\nHello\nيعني ببساطة: print = اعرض حاجة على الشاشة.`
  }
  if (t.includes('متغير') || t.includes('variable') || t.includes('x =') || t.includes('=')) {
    return `Variable يعني متغير، وده ببساطة مكان بنخزن فيه قيمة.\nمثال:\nx = 10\nهنا x اسم المتغير و10 القيمة المخزنة جواه.`
  }
  if (t.includes('if')) {
    return `الـ if بيستخدم لاتخاذ قرار بناءً على شرط.\nمثال:\nif x > 5:\n  print("كبير")\nيعني: لو x أكبر من 5، اطبع كلمة "كبير".`
  }
  return `ممتاز، سؤالك كويس. هكتب لك شرح بسيط خطوة بخطوة لو سمحت وضّح لي الجزء اللي عايز تشرحه بالظبط أو اكتب مثال صغير.`
}
 