-- ============================================================
-- Eleven — Migration 0005: Chapter 1 full lesson content
-- "مقدمة إلى Python" — 4 lessons, fully written, no placeholders.
-- ============================================================

-- Lesson 1.1 — ما هي Python؟
with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هي Python؟',
  'تعرّف على لغة Python ولماذا هي أفضل نقطة بداية لتعلّم البرمجة.',
  '["فهم ما هي لغة البرمجة", "معرفة لماذا Python مناسبة للمبتدئين", "التعرف على استخدامات Python الحقيقية"]'::jsonb,
  $j${
    "explanation": "لغة البرمجة (Programming Language) هي وسيلة نكتب بها تعليمات يفهمها الحاسوب وينفذها. بايثون (Python) هي واحدة من أشهر لغات البرمجة في العالم، صممها المبرمج Guido van Rossum عام 1991، واسمها مستوحى من برنامج كوميدي بريطاني اسمه Monty Python وليس من الثعبان! تشتهر Python بأن كودها يشبه الجملة الإنجليزية العادية، لذلك يسهل على المبتدئ فهمها وكتابتها من أول يوم. تُستخدم Python اليوم في: تطوير المواقع، تحليل البيانات (Data Science)، الذكاء الاصطناعي (AI)، الألعاب، الأتمتة (Automation)، وحتى في تطبيقات مثل Instagram و Spotify.",
    "code_examples": [
      {"code": "print(\"Hello, Eleven!\")", "explanation": "هذا أبسط برنامج ممكن في Python. الأمر print() يطلب من الحاسوب أن يطبع (يعرض) النص الذي بين القوسين على الشاشة."}
    ],
    "common_mistakes": [
      "الاعتقاد أنك تحتاج خبرة رياضية قوية قبل البدء — Python مصممة لتبدأ من الصفر تمامًا.",
      "الخلط بين Python (اللغة) وPython Interpreter (البرنامج الذي يشغّل الكود)."
    ],
    "tips": [
      "لا تحاول حفظ كل شيء، البرمجة مهارة تُبنى بالممارسة أكثر من الحفظ.",
      "اكتب كل مثال بنفسك في الـ Playground بدل الاكتفاء بالقراءة فقط."
    ],
    "challenge": {
      "prompt": "افتح الـ Playground واطبع جملة ترحيبية باسمك، مثل: \"أنا اسمي محمد وأتعلم Python\"",
      "starter_code": "print(\"اكتب جملتك هنا\")"
    }
  }$j$::jsonb,
  8, 10
from ch;

-- Lesson 1.2 — تثبيت Python
with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'تثبيت Python',
  'خطوات تثبيت Python على جهازك، وكيف تتحقق أنها اشتغلت بنجاح.',
  '["معرفة كيفية تحميل Python من الموقع الرسمي", "التحقق من التثبيت عبر الطرفية (Terminal)", "فهم دور Code Editor مثل VS Code"]'::jsonb,
  $j${
    "explanation": "للبرمجة بـ Python على جهازك (خارج منصة Eleven) تحتاج لتثبيت أمرين: 1) Python نفسها من الموقع الرسمي python.org، و2) محرر أكواد (Code Editor) مثل Visual Studio Code لكتابة الكود بشكل مريح. بعد التثبيت، تتحقق من نجاح العملية بفتح الطرفية (Terminal أو Command Prompt) وكتابة الأمر: python --version وإذا ظهر رقم إصدار مثل Python 3.12.0 فهذا يعني أن كل شيء يعمل بنجاح. ملاحظة مهمة: منصة Eleven توفر لك Playground يعمل مباشرة من المتصفح، فلست مضطرًا للتثبيت لتبدأ التعلم — لكن من المفيد جدًا أن تعرف كيف تجهز بيئة العمل على جهازك الشخصي لاحقًا.",
    "code_examples": [
      {"code": "python --version", "explanation": "أمر يُكتب في الطرفية (Terminal) وليس في ملف Python؛ يعرض رقم إصدار Python المثبت على جهازك."}
    ],
    "common_mistakes": [
      "نسيان تفعيل خيار Add Python to PATH أثناء التثبيت على ويندوز، مما يمنع التعرف على الأمر python في الطرفية.",
      "الخلط بين أمر python و python3 — على بعض الأنظمة (مثل macOS/Linux) يجب استخدام python3."
    ],
    "tips": [
      "تدرّب أولًا داخل Playground الخاص بـ Eleven قبل تثبيت أي شيء على جهازك.",
      "عند التثبيت لاحقًا، اختر دائمًا آخر إصدار مستقر (Stable) من python.org."
    ],
    "challenge": {
      "prompt": "لا حاجة لتثبيت شيء الآن. بدلًا من ذلك، جرّب في الـ Playground طباعة اسم آخر إصدار Python سمعت عنه كنص.",
      "starter_code": "print(\"Python 3.12\")"
    }
  }$j$::jsonb,
  6, 10
