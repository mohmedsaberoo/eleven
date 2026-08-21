-- ============================================================
-- Eleven — Migration 0009: Chapter 4 — الإدخال (Input)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'دالة input()',
  'اجعل برنامجك يطلب بيانات من المستخدم ويستقبلها.',
  '["فهم كيف يعمل input()", "تخزين القيمة المُدخلة في متغير", "معرفة أن input() تُرجع دائمًا نصًا"]'::jsonb,
  $j${
    "explanation": "حتى الآن كل برامجنا تعرض بيانات ثابتة كتبناها نحن. لكن أي برنامج حقيقي يحتاج للتفاعل مع المستخدم، وهذا ما توفره دالة input(). عند استدعائها، يتوقف البرنامج وينتظر المستخدم ليكتب شيئًا ويضغط Enter، ثم تُعيد الدالة ما كتبه كنص (str) نخزنه في متغير. يمكنك أيضًا تمرير رسالة داخل الأقواس تظهر للمستخدم كتوجيه قبل الكتابة.",
    "code_examples": [
      {"code": "city = input(\"في أي مدينة تسكن؟ \")\nprint(\"أهلًا بك من\", city)", "explanation": "input() تعرض الرسالة \"في أي مدينة تسكن؟\"، تنتظر إجابة المستخدم، ثم تخزنها في city لتُستخدم لاحقًا في الطباعة."}
    ],
    "common_mistakes": [
      "توقّع أن input() تُرجع رقمًا مباشرة — هي دائمًا تُرجع نصًا (str) حتى لو كتب المستخدم أرقامًا.",
      "نسيان تخزين نتيجة input() في متغير، فتضيع القيمة فور إدخالها."
    ],
    "tips": [
      "اجعل رسالة input() واضحة ومحددة حتى يعرف المستخدم بالضبط ماذا يُدخل.",
      "في منصة Eleven، القيم التي ستدخلها عبر input() في الـ Playground تُكتب في صندوق القيم المخصص لها قبل الضغط على Run."
    ],
    "challenge": {
      "prompt": "اطلب من المستخدم اسم فيلمه المفضل باستخدام input()، ثم اطبع جملة تقول إنه اختيار رائع.",
      "starter_code": "movie = input(\"ما هو فيلمك المفضل؟ \")\nprint(movie, \"اختيار رائع!\")"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'تحويل قيمة الإدخال',
  'حوّل القيمة النصية القادمة من input() إلى رقم لاستخدامها في العمليات الحسابية.',
  '["فهم لماذا نحتاج تحويل مخرجات input()", "استخدام int() وfloat() على القيم المُدخلة"]'::jsonb,
  $j${
    "explanation": "بما أن input() تُعيد نصًا دائمًا، فإذا أردت استخدام القيمة في عملية حسابية (مثل الجمع)، يجب تحويلها أولًا باستخدام int() إن كانت عددًا صحيحًا، أو float() إن كانت تحتوي فاصلة عشرية. إن حاولت الجمع مباشرة بين نص ورقم، أو بين نصين يُفترض أنهما أرقام دون تحويل، ستحصل على نتيجة غير متوقعة أو خطأ.",
    "code_examples": [
      {"code": "age_text = input(\"كم عمرك؟ \")\nage = int(age_text)\nnext_year = age + 1\nprint(\"العام القادم سيكون عمرك\", next_year)", "explanation": "نقرأ العمر كنص أولًا، ثم نحوله لعدد صحيح باستخدام int() قبل أن نستطيع جمع 1 عليه بأمان."}
    ],
    "common_mistakes": [
      "محاولة تحويل نص يحتوي حروفًا (مثل \"عشرين\") إلى int()، مما يسبب خطأ ValueError.",
      "استخدام int() على قيمة تحتوي فاصلة عشرية مثل \"5.5\" مباشرة — يجب استخدام float() هنا بدلًا منه."
    ],
    "tips": [
      "يمكنك دمج القراءة والتحويل في سطر واحد: age = int(input(\"كم عمرك؟ \"))",
      "إذا لم تكن متأكدًا من نوع الرقم، float() أكثر مرونة لأنها تقبل الأعداد الصحيحة والعشرية معًا."
    ],
    "challenge": {
      "prompt": "اطلب من المستخدم رقمين منفصلين وحوّلهما إلى int، ثم اطبع ناتج ضربهما.",
      "starter_code": "a = int(input(\"الرقم الأول: \"))\nb = int(input(\"الرقم الثاني: \"))\nprint(a * b)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'التفاعل مع المستخدم',
  'ابنِ حوارًا بسيطًا متعدد الأسئلة بين البرنامج والمستخدم.',
  '["استخدام أكثر من input() في نفس البرنامج", "دمج القيم المُدخلة في رسالة نهائية"]'::jsonb,
  $j${
    "explanation": "يمكنك استخدام أكثر من input() في نفس البرنامج لبناء حوار كامل يجمع عدة معلومات من المستخدم، ثم يستخدمها كلها معًا في رسالة أو حساب نهائي. هذا النمط أساسي في برامج كثيرة مثل استمارات التسجيل والألعاب النصية البسيطة.",
    "code_examples": [
      {"code": "name = input(\"ما اسمك؟ \")\ncity = input(\"من أي مدينة؟ \")\nhobby = input(\"ما هوايتك؟ \")\n\nprint(f\"{name} من {city} ويحب {hobby}. تشرفنا بمعرفتك!\")", "explanation": "ثلاثة أسئلة متتالية تجمع بيانات مختلفة، ثم نجمعها كلها في جملة واحدة باستخدام f-string (سنتعمق فيها لاحقًا) لعرض ملخص أنيق."}
    ],
    "common_mistakes": [
      "خلط ترتيب الأسئلة بحيث تصبح الرسالة النهائية غير مفهومة.",
      "نسيان مسافة بعد نص الرسالة داخل input()، فتلتصق إجابة المستخدم بالسؤال في الطرفية."
    ],
    "tips": [
      "فكّر بالتسلسل مسبقًا: ما الأسئلة التي أحتاجها؟ بأي ترتيب؟",
      "اختبر برنامجك بإجابات مختلفة للتأكد أنه يعمل بشكل جيد مع كل الحالات."
    ],
    "challenge": {
      "prompt": "اطرح 3 أسئلة على المستخدم (الاسم، المهنة، البلد)، ثم اطبع بطاقة تعريف مبنية على إجاباته.",
      "starter_code": "name = input(\"الاسم: \")\njob = input(\"المهنة: \")\ncountry = input(\"البلد: \")\nprint(name, \"-\", job, \"-\", country)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'تمارين على input()',
  'طبّق كل ما تعلمته عن input() في تمارين متكاملة.',
  '["دمج input مع التحويل والعمليات الحسابية", "بناء آلة حاسبة بسيطة"]'::jsonb,
  $j${
    "explanation": "لنبنِ الآن آلة حاسبة صغيرة جدًا تجمع كل مهارات هذا الفصل: قراءة الإدخال، تحويله لأرقام، وإجراء عملية حسابية عليه، ثم عرض النتيجة بشكل واضح للمستخدم. هذا أول \"برنامج مفيد\" حقيقي تكتبه بنفسك!",
    "code_examples": [
      {"code": "first_num = float(input(\"الرقم الأول: \"))\nsecond_num = float(input(\"الرقم الثاني: \"))\n\nresult = first_num + second_num\nprint(\"الناتج:\", result)", "explanation": "نقرأ رقمين ونحولهما لـ float مباشرة (تدعم الأعداد الصحيحة والعشرية معًا)، ثم نجمعهما ونطبع الناتج."}
    ],
    "common_mistakes": [
      "نسيان تحويل كلا الرقمين، فتحدث محاولة جمع نص مع رقم.",
      "عدم اختبار البرنامج بأرقام عشرية مثل 3.5 للتأكد من أنه يعمل بشكل صحيح."
    ],
    "tips": [
      "هذا النمط (input → تحويل → معالجة → عرض النتيجة) ستستخدمه في كل مسائل Problem Solving تقريبًا.",
      "جرّب تعديل الكود لطرح أو ضرب الرقمين بدل جمعهما لتتدرب أكثر."
    ],
    "challenge": {
      "prompt": "ابنِ آلة حاسبة تطلب رقمين وتطبع مجموعهما، الفرق بينهما، وحاصل ضربهما.",
      "starter_code": "a = float(input(\"الرقم الأول: \"))\nb = float(input(\"الرقم الثاني: \"))\nprint(\"المجموع:\", a + b)\nprint(\"الفرق:\", a - b)\nprint(\"الضرب:\", a * b)"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا تُرجع دالة input() دائمًا؟', 'multiple_choice',
  '["str", "int", "float", "bool"]'::jsonb,
  'str', 'input() تُرجع دائمًا نصًا (str) بغض النظر عمّا كتبه المستخدم، حتى لو كتب أرقامًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الدالة الصحيحة لتحويل نص مثل "25" إلى عدد صحيح؟', 'multiple_choice',
  '["int()", "str()", "input()", "print()"]'::jsonb,
  'int()', 'الدالة int() تحوّل نصًا يمثل عددًا صحيحًا إلى النوع int فعليًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'يمكن استخدام أكثر من input() واحد في نفس البرنامج.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'يمكنك استدعاء input() عدة مرات لجمع عدة معلومات من المستخدم في نفس البرنامج.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'إذا أدخل المستخدم 4 و5 في برنامج a=float(input()) وb=float(input())، ماذا يطبع print(a+b)؟', 'predict_output',
  '["9.0", "45", "\"45\"", "خطأ"]'::jsonb,
  '9.0', 'بعد التحويل لـ float تصبح القيمتان 4.0 و5.0، ومجموعهما 9.0.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 8;
