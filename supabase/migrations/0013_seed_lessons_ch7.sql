-- ============================================================
-- Eleven — Migration 0013: Chapter 7 — الشروط: if
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'مقدمة إلى if',
  'اجعل برنامجك يتخذ قرارات بناءً على شرط معين.',
  '["فهم معنى الشرط (Condition)", "كتابة أول جملة if", "فهم أهمية المسافة البادئة (Indentation)"]'::jsonb,
  $j${
    "explanation": "حتى الآن كل أسطر برامجنا تُنفَّذ دائمًا بدون استثناء. لكن غالبًا نريد أن يُنفَّذ كود معين فقط إذا تحقق شرط ما — وهذا بالضبط ما تفعله جملة if. تكتب if متبوعة بشرط (تعبير ينتج True أو False) ثم نقطتين :، والكود الذي سيُنفَّذ عند تحقق الشرط يُكتب في السطر التالي مع مسافة بادئة (Indentation) عادة 4 مسافات. إذا كان الشرط True يُنفَّذ الكود، وإذا كان False يتم تجاوزه بالكامل.",
    "code_examples": [
      {"code": "age = 20\nif age >= 18:\n    print(\"يمكنك التصويت\")\n    print(\"أنت بالغ رسميًا\")", "explanation": "الشرط age >= 18 يُقيَّم أولًا: بما أن 20 أكبر من أو يساوي 18، فالشرط True، لذا يُنفَّذ كلا السطرين داخل if. لو كان العمر أقل من 18 لَما طُبع أي شيء."}
    ],
    "common_mistakes": [
      "نسيان النقطتين : بعد الشرط، مما يسبب SyntaxError.",
      "عدم استخدام مسافة بادئة متسقة (Indentation) لسطور الكود داخل if، مما يسبب IndentationError."
    ],
    "tips": [
      "التزم بـ4 مسافات (أو Tab واحد) بثبات في كل مشاريعك للمسافة البادئة.",
      "جرّب تغيير قيمة الشرط بين True وFalse لترى بنفسك متى يُنفَّذ الكود ومتى يُتجاهل."
    ],
    "challenge": {
      "prompt": "اطلب عمر المستخدم، واطبع \"مسموح بالدخول\" فقط إذا كان عمره 18 أو أكثر.",
      "starter_code": "age = int(input(\"كم عمرك؟ \"))\nif age >= 18:\n    print(\"مسموح بالدخول\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'الشرط ومقارنته بالمنطق',
  'اربط ما تعلمته عن المقارنة والعمليات المنطقية مباشرة بجملة if.',
  '["كتابة شروط باستخدام عمليات مقارنة متعددة", "دمج and وor داخل شرط if واحد"]'::jsonb,
  $j${
    "explanation": "أي تعبير يُنتج True أو False يمكن استخدامه كشرط داخل if، بما في ذلك عمليات المقارنة (==, !=, >, <) والعمليات المنطقية (and, or, not) التي تعلمناها في الفصل السابق. هذا يمنحك قوة كبيرة لبناء شروط دقيقة تعكس منطق حقيقي معقد، مثل التحقق من أكثر من معيار في نفس الوقت.",
    "code_examples": [
      {"code": "age = 25\nhas_ticket = True\n\nif age >= 18 and has_ticket:\n    print(\"يمكنك دخول الحفل\")", "explanation": "الشرط هنا يجمع بين شرطين بـ and: العمر كافٍ ولديه تذكرة. يُنفَّذ الطباعة فقط إذا تحقق الشرطان معًا."}
    ],
    "common_mistakes": [
      "كتابة شرط طويل جدًا بدون أقواس فتصبح قراءته صعبة أو يُفهم بترتيب خاطئ.",
      "استخدام = بدلًا من == داخل الشرط، وهو خطأ شائع جدًا وقد يمر دون أن ينتبه له المبرمج المبتدئ فورًا."
    ],
    "tips": [
      "استخدم أقواسًا لتوضيح الأولوية عند دمج عدة شروط، مثل (a and b) or c.",
      "اختبر شرطك بحالات مختلفة (True/False لكل جزء) للتأكد أنه يعمل كما تتوقع تمامًا."
    ],
    "challenge": {
      "prompt": "اطلب عمر المستخدم وهل معه هوية (نعم/لا)، واطبع \"مسموح بالدخول\" فقط إذا كان عمره 18+ ومعه هوية.",
      "starter_code": "age = int(input(\"العمر: \"))\nhas_id_input = input(\"هل معك هوية؟ (نعم/لا): \")\nhas_id = has_id_input == \"نعم\"\nif age >= 18 and has_id:\n    print(\"مسموح بالدخول\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'الكتلة البرمجية (Code Block)',
  'افهم بعمق كيف تحدد المسافة البادئة أي أسطر تنتمي لأي شرط.',
  '["فهم مفهوم Code Block بوضوح", "التمييز بين كود داخل if وكود بعده", "تجنب أخطاء المسافة البادئة الشائعة"]'::jsonb,
  $j${
    "explanation": "الكتلة البرمجية (Code Block) هي مجموعة الأسطر التي تنتمي لنفس مستوى المسافة البادئة بعد if. بمجرد أن يعود سطر إلى المسافة البادئة الأصلية (بدون إزاحة)، فهذا يعني أنه خرج من كتلة if وسيُنفَّذ دائمًا بغض النظر عن الشرط. فهم هذا الفرق ضروري جدًا لتجنب أخطاء منطقية دقيقة.",
    "code_examples": [
      {"code": "score = 40\nif score >= 50:\n    print(\"ناجح\")\n    print(\"مبروك!\")\nprint(\"انتهى البرنامج\")", "explanation": "السطران الأولان (ناجح، مبروك) داخل كتلة if وسيُطبعان فقط إذا كان score >= 50 (وهو False هنا فلن يُطبعا). لكن \"انتهى البرنامج\" خارج الكتلة تمامًا (بدون إزاحة)، لذا سيُطبع دائمًا بغض النظر عن الشرط."}
    ],
    "common_mistakes": [
      "الاعتقاد أن كل الأسطر بعد if تنتمي له تلقائيًا — فقط الأسطر ذات المسافة البادئة المتساوية تنتمي للكتلة.",
      "مزج المسافات (Spaces) مع التبويب (Tabs) في نفس الملف، مما يسبب أخطاء غامضة."
    ],
    "tips": [
      "معظم محررات الأكواد (ومنها Playground في Eleven) تضيف المسافة البادئة تلقائيًا بعد النقطتين — استفد من ذلك.",
      "إذا شككت في مستوى الإزاحة، انظر بعناية لعدد المسافات في بداية كل سطر."
    ],
    "challenge": {
      "prompt": "اكتب شرطًا يطبع رسالتين إذا تحقق، ثم أضف سطرًا ثالثًا خارج الشرط يُطبع دائمًا.",
      "starter_code": "temperature = 35\nif temperature > 30:\n    print(\"الجو حار\")\n    print(\"اشرب الماء بكثرة\")\nprint(\"انتهى التقرير الجوي\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'تمارين على if',
  'طبّق كل ما تعلمته عن if في تمارين متنوعة.',
  '["بناء برنامج تحقق من صحة كلمة مرور بسيط", "دمج if مع input في سيناريو واقعي"]'::jsonb,
  $j${
    "explanation": "لنطبّق if في سيناريو واقعي: التحقق من طول كلمة مرور. الأنظمة الحقيقية غالبًا تفرض شروطًا معينة (مثل طول أدنى) قبل قبول كلمة المرور، وهذا مثال ممتاز يجمع input، المقارنة، وif معًا في برنامج مفيد فعليًا.",
    "code_examples": [
      {"code": "password = input(\"أدخل كلمة مرور: \")\nif len(password) >= 8:\n    print(\"كلمة المرور مقبولة\")", "explanation": "len() دالة جاهزة تُرجع عدد الأحرف في نص. هنا نتحقق أن طول كلمة المرور 8 أحرف على الأقل قبل قبولها."}
    ],
    "common_mistakes": [
      "نسيان len() عند محاولة معرفة طول النص، ومحاولة مقارنة النص نفسه برقم مباشرة.",
      "عدم اختبار البرنامج بكلمة مرور قصيرة جدًا للتأكد أن الشرط يرفضها فعلًا (بعدم طباعة شيء)."
    ],
    "tips": [
      "len(text) دالة ستستخدمها كثيرًا جدًا في مسائل تتعلق بالنصوص لاحقًا.",
      "فكّر دومًا: ما الشرط الدقيق الذي يجب أن يتحقق قبل تنفيذ هذا الكود؟"
    ],
    "challenge": {
      "prompt": "اطلب رقمًا من المستخدم واطبع \"رقم كبير\" فقط إذا كان أكبر من 100.",
      "starter_code": "number = int(input(\"أدخل رقمًا: \"))\nif number > 100:\n    print(\"رقم كبير\")"
    }
  }$j$::jsonb, 9, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الرمز الإلزامي بعد شرط if في Python؟', 'multiple_choice',
  '["نقطتان :", "فاصلة منقوطة ;", "قوس معقوف {", "لا شيء"]'::jsonb,
  'نقطتان :', 'يجب إنهاء سطر if بنقطتين : قبل الانتقال لكتلة الكود التي تُنفَّذ عند تحقق الشرط.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nage = 25\nhas_ticket = False\nif age >= 18 and has_ticket:\n    print("دخول")', 'predict_output',
  '["دخول", "لا شيء يُطبع", "خطأ", "True"]'::jsonb,
  'لا شيء يُطبع', 'and يتطلب تحقق الشرطين معًا، وبما أن has_ticket هي False فالشرط الكلي False ولا يُنفَّذ الكود الداخلي.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'أي الأسطر التالية تُعتبر خارج كتلة if؟\nif x > 0:\n    print("a")\nprint("b")', 'multiple_choice',
  '["print(\"b\") فقط", "print(\"a\") فقط", "كلاهما", "لا شيء منهما"]'::jsonb,
  'print(\"b\") فقط', 'print(\"b\") ليس له مسافة بادئة، لذا فهو خارج كتلة if وسيُنفَّذ دائمًا بغض النظر عن الشرط.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'الدالة len() تُستخدم لمعرفة عدد الأحرف في نص.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'len(text) تُرجع عدد الأحرف (طول) أي نص، وهي مفيدة جدًا للتحقق من شروط تتعلق بالنصوص.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 4;