from ch;

-- Lesson 1.3 — أول برنامج Python
with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'أول برنامج Python',
  'اكتب وشغّل أول برنامج حقيقي وافهم كيف يُنفَّذ الكود سطرًا بسطر.',
  '["كتابة وتشغيل برنامج Python بسيط", "فهم مفهوم التنفيذ التسلسلي (سطر بسطر)", "التعرف على مفهوم الأخطاء البرمجية (Syntax Error)"]'::jsonb,
  $j${
    "explanation": "أي برنامج Python هو مجموعة أسطر يقرأها الحاسوب من الأعلى إلى الأسفل، وينفذ كل سطر بالترتيب (هذا يسمى Sequential Execution). لنكتب أول برنامج حقيقي لك يحتوي على أكثر من سطر. لاحظ أن Python حسّاسة جدًا للتنسيق: الأقواس، علامات التنصيص، وحتى المسافات (Indentation) لها معنى مهم سنتعلمه لاحقًا. إذا أخطأت في كتابة رمز، سيظهر لك خطأ اسمه SyntaxError يخبرك بمكان المشكلة تقريبًا — وهذا أمر طبيعي جدًا ويحدث حتى مع المبرمجين المحترفين!",
    "code_examples": [
      {"code": "print(\"مرحبًا بك في Eleven\")\nprint(\"هذا أول برنامج لك\")\nprint(\"لنبدأ رحلة تعلم Python!\")", "explanation": "ثلاثة أسطر تُنفَّذ بالترتيب: يُطبع السطر الأول، ثم الثاني، ثم الثالث — كل print() على سطر مستقل ينتج سطرًا جديدًا في الناتج."}
    ],
    "common_mistakes": [
      "نسيان إغلاق علامة التنصيص، مثل كتابة print(\"مرحبًا) بدون إغلاق القوس.",
      "استخدام قوس بداية مختلف عن قوس النهاية، مثل استخدام ' في البداية و\" في النهاية."
    ],
    "tips": [
      "إذا ظهر لك خطأ، اقرأ الرسالة بهدوء — غالبًا تخبرك برقم السطر بالضبط.",
      "جرّب كسر الكود عمدًا (مثل حذف قوس) لترى شكل رسالة الخطأ وتتعرف عليها مستقبلًا."
    ],
    "challenge": {
      "prompt": "اكتب برنامجًا من 3 أسطر print() يعرّف بك: اسمك، بلدك، ولماذا تتعلم البرمجة.",
      "starter_code": "print(\"الاسم: ...\")\nprint(\"البلد: ...\")\nprint(\"السبب: ...\")"
    }
  }$j$::jsonb,
  8, 10
from ch;

