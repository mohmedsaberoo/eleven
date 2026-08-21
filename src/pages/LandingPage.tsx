import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'
import { Code2, Trophy, Terminal, TrendingUp, Sparkles, Rocket } from 'lucide-react'

const features = [
  { icon: Sparkles, title: 'لماذا Eleven؟', text: 'منهج متدرج من print() الأولى وحتى البرمجة الكائنية، بدون أي معرفة مسبقة مطلوبة.' },
  { icon: TrendingUp, title: 'خارطة تعلم واضحة', text: '20 فصلًا و160 درسًا مرتبة منطقيًا، كل فصل يفتح التالي حسب تقدمك.' },
  { icon: Code2, title: 'حل المسائل', text: '30 تحديًا برمجيًا بمستويين لتطبيق ما تتعلمه فعليًا وبناء ثقتك.' },
  { icon: Terminal, title: 'Playground تفاعلي', text: 'شغّل كود Python حقيقي مباشرة من المتصفح دون أي تثبيت.' },
  { icon: TrendingUp, title: 'تتبع تقدمك', text: 'XP، مستويات، Streak يومي، وإحصائيات دقيقة لرحلتك.' },
  { icon: Trophy, title: 'إنجازات تحفزك', text: 'افتح أوسمة مميزة مع كل خطوة تنجزها في رحلتك البرمجية.' },
]

export default function LandingPage() {
  return (
    <div className="relative min-h-screen overflow-hidden bg-white dark:bg-night-950">
      {/* background glow */}
      <div className="pointer-events-none absolute -top-40 left-1/2 h-[500px] w-[500px] -translate-x-1/2 rounded-full bg-eleven-500/20 blur-3xl animate-glow" />

      <header className="relative z-10 mx-auto flex max-w-6xl items-center justify-between px-6 py-6">
        <div className="flex items-center gap-2 text-xl font-extrabold">
          <span className="text-gradient">ELEVEN</span> <span>🐍</span>
        </div>
        <div className="flex gap-2">
          <Link to="/login" className="rounded-full px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-black/5 dark:text-gray-200 dark:hover:bg-white/5">
            تسجيل الدخول
          </Link>
          <Link to="/signup" className="rounded-full bg-eleven-500 px-4 py-2 text-sm font-semibold text-white hover:bg-eleven-600">
            ابدأ التعلم
          </Link>
        </div>
      </header>

      <section className="relative z-10 mx-auto max-w-4xl px-6 pb-20 pt-10 text-center">
        <motion.div initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }} className="animate-float">
          <span className="mb-4 inline-block rounded-full bg-eleven-500/10 px-4 py-1.5 text-sm font-semibold text-eleven-600 dark:text-eleven-400">
            Learn. Code. Build. 🚀
          </span>
        </motion.div>
        <motion.h1
          initial={{ opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.1 }}
          className="text-4xl font-extrabold leading-tight md:text-6xl"
        >
          Learn Python <span className="text-gradient">From Zero.</span>
        </motion.h1>
        <motion.p
          initial={{ opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.2 }}
          className="mx-auto mt-5 max-w-2xl text-lg text-gray-600 dark:text-gray-300"
        >
          ابدأ رحلتك في تعلّم بايثون من الصفر تمامًا، وابنِ مهارات برمجية حقيقية خطوة بخطوة، مع دروس تفاعلية، محرر كود مباشر، وتحديات تطبيقية.
        </motion.p>
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.3 }}
          className="mt-8 flex flex-wrap items-center justify-center gap-3"
        >
          <Link to="/signup" className="flex items-center gap-2 rounded-full bg-eleven-500 px-6 py-3 font-semibold text-white shadow-lg shadow-eleven-500/30 transition hover:bg-eleven-600 hover:shadow-eleven-500/50">
            <Rocket size={18} /> Start Learning
          </Link>
          <Link to="/login" className="rounded-full border border-black/10 px-6 py-3 font-semibold text-gray-700 hover:bg-black/5 dark:border-white/10 dark:text-gray-200 dark:hover:bg-white/5">
            Login
          </Link>
        </motion.div>
      </section>

      <section className="relative z-10 mx-auto max-w-6xl px-6 pb-24">
        <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {features.map((f, i) => (
            <motion.div
              key={f.title}
              initial={{ opacity: 0, y: 16 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.4, delay: i * 0.05 }}
              className="rounded-2xl border border-black/5 bg-black/[0.02] p-6 transition hover:-translate-y-1 hover:shadow-lg dark:border-white/5 dark:bg-white/[0.02]"
            >
              <f.icon className="mb-3 text-eleven-500" size={26} />
              <h3 className="mb-1.5 font-bold">{f.title}</h3>
              <p className="text-sm text-gray-600 dark:text-gray-400">{f.text}</p>
            </motion.div>
          ))}
        </div>
      </section>

      <footer className="relative z-10 border-t border-black/5 py-8 text-center text-sm text-gray-500 dark:border-white/5 dark:text-gray-400">
        © 2026 Eleven — Abo_Saber@Eleven
      </footer>
    </div>
  )
}
