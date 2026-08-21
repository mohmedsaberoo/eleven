-- ============================================================
-- Eleven — Migration 0019: Chapter 13 — القوائم (Lists)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هي القائمة؟',
  'تعرّف على أول هيكل بيانات (Data Structure) حقيقي في Python: القائمة.',
  '["فهم مفهوم القائمة كحاوية مرتبة للقيم", "إنشاء قائمة والوصول لعناصرها بالفهرسة", "فهم أن القوائم Mutable (قابلة للتعديل)"]'::jsonb,
  $j${
    "explanation": "القائمة (List) هي حاوية واحدة تخزّن عدة قيم مرتبة معًا، بدلًا من إنشاء متغير منفصل لكل قيمة. تُنشأ القائمة بأقواس مربعة [] مع فصل القيم بفواصل، ويمكن أن تحتوي أنواع بيانات مختلفة معًا (نصوص، أرقام، حتى قوائم أخرى). تمامًا كالنصوص، تُفهرَس القوائم من 0، لكن الفرق الجوهري المهم: القوائم Mutable أي قابلة للتعديل المباشر بعد إنشائها، على عكس النصوص.",
    "code_examples": [
      {"code": "fruits = [\"apple\", \"banana\", \"cherry\"]\nprint(fruits)\nprint(fruits[0])    # apple\nprint(fruits[-1])   # cherry\nprint(len(fruits))  # 3", "explanation": "أنشأنا قائمة من 3 نصوص. fruits[0] يصل لأول عنصر تمامًا كما فعلنا مع النصوص، وfruits[-1] يصل لآخر عنصر. len() تُرجع عدد العناصر في القائمة (3) وليس عدد الحروف."}
    ],
    "common_mistakes": [
      "الخلط بين القائمة [] والدالة () عند الإنشاء — القوائم تستخدم أقواسًا مربعة حصرًا.",
      "توقّع أن القائمة تحتوي نوعًا واحدًا فقط من البيانات — Python تسمح بخلط الأنواع بحرية داخل نفس القائمة."
    ],
    "tips": [
      "القوائم هي أحد أهم هياكل البيانات في Python وستستخدمها في كل مشروع تقريبًا من الآن فصاعدًا.",
      "الفهرسة (بما فيها السالبة) وSlicing اللذان تعلمتهما مع النصوص يعملان بنفس الطريقة تمامًا مع القوائم."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بأسماء 4 مدن تحب زيارتها، ثم اطبع المدينة الأولى والأخيرة وعدد المدن الكلي.",
      "starter_code": "cities = [\"القاهرة\", \"دبي\", \"باريس\", \"طوكيو\"]\nprint(\"الأولى:\", cities[0])\nprint(\"الأخيرة:\", cities[-1])\nprint(\"العدد:\", len(cities))"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'تعديل عناصر القائمة',
  'غيّر قيمة عنصر موجود في القائمة مباشرة، على عكس النصوص.',
  '["تعديل عنصر بموقعه المباشر", "فهم الفرق العملي بين Mutable وImmutable"]'::jsonb,
  $j${
    "explanation": "بما أن القوائم Mutable، يمكنك تغيير قيمة أي عنصر فيها مباشرة عن طريق تحديد موقعه وإسناد قيمة جديدة له، بنفس طريقة تعديل متغير عادي: list[index] = new_value. هذا يختلف جوهريًا عن النصوص التي لا تسمح بهذا التعديل المباشر إطلاقًا (كما تعلمنا سابقًا) وهو أحد أهم الفروق العملية بين النوعين.",
    "code_examples": [
      {"code": "scores = [70, 85, 60]\nprint(scores)          # [70, 85, 60]\n\nscores[2] = 95\nprint(scores)          # [70, 85, 95]", "explanation": "scores[2] = 95 يستبدل العنصر الثالث (موقع 2) من 60 إلى 95 مباشرة داخل نفس القائمة، دون الحاجة لإنشاء قائمة جديدة — وهذا ما يميز القوائم عن النصوص."}
    ],
    "common_mistakes": [
      "محاولة الوصول لموقع غير موجود عند التعديل، مثل scores[10] = 5 على قائمة من 3 عناصر فقط، مما يسبب IndexError.",
      "الخلط بين تعديل عنصر موجود list[i] = value وإضافة عنصر جديد (سنتعلم append() في الدرس القادم)."
    ],
    "tips": [
      "قبل تعديل أي موقع، تأكد أنه ضمن حدود القائمة باستخدام len() إن كنت غير متأكد.",
      "هذا التعديل المباشر (In-place) هو أحد أهم أسباب استخدام القوائم بدل النصوص عند الحاجة لتخزين بيانات متغيرة."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بدرجات 3 مواد، ثم صحّح الدرجة الثانية لتصبح 100.",
      "starter_code": "grades = [80, 70, 90]\ngrades[1] = 100\nprint(grades)"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'التقطيع مع القوائم',
  'استخدم Slicing لاستخراج جزء من القائمة، تمامًا كما فعلت مع النصوص.',
  '["تطبيق list[start:end] على القوائم", "فهم أن نتيجة تقطيع القائمة هي قائمة جديدة"]'::jsonb,
  $j${
    "explanation": "التقطيع (Slicing) الذي تعلمته مع النصوص يعمل بنفس الطريقة تمامًا مع القوائم: list[start:end] يُرجع قائمة جديدة تحتوي العناصر من start حتى قبل end. هذا يجعل استخراج \"جزء\" من قائمة أكبر أمرًا سهلًا جدًا، مثل الحصول على أول 3 عناصر أو آخر عنصرين.",
    "code_examples": [
      {"code": "numbers = [10, 20, 30, 40, 50]\nprint(numbers[1:4])   # [20, 30, 40]\nprint(numbers[:2])    # [10, 20]\nprint(numbers[-2:])   # [40, 50]", "explanation": "numbers[1:4] يستخرج 3 عناصر بدءًا من الموقع 1 وحتى قبل الموقع 4. numbers[:2] يبدأ من الصفر تلقائيًا. numbers[-2:] يستخدم الفهرسة السالبة لاستخراج آخر عنصرين فقط."}
    ],
    "common_mistakes": [
      "توقّع أن التقطيع يُعدّل القائمة الأصلية — في الحقيقة يُنشئ قائمة جديدة مستقلة تمامًا.",
      "الخلط بين numbers[1] (عنصر واحد) وnumbers[1:2] (قائمة تحتوي عنصرًا واحدًا) — النوعان مختلفان."
    ],
    "tips": [
      "كل ما تعلمته عن Slicing مع النصوص (بما في ذلك step وlist[::-1] لعكس القائمة) ينطبق تمامًا هنا أيضًا.",
      "التقطيع أداة ممتازة لتقسيم قائمة كبيرة لأجزاء أصغر بسهولة، مثل تقسيم صفحات نتائج."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة من 6 أرقام، واستخرج أول 3 عناصر، وآخر 2 عناصر، وقائمة معكوسة كاملة.",
      "starter_code": "numbers = [5, 10, 15, 20, 25, 30]\nprint(numbers[:3])\nprint(numbers[-2:])\nprint(numbers[::-1])"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'قوائم متداخلة وتمارين',
  'تعرّف على القوائم المتداخلة (List of Lists) وطبّق ما تعلمته.',
  '["فهم مفهوم القائمة داخل قائمة", "الوصول لعنصر داخل قائمة متداخلة بفهرستين"]'::jsonb,
  $j${
    "explanation": "يمكن لعناصر القائمة أن تكون هي نفسها قوائم أخرى، وهذا يُسمى قائمة متداخلة (Nested List)، ويُستخدم كثيرًا لتمثيل بيانات جدولية مثل الشبكات أو الجداول (صفوف وأعمدة). للوصول لعنصر داخل قائمة متداخلة، تستخدم فهرستين متتاليين: الأول لتحديد القائمة الفرعية، والثاني لتحديد العنصر داخلها.",
    "code_examples": [
      {"code": "students = [\n    [\"أحمد\", 90],\n    [\"سارة\", 85],\n    [\"ليلى\", 95]\n]\n\nprint(students[0])       # ['أحمد', 90]\nprint(students[0][0])    # أحمد\nprint(students[1][1])    # 85", "explanation": "students هي قائمة من 3 قوائم فرعية، كل واحدة تمثل طالبًا واسمه ودرجته. students[0] يُرجع القائمة الفرعية الأولى كاملة، بينما students[0][0] يصل للعنصر الأول (الاسم) داخل تلك القائمة الفرعية تحديدًا."}
    ],
    "common_mistakes": [
      "نسيان الفهرس الثاني عند محاولة الوصول لعنصر داخل قائمة فرعية، فتحصل على القائمة الفرعية كاملة بدل العنصر المطلوب.",
      "الخلط في ترتيب الفهرسين، فتصل لعنصر خاطئ تمامًا دون أن تلاحظ الخطأ فورًا."
    ],
    "tips": [
      "القوائم المتداخلة أساس تمثيل الجداول والشبكات (مثل رقعة شطرنج أو جدول بيانات) في Python.",
      "ارسم القائمة المتداخلة على ورقة كجدول (صفوف وأعمدة) إن التبس عليك فهم الفهرسة المزدوجة."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة متداخلة تمثل 3 منتجات، كل واحد باسمه وسعره، ثم اطبع اسم المنتج الثاني وسعر المنتج الثالث فقط.",
      "starter_code": "products = [\n    [\"كتاب\", 50],\n    [\"قلم\", 5],\n    [\"حقيبة\", 120]\n]\nprint(products[1][0])\nprint(products[2][1])"
    }
  }$j$::jsonb, 9, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما القوسان المستخدمان لإنشاء قائمة في Python؟', 'multiple_choice',
  '["[]", "()", "{}", "<>"]'::jsonb,
  '[]', 'القوائم تُنشأ دائمًا باستخدام الأقواس المربعة [].', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'القوائم Mutable، أي يمكن تعديل عناصرها مباشرة بعد الإنشاء.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'على عكس النصوص، تسمح Python بتعديل عناصر القائمة مباشرة عبر list[index] = new_value.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nnums = [1,2,3,4,5]\nprint(nums[1:3])', 'predict_output',
  '["[2, 3]", "[1, 2, 3]", "[2, 3, 4]", "[1, 2]"]'::jsonb,
  '[2, 3]', 'التقطيع من الموقع 1 إلى قبل الموقع 3 يُرجع العنصرين في الموقعين 1 و2، أي [2, 3].', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في قائمة متداخلة data = [[1,2],[3,4]], ماذا يطبع print(data[1][0])؟', 'predict_output',
  '["3", "4", "1", "[3, 4]"]'::jsonb,
  '3', 'data[1] يصل للقائمة الفرعية الثانية [3, 4]، وdata[1][0] يصل لأول عنصر فيها وهو 3.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 4;