-- Lesson 1.4 — print()
with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'دالة print()',
  'تعمّق أكثر في دالة print() وخياراتها المفيدة.',
  '["استخدام print() لطباعة أكثر من قيمة", "فهم الفاصل sep والنهاية end", "طباعة أسطر فارغة ورموز خاصة"]'::jsonb,
  $j${
    "explanation": "دالة (Function) هي مجموعة تعليمات جاهزة لها اسم يمكنك استدعاؤها بكتابة اسمها متبوعًا بقوسين (). print هي أول دالة جاهزة (Built-in Function) نتعلمها في Python، ومهمتها عرض أي قيمة على الشاشة. يمكن لـ print أن تستقبل أكثر من قيمة في نفس الوقت مفصولة بفاصلة، وستقوم تلقائيًا بوضع مسافة بينها. كما تحتوي على خيارات متقدمة مثل sep (الفاصل بين القيم) و end (ما يُضاف بعد الطباعة، وقيمته الافتراضية سطر جديد).",
    "code_examples": [
      {"code": "print(\"العمر:\", 18)\nprint(\"a\", \"b\", \"c\", sep=\"-\")\nprint(\"بدون سطر جديد\", end=\" \")\nprint(\"استمرار على نفس السطر\")", "explanation": "السطر الأول يطبع نصًا ورقمًا معًا مفصولين بمسافة تلقائية. السطر الثاني يستخدم sep=\"-\" فيطبع a-b-c. السطر الثالث يستخدم end=\" \" فلا ينتقل لسطر جديد، فيكمل السطر الرابع بجانبه مباشرة."}
    ],
    "common_mistakes": [
      "الاعتقاد أن print() تعيد قيمة يمكن استخدامها لاحقًا — في الحقيقة هي فقط تعرض على الشاشة.",
      "نسيان الفاصلة بين القيم المتعددة داخل print()."
    ],
    "tips": [
      "استخدم print() كثيرًا أثناء التعلم لمراقبة قيم متغيراتك — هذه أهم أداة تصحيح أخطاء للمبتدئ.",
      "جرّب دائمًا sep و end بنفسك لترى الفرق مباشرة."
    ],
    "challenge": {
      "prompt": "استخدم print() لطباعة الأرقام من 1 إلى 5 في نفس السطر مفصولة بفاصلة ومسافة، باستخدام sep.",
      "starter_code": "print(1, 2, 3, 4, 5, sep=\", \")"
    }
  }$j$::jsonb,
  7, 10
from ch;

-- ---------- Quizzes for Chapter 1 ----------
insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'من صمم لغة Python؟', 'multiple_choice',
  '["Guido van Rossum", "Bill Gates", "Mark Zuckerberg", "Elon Musk"]'::jsonb,
  'Guido van Rossum', 'صمم Guido van Rossum لغة Python ونشرها لأول مرة عام 1991.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'اسم Python مستوحى من الثعبان.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'الاسم مستوحى من برنامج كوميدي بريطاني اسمه Monty Python، وليس من الحيوان.', 2
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الأمر الصحيح للتحقق من إصدار Python المثبت في الطرفية؟', 'multiple_choice',
  '["python --version", "python install", "python check", "run python"]'::jsonb,
  'python --version', 'الأمر python --version يعرض رقم الإصدار المثبت على الجهاز.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع هذا الكود؟\nprint("A")\nprint("B")', 'predict_output',
  '["A B على نفس السطر", "A ثم B على سطرين منفصلين", "B ثم A", "خطأ برمجي"]'::jsonb,
  'A ثم B على سطرين منفصلين', 'كل استدعاء لـ print() ينهي سطره الحالي بنهاية سطر جديدة افتراضيًا، لذلك A وB يظهران في سطرين مختلفين.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا يطبع: print("x", "y", sep="-")', 'predict_output',
  '["x-y", "x y", "x,y", "xy"]'::jsonb,
  'x-y', 'المعامل sep يحدد الفاصل بين القيم المطبوعة، وهنا هو الشرطة -، فتكون النتيجة x-y.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 4;
