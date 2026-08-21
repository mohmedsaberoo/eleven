-- ============================================================
-- Eleven — Migration 0006: Chapter 2 full lesson content — المتغيرات
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'ما هو المتغير؟',
  'افهم مفهوم المتغير (Variable) كصندوق تخزّن فيه قيمة لاستخدامها لاحقًا.',
  '["فهم مفهوم المتغير", "إنشاء أول متغير", "طباعة قيمة متغير"]'::jsonb,
  $j${
    "explanation": "المتغير (Variable) هو مكان في ذاكرة الحاسوب نعطيه اسمًا لنخزّن فيه قيمة، حتى نستطيع استخدامها أو تغييرها لاحقًا دون إعادة كتابتها من جديد. تخيّل المتغير كصندوق عليه ملصق (اسم المتغير)، وبداخله شيء (القيمة). في Python لا تحتاج لتحديد نوع الصندوق مسبقًا؛ فقط تكتب الاسم، علامة =، ثم القيمة.",
    "code_examples": [
      {"code": "student_name = \"سارة\"\nprint(student_name)", "explanation": "أنشأنا متغيرًا اسمه student_name وخزّنّا فيه النص \"سارة\"، ثم طبعنا قيمته. علامة = هنا تعني \"خزّن\" وليس \"يساوي\" رياضيًا."}
    ],
    "common_mistakes": [
      "الاعتقاد أن = في البرمجة تعني المساواة الرياضية — هي فعليًا عملية إسناد (تخزين) قيمة في متغير.",
      "استخدام المتغير قبل تعريفه، مما ينتج خطأ NameError."
    ],
    "tips": [
      "اختر أسماء متغيرات تصف محتواها بوضوح، مثل age بدل a.",
      "جرّب تغيير قيمة نفس المتغير أكثر من مرة وطباعتها في كل مرة لترى كيف تتحدث القيمة."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرًا باسمك، وآخر بعمرك، ثم اطبعهما.",
      "starter_code": "my_name = \"...\"\nmy_age = 0\nprint(my_name)\nprint(my_age)"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'تسمية المتغيرات',
  'تعرّف على قواعد وأفضل ممارسات تسمية المتغيرات في Python.',
  '["معرفة القواعد الإلزامية لتسمية المتغيرات", "تعلم أسلوب snake_case", "تجنب الكلمات المحجوزة"]'::jsonb,
  $j${
    "explanation": "لأسماء المتغيرات في Python قواعد إلزامية: يجب أن تبدأ بحرف أو شرطة سفلية _ (وليس رقمًا)، ولا يمكن أن تحتوي على مسافات أو رموز خاصة مثل - أو @، وهي حسّاسة لحالة الأحرف (age يختلف عن Age). كما توجد كلمات محجوزة (Reserved Words) مثل if وfor وclass لا يمكن استخدامها كأسماء متغيرات. الأسلوب المتعارف عليه في مجتمع Python لتسمية المتغيرات هو snake_case: أحرف صغيرة مع شرطة سفلية بين الكلمات، مثل student_age.",
    "code_examples": [
      {"code": "student_age = 20\n_temp = 5\nprint(student_age, _temp)", "explanation": "كلا الاسمين صحيحان: student_age يبدأ بحرف، و_temp يبدأ بشرطة سفلية. أسماء مثل 2age أو student-age غير مسموحة."}
    ],
    "common_mistakes": [
      "البدء باسم متغير برقم مثل 1name، وهذا يسبب SyntaxError.",
      "استخدام مسافات داخل اسم المتغير مثل student name بدل student_name."
    ],
    "tips": [
      "التزم بـ snake_case في كل مشاريعك لتكون أسماء متغيراتك متسقة ومقروءة.",
      "تجنّب الأسماء القصيرة جدًا مثل x أو y إلا في حالات بسيطة جدًا مثل عدّادات الحلقات."
    ],
    "challenge": {
      "prompt": "أنشئ 3 متغيرات بأسماء صحيحة تصف: اسم كتاب، سعره، وعدد صفحاته.",
      "starter_code": "book_title = \"...\"\nbook_price = 0\npage_count = 0"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'إسناد القيم (Assignment)',
  'تعلم كيف تُسند قيمة لأكثر من متغير، وكيف تُحدّث قيمة متغير موجود.',
  '["إسناد قيم متعددة في سطر واحد", "تحديث قيمة متغير باستخدام قيمته السابقة", "استخدام عمليات الإسناد المختصرة مثل +="]'::jsonb,
  $j${
    "explanation": "يمكنك في Python إسناد قيم لعدة متغيرات في سطر واحد، وهذا يوفر الوقت ويجعل الكود أنظف. كما يمكنك تحديث قيمة متغير بالاعتماد على قيمته الحالية، مثل زيادة عدّاد بمقدار واحد. توجد عمليات إسناد مختصرة مثل += التي تجمع القيمة الجديدة مع القيمة الحالية وتخزن الناتج مباشرة.",
    "code_examples": [
      {"code": "x, y, z = 1, 2, 3\nprint(x, y, z)\n\nscore = 10\nscore += 5\nprint(score)", "explanation": "السطر الأول يُسند 1 لـ x و2 لـ y و3 لـ z في خطوة واحدة. ثم ننشئ score بقيمة 10، ونستخدم += لزيادتها بـ5 فتصبح 15."}
    ],
    "common_mistakes": [
      "نسيان أن عدد القيم على يمين = يجب أن يطابق عدد المتغيرات على اليسار عند الإسناد المتعدد.",
      "الخلط بين = (إسناد) و== (مقارنة) الذي سنتعلمه لاحقًا في الشروط."
    ],
    "tips": [
      "استخدم += و-= و*= لتقصير كودك عند تحديث المتغيرات.",
      "الإسناد المتعدد مفيد جدًا لتبديل قيمتين، مثل: a, b = b, a"
    ],
    "challenge": {
      "prompt": "أنشئ متغير points بقيمة 0، ثم زده بـ 20 باستخدام +=، ثم اطبع القيمة النهائية.",
      "starter_code": "points = 0\npoints += 20\nprint(points)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 1)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'تمرين عملي على المتغيرات',
  'وحّد كل ما تعلمته عن المتغيرات في تمرين متكامل.',
  '["تطبيق مفاهيم المتغيرات في مثال واقعي", "بناء برنامج بسيط لبطاقة تعريف شخصية"]'::jsonb,
  $j${
    "explanation": "حان وقت التطبيق! سنبني معًا برنامج \"بطاقة تعريف\" بسيط يستخدم عدة متغيرات لتخزين معلومات شخص، ثم يطبعها بشكل منسّق باستخدام print(). هذا النوع من التمارين يحاكي كيف تُستخدم المتغيرات فعليًا في برامج حقيقية أكبر.",
    "code_examples": [
      {"code": "full_name = \"ليلى أحمد\"\ncity = \"القاهرة\"\nfavorite_language = \"Python\"\n\nprint(\"الاسم:\", full_name)\nprint(\"المدينة:\", city)\nprint(\"اللغة المفضلة:\", favorite_language)", "explanation": "ثلاثة متغيرات نصية تُخزّن معلومات شخص، ثم نطبعها كل واحدة في سطر منفصل بتسمية واضحة، تمامًا كبطاقة تعريف حقيقية."}
    ],
    "common_mistakes": [
      "خلط ترتيب الطباعة بحيث لا تُفهم النتيجة بوضوح.",
      "نسيان علامات التنصيص حول القيم النصية."
    ],
    "tips": [
      "فكّر دائمًا: ما البيانات التي أحتاج تخزينها؟ ثم أنشئ متغيرًا مناسبًا لكل بيانة.",
      "هذا النمط (تخزين ثم طباعة منسّقة) ستستخدمه في كل مشروع تقريبًا."
    ],
    "challenge": {
      "prompt": "أنشئ بطاقة تعريف لنفسك بـ4 متغيرات على الأقل (الاسم، العمر، البلد، الهواية) واطبعها بشكل منظم.",
      "starter_code": "name = \"...\"\nage = 0\ncountry = \"...\"\nhobby = \"...\"\nprint(\"الاسم:\", name)"
    }
  }$j$::jsonb, 9, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا يمثل المتغير في البرمجة؟', 'multiple_choice',
  '["مكان لتخزين قيمة باسم معين", "دالة جاهزة", "نوع من الأخطاء", "أمر لطباعة النص"]'::jsonb,
  'مكان لتخزين قيمة باسم معين', 'المتغير هو مكان في الذاكرة نعطيه اسمًا لتخزين قيمة نستخدمها لاحقًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي اسم متغير التالي صحيح في Python؟', 'multiple_choice',
  '["2name", "student_age", "student age", "student-age"]'::jsonb,
  'student_age', 'أسماء المتغيرات لا يمكن أن تبدأ برقم أو تحتوي على مسافات أو شرطات؛ student_age يتبع صيغة snake_case الصحيحة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا تطبع؟\nscore = 10\nscore += 5\nprint(score)', 'predict_output',
  '["10", "5", "15", "خطأ"]'::jsonb,
  '15', 'العملية += تضيف 5 إلى القيمة الحالية 10 فتصبح 15.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'يمكن إسناد أكثر من متغير في سطر واحد في Python.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'مثل: x, y, z = 1, 2, 3 وهي ميزة توفر الوقت وتُستخدم كثيرًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 1 and l.lesson_number = 8;
