# Eleven — Learn Python From Zero 🐍

منصة تعليم Python للمبتدئين من الصفر تمامًا — Landing page، مصادقة، 20 فصلًا (160 درسًا)، Playground حقيقي يشغّل Python عبر WebAssembly، 30 مسألة برمجية، نظام XP/Achievements، ولوحة تحكم Admin.

`© 2026 Eleven — Abo_Saber@Eleven`

---

## Tech Stack

React + TypeScript + Vite + Tailwind CSS + Supabase (Auth + Postgres + RLS) + Monaco Editor + Pyodide (Python حقيقي في المتصفح) + Framer Motion + Zod.

---

## 1) Clone the project

```bash
git clone <your-repo-url> eleven
cd eleven
```

## 2) Install dependencies

```bash
npm install
```

## 3) Create a Supabase project

1. اذهب إلى [supabase.com](https://supabase.com) وأنشئ مشروعًا جديدًا.
2. من **Project Settings → API** انسخ:
   - `Project URL`
   - `anon public` key

⚠️ **لا تستخدم أبدًا** `service_role` key داخل الـ Frontend.

## 4) Create environment variables

```bash
cp .env.example .env
```

عدّل ملف `.env`:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

## 5) Run SQL migrations

من **Supabase Dashboard → SQL Editor**، نفّذ ملفات `supabase/migrations/` **بالترتيب الرقمي**:

```
0001_schema.sql        -- الجداول والعلاقات
0002_grants.sql         -- صلاحيات الوصول الأساسية للأدوار anon/authenticated
0002_rls.sql            -- Row Level Security policies
0003_functions.sql      -- دوال XP / Streak / Achievements الآمنة
0004_seed_chapters.sql  -- الـ20 فصل + الإنجازات
0005_seed_lessons_ch1.sql   -- فصل 1: مقدمة Python (دروس 1-4) + المتغيرات (دروس 5-8)
0006_seed_lessons_ch2.sql   -- فصل 1: تكملة (المتغيرات)
0007_seed_lessons_ch3.sql   -- فصل 2: أنواع البيانات (دروس 1-4)
0008_seed_problems.sql
0009_seed_lessons_ch4.sql   -- فصل 2: تكملة (الإدخال، دروس 5-8)
0010_seed_lessons_ch5.sql   -- فصل 3: تحويل الأنواع (دروس 1-4)
0011_seed_lessons_ch6.sql   -- فصل 3: تكملة (العمليات، دروس 5-8)
0012_seed_problems_batch2.sql
0013_seed_lessons_ch7.sql   -- فصل 4: الشروط if (دروس 1-4)
0014_seed_lessons_ch8.sql   -- فصل 4: تكملة (elif/else، دروس 5-8)
0015_seed_lessons_ch9.sql   -- فصل 5: الشروط المتداخلة (دروس 1-4)
0016_seed_lessons_ch10.sql  -- فصل 5: تكملة (النصوص الأساسية، دروس 5-8)
0017_seed_lessons_ch11.sql  -- فصل 6: دوال النصوص (دروس 1-4)
0018_seed_lessons_ch12.sql  -- فصل 6: تكملة (الفهرسة والتقطيع، دروس 5-8)
0019_seed_lessons_ch13.sql  -- فصل 7: القوائم (دروس 1-4)
0020_seed_lessons_ch14.sql  -- فصل 7: تكملة (دوال القوائم، دروس 5-8)
0021_seed_problems_batch3.sql
0022_seed_lessons_ch15.sql  -- فصل 8: Tuples (دروس 1-4)
0023_seed_lessons_ch16.sql  -- فصل 8: تكملة (Sets، دروس 5-8)
0024_seed_lessons_ch17.sql  -- فصل 9: القواميس (دروس 1-4)
0025_seed_lessons_ch9_part2.sql  -- فصل 9: تكملة (حلقة while، دروس 5-8)
0026_seed_lessons_ch10.sql  -- فصل 10: for/range/الحلقات المتداخلة (دروس 1-8)
0027_seed_lessons_ch11.sql  -- فصل 11: break/continue ومقدمة الدوال (دروس 1-8)
0028_seed_problems_batch4.sql
0029_seed_lessons_ch12.sql  -- فصل 12: معاملات الدوال والقيمة الراجعة (دروس 1-8)
```

يمكن ملاحظة أن كل فصل من فصول Eleven العشرين يجمع موضوعين متتاليين في 8 دروس (بدلًا من 4)، للحفاظ على خارطة تعلم مختصرة وغير مرهقة للمبتدئ رغم أن العمق التعليمي الكامل (160 درسًا) محفوظ بالكامل. نفّذ الملفات **بالترتيب الرقمي بالضبط**.

يمكنك أيضًا تنفيذها عبر Supabase CLI:

```bash
supabase link --project-ref <your-project-ref>
supabase db push
```

## 6) Seed database

خطوة 5 تشمل الـ Seed الأساسي (20 فصلًا كاملة الخارطة + دروس الفصول 1-9 كاملة = 68 درسًا + 14 مسألة + الإنجازات). لإكمال باقي الفصول (10-20)، أضف ملفات seed إضافية بنفس نمط `0005_seed_lessons_ch1.sql` — كل درس هو صف واحد في جدول `lessons` بمحتوى JSON منظم (explanation, code_examples, common_mistakes, tips, challenge)، مما يجعل إضافة دروس جديدة سهلة دون لمس الكود. كل فصل من العشرين يحتوي 8 دروس (lesson_number من 1 إلى 8).

### إنشاء أول Admin

بعد تسجيل أول مستخدم عبر التطبيق، ارفعه لصلاحية admin من SQL Editor:

```sql
update public.profiles set role = 'admin' where id = '<user-uuid-من-auth.users>';
```

## 7) Run locally

```bash
npm run dev
```

افتح `http://localhost:5173`.

## 8) Build

```bash
npm run build
```

الناتج في مجلد `dist/`.

## 9) Deploy

### Vercel / Netlify / Cloudflare Pages

- اربط الريبو مباشرة، أو ارفع مجلد `dist/` بعد `npm run build`.
- أضف متغيرات البيئة نفسها (`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`) من إعدادات المشروع في المنصة.
- Build command: `npm run build` — Output directory: `dist`.

Supabase يبقى الـ Backend/Database؛ لا حاجة لخادم منفصل.

---

## بنية المشروع

```
src/
├── components/     # UI قابلة لإعادة الاستخدام (lesson, layout, ui)
├── pages/          # صفحات التطبيق + admin/
├── layouts/        # AppLayout (Navbar + Outlet)
├── hooks/          # usePyodide (تشغيل Python حقيقي في المتصفح)
├── lib/            # عميل Supabase
├── services/       # طبقة الوصول للبيانات (content.ts)
├── types/          # TypeScript types لجداول قاعدة البيانات
├── contexts/        # AuthContext, ThemeContext
supabase/
└── migrations/     # SQL: schema, RLS, functions, seed
```

## الأمان

- لا يوجد أي Secret في الكود؛ فقط `VITE_SUPABASE_ANON_KEY` العامة.
- كل تعديل على XP/المستوى/الإنجازات يمر عبر دوال `SECURITY DEFINER` في Postgres — لا يمكن للمستخدم تزوير تقدمه من الـ Frontend.
- تنفيذ كود Python يحدث بالكامل داخل Sandbox المتصفح (WebAssembly)، لا اتصال بالخادم ولا وصول لنظام الملفات الحقيقي.
- صلاحيات Admin مبنية على عمود `role` في جدول `profiles` + دالة `is_admin()` في RLS، وليس على تحقق بريد إلكتروني ثابت في الكود.

## الترخيص

© 2026 Eleven — Abo_Saber@Eleven
