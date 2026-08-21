-- ============================================================
-- Eleven — Migration 0015: Chapter 9 — الشروط المتداخلة
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هو الشرط المتداخل؟',
  'ضع شرط if داخل شرط if آخر للتعبير عن منطق أكثر تفصيلًا.',
  '["فهم مفهوم Nested Conditions", "كتابة أول شرط متداخل بسيط"]'::jsonb,
  $j${
    "explanation": "الشرط المتداخل (Nested Condition) يعني وضع جملة if كاملة داخل كتلة if أخرى. هذا مفيد عندما يعتمد فحصك الثاني على تحقق الشرط الأول أولًا — بمعنى: \"إذا تحقق هذا، تحقق أيضًا من ذاك\". كل مستوى تداخل يحتاج مستوى إضافيًا من المسافة البادئة (Indentation) ليعكس أنه \"داخل\" الشرط الذي يسبقه.",
    "code_examples": [
      {"code": "age = 20\nhas_license = True\n\nif age >= 18:\n    if has_license:\n        print(\"يمكنك القيادة\")\n    else:\n        print(\"تحتاج رخصة قيادة أولًا\")\nelse:\n    print(\"عمرك أقل من الحد المسموح للقيادة\")", "explanation": "الشرط الخارجي يتحقق من العمر أولًا. فقط إذا كان العمر كافيًا (18+)، يدخل البرنامج للشرط الداخلي ليفحص وجود رخصة القيادة. لاحظ الإزاحة الإضافية لكل مستوى تداخل."}
    ],
    "common_mistakes": [
      "الخلط في مستويات الإزاحة عند التداخل، مما يجعل شرطًا داخليًا يبدو وكأنه خارج الشرط الذي يفترض أن يكون بداخله.",
      "استخدام تداخل معقد جدًا (أكثر من 3 مستويات) حين يمكن تبسيطه بدمج الشروط بـ and بدلًا من ذلك."
    ],
    "tips": [
      "اسأل نفسك دائمًا: هل يمكنني تبسيط هذا الشرط المتداخل بدمجه في شرط واحد باستخدام and؟ أحيانًا يكون ذلك أوضح.",
      "راقب الإزاحة بعناية شديدة عند كتابة أكثر من مستوى تداخل — هذا أكثر مصدر أخطاء شيوعًا هنا."
    ],
    "challenge": {
      "prompt": "اطلب عمر المستخدم، وإذا كان 18 فأكثر اسأله إن كان لديه بطاقة طالب لتحديد الخصم المناسب.",
      "starter_code": "age = int(input(\"العمر: \"))\nif age >= 18:\n    is_student = input(\"هل أنت طالب؟ (نعم/لا): \") == \"نعم\"\n    if is_student:\n        print(\"خصم 20%\")\n    else:\n        print(\"السعر كامل\")\nelse:\n    print(\"خصم الأطفال\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'التداخل مقابل and',
  'تعلم متى تستخدم شروطًا متداخلة ومتى تدمجها في شرط واحد بـ and.',
  '["فهم أن a and b غالبًا تعادل شرطًا متداخلًا مبسّطًا", "اختيار الأسلوب الأنسب حسب الحالة"]'::jsonb,
  $j${
    "explanation": "في كثير من الحالات، يمكن استبدال شرط متداخل بسيط (if a: if b:) بشرط واحد مدمج (if a and b:) وكلاهما ينتج نفس السلوك تمامًا عندما لا نحتاج لتنفيذ كود مختلف بين الشرطين. لكن التداخل يصبح ضروريًا فعلًا عندما نحتاج لتنفيذ كود إضافي بين الشرط الخارجي والداخلي، أو عندما يكون لكل مستوى else مختلف خاص به.",
    "code_examples": [
      {"code": "temp = 30\nis_sunny = True\n\n# باستخدام and (أبسط عندما لا نحتاج else منفصلة لكل مستوى)\nif temp > 25 and is_sunny:\n    print(\"يوم رائع للسباحة!\")", "explanation": "بما أننا لا نحتاج تصرفًا مختلفًا عند فشل كل شرط على حدة، فإن دمجهما بـ and في سطر واحد أبسط وأوضح من التداخل هنا."}
    ],
    "common_mistakes": [
      "استخدام التداخل دائمًا حتى في الحالات البسيطة التي يكفيها and، مما يجعل الكود أطول وأصعب للقراءة دون داعٍ.",
      "محاولة استخدام and في حالة تحتاج فعليًا لـ else منفصلة لكل مستوى، مما يفقد جزءًا من المنطق المطلوب."
    ],
    "tips": [
      "القاعدة العامة: إذا كنت ستكتب else مختلفة لكل مستوى، استخدم التداخل. إذا كانت النتيجة النهائية فقط \"نعم أو لا\"، استخدم and.",
      "لا يوجد إجابة صحيحة واحدة دائمًا؛ اختر ما يجعل الكود أوضح للقراءة في سياقك."
    ],
    "challenge": {
      "prompt": "أعد كتابة الشرط المتداخل (فحص العمر ثم فحص الرخصة) باستخدام and في سطر واحد بدل التداخل.",
      "starter_code": "age = 20\nhas_license = True\nif age >= 18 and has_license:\n    print(\"يمكنك القيادة\")\nelse:\n    print(\"لا يمكنك القيادة الآن\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'تداخل بعدة مستويات',
  'تعامل بثقة مع شروط متداخلة تصل لثلاثة مستويات أو أكثر.',
  '["التعامل مع تداخل من 3 مستويات", "تتبع منطق معقد بخطوات واضحة"]'::jsonb,
  $j${
    "explanation": "في بعض السيناريوهات الواقعية، تحتاج لأكثر من مستويين من التداخل، مثل نظام تسجيل دخول يفحص أولًا هل المستخدم مسجّل، ثم هل كلمة المرور صحيحة، ثم هل الحساب مُفعّل. كل مستوى إضافي يزيد إزاحة واحدة. المفتاح هنا هو تقسيم المشكلة لخطوات منطقية واضحة، خطوة تلو الأخرى.",
    "code_examples": [
      {"code": "is_registered = True\npassword_correct = True\nis_active = False\n\nif is_registered:\n    if password_correct:\n        if is_active:\n            print(\"تم تسجيل الدخول بنجاح\")\n        else:\n            print(\"الحساب غير مُفعّل\")\n    else:\n        print(\"كلمة المرور خاطئة\")\nelse:\n    print(\"هذا الحساب غير مسجّل\")", "explanation": "ثلاثة مستويات من التداخل تفحص كل خطوة بترتيب منطقي: التسجيل أولًا، ثم كلمة المرور، ثم حالة التفعيل. كل مستوى له رسالة خطأ خاصة به توضح بالضبط أين فشلت العملية."}
    ],
    "common_mistakes": [
      "فقدان تتبع مستوى الإزاحة الصحيح مع زيادة عدد المستويات، مما يسبب أخطاء منطقية يصعب اكتشافها.",
      "بناء تداخل عميق جدًا (5+ مستويات) دون داعٍ، وهو ما يعتبره المبرمجون المحترفون \"رائحة كود سيئة\" يفضَّل إعادة تنظيمها."
    ],
    "tips": [
      "إذا وجدت نفسك تحتاج أكثر من 3 مستويات تداخل، فكّر في تقسيم الكود لدوال منفصلة (سنتعلم الدوال قريبًا) لتبسيطه.",
      "اختبر كل مستوى على حدة بتغيير قيمة واحدة فقط في كل مرة لتتأكد من سلوك كل فرع بدقة."
    ],
    "challenge": {
      "prompt": "ابنِ نظام تحقق من الدخول لمكتبة: هل عضو؟ ثم هل اشتراكه فعال؟ ثم هل لديه كتب متأخرة؟",
      "starter_code": "is_member = True\nsubscription_active = True\nhas_overdue_books = False\n\nif is_member:\n    if subscription_active:\n        if not has_overdue_books:\n            print(\"مرحبًا بك، يمكنك استعارة كتاب\")\n        else:\n            print(\"لديك كتب متأخرة يجب إرجاعها أولًا\")\n    else:\n        print(\"اشتراكك منتهٍ، يرجى التجديد\")\nelse:\n    print(\"يجب التسجيل كعضو أولًا\")"
    }
  }$j$::jsonb, 10, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'مشروع مصغّر: نظام تسعير تذاكر',
  'ابنِ نظام تسعير حقيقي يجمع كل ما تعلمته عن الشروط.',
  '["دمج if/elif/else مع التداخل في مشروع واحد", "التعامل مع منطق تسعير متعدد المعايير"]'::jsonb,
  $j${
    "explanation": "لنبنِ نظام تسعير تذاكر سينما يعتمد على العمر ويوم الأسبوع معًا: الأطفال (أقل من 12) يدفعون سعرًا ثابتًا مخفضًا، كبار السن (60+) يحصلون على خصم، وبقية الأعمار يدفعون السعر الكامل إلا في أيام الثلاثاء حيث يوجد خصم عام على الجميع. هذا مثال واقعي يجمع مقارنات، عمليات منطقية، وتداخلًا في منطق تسعير حقيقي.",
    "code_examples": [
      {"code": "age = int(input(\"العمر: \"))\nis_tuesday = input(\"هل اليوم ثلاثاء؟ (نعم/لا): \") == \"نعم\"\n\nif age < 12:\n    price = 20\nelif age >= 60:\n    price = 25\nelse:\n    price = 40\n\nif is_tuesday:\n    price = price - 10\n\nprint(\"السعر النهائي:\", price)", "explanation": "نحدد أولًا السعر الأساسي حسب فئة العمر باستخدام if/elif/else، ثم نطبّق خصم الثلاثاء بشكل منفصل ومستقل على أي سعر تم تحديده. هذا يوضح كيف يمكن فصل منطق التسعير الأساسي عن الخصومات الإضافية لتسهيل الفهم."}
    ],
    "common_mistakes": [
      "محاولة دمج كل الشروط (العمر ويوم الأسبوع) في سلسلة elif واحدة معقدة بدلًا من فصلها لخطوتين منطقيتين أوضح.",
      "نسيان تطبيق خصم الثلاثاء على كل الفئات العمرية بالتساوي إذا كان الخصم عامًا فعلًا."
    ],
    "tips": [
      "تقسيم منطق معقد لخطوات منفصلة ومتتالية (كما فعلنا هنا) غالبًا أوضح من محاولة حشره في شرط واحد ضخم.",
      "هذا النمط -حساب سعر أساسي ثم تطبيق تعديلات عليه- شائع جدًا في تطبيقات التجارة الإلكترونية الحقيقية."
    ],
    "challenge": {
      "prompt": "طوّر نظام التسعير ليضيف خصمًا إضافيًا 5% إذا كان العميل طالبًا (بغض النظر عن العمر أو اليوم).",
      "starter_code": "age = int(input(\"العمر: \"))\nis_student = input(\"هل أنت طالب؟ (نعم/لا): \") == \"نعم\"\n\nif age < 12:\n    price = 20\nelif age >= 60:\n    price = 25\nelse:\n    price = 40\n\nif is_student:\n    price = price * 0.95\n\nprint(\"السعر النهائي:\", price)"
    }
  }$j$::jsonb, 11, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا نسمي وضع شرط if داخل شرط if آخر؟', 'multiple_choice',
  '["Nested Condition (شرط متداخل)", "Loop", "Function", "Exception"]'::jsonb,
  'Nested Condition (شرط متداخل)', 'وضع شرط داخل شرط آخر يُسمى تداخلًا (Nesting)، ويُستخدم للتعبير عن منطق أكثر تفصيلًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'متى يُفضَّل استخدام and بدلًا من التداخل؟', 'multiple_choice',
  '["عندما لا نحتاج else مختلفة لكل مستوى", "دائمًا في كل الحالات", "أبدًا لا نستخدم and", "فقط مع الأرقام"]'::jsonb,
  'عندما لا نحتاج else مختلفة لكل مستوى', 'إذا كانت النتيجة النهائية فقط تحقق كل الشروط معًا بدون تصرف مختلف بينها، فـ and أبسط وأوضح.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'كل مستوى تداخل إضافي يحتاج مستوى إضافيًا من المسافة البادئة.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'المسافة البادئة هي ما يحدد لـ Python أي كود ينتمي لأي مستوى تداخل بالضبط.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'إذا وجدت نفسك تحتاج أكثر من 3-4 مستويات تداخل، فأفضل حل غالبًا هو:', 'multiple_choice',
  '["تقسيم الكود لدوال منفصلة", "إضافة المزيد من التداخل دائمًا", "حذف كل الشروط", "استخدام حلقات بدلًا منها"]'::jsonb,
  'تقسيم الكود لدوال منفصلة', 'التداخل العميق جدًا يصعّب القراءة، وتقسيم المنطق لدوال (سنتعلمها لاحقًا) يجعل الكود أوضح وأسهل صيانة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 4;
