-- ============================================================
-- Eleven — Migration 0010: Chapter 5 — تحويل الأنواع (Type Casting)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هو التحويل بين الأنواع؟',
  'افهم لماذا نحتاج أحيانًا لتحويل قيمة من نوع لآخر.',
  '["فهم مفهوم Type Casting", "التفريق بين التحويل الصريح والتحويل الضمني"]'::jsonb,
  $j${
    "explanation": "التحويل بين الأنواع (Type Casting أو Type Conversion) يعني تغيير نوع قيمة من نوع لآخر، مثل تحويل نص إلى رقم أو رقم إلى نص. Python تدعم نوعين من التحويل: التحويل الضمني (Implicit) الذي تقوم به Python تلقائيًا في حالات آمنة معينة (مثل جمع int مع float ينتج float تلقائيًا)، والتحويل الصريح (Explicit) الذي نكتبه نحن يدويًا باستخدام دوال مثل int() وfloat() وstr().",
    "code_examples": [
      {"code": "a = 5      # int\nb = 2.5    # float\nresult = a + b   # تحويل ضمني: تصبح النتيجة float تلقائيًا\nprint(result, type(result))", "explanation": "عند جمع int وfloat، تحوّل Python تلقائيًا الـ int إلى float قبل الجمع (تحويل ضمني)، فتكون النتيجة 7.5 من نوع float."}
    ],
    "common_mistakes": [
      "الاعتقاد أن كل عمليات الجمع بين أنواع مختلفة تتم تلقائيًا — جمع نص برقم مثلًا يسبب خطأ ويحتاج تحويلًا صريحًا.",
      "نسيان أن التحويل الصريح يُنشئ قيمة جديدة ولا يُغيّر المتغير الأصلي إلا إذا أعدت إسناده."
    ],
    "tips": [
      "استخدم type() دائمًا عندما تشك في نوع قيمة معينة بعد عملية ما.",
      "التحويل الصريح هو صديقك الدائم عند التعامل مع مدخلات المستخدم القادمة من input()."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرًا int وآخر float واجمعهما، ثم اطبع نوع الناتج للتأكد من التحويل الضمني.",
      "starter_code": "x = 3\ny = 1.5\nresult = x + y\nprint(result, type(result))"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'التحويل إلى نص: str()',
  'حوّل أي قيمة إلى نص لدمجها مع نصوص أخرى بأمان.',
  '["استخدام str() لتحويل أرقام وقيم منطقية إلى نص", "دمج نص مع رقم بدون أخطاء"]'::jsonb,
  $j${
    "explanation": "عندما تحاول دمج نص مع رقم باستخدام + مباشرة، تحصل على خطأ TypeError لأن Python لا تسمح بجمع أنواع مختلفة بهذه الطريقة. الحل هو تحويل الرقم إلى نص أولًا باستخدام str()، وحينها يصبح الدمج (Concatenation) ممكنًا وآمنًا. هذا شائع جدًا عند بناء رسائل تحتوي على قيم رقمية.",
    "code_examples": [
      {"code": "age = 20\nmessage = \"عمري \" + str(age) + \" سنة\"\nprint(message)", "explanation": "بدون str(age) سيحدث خطأ لأن age رقم و\"عمري \" نص. باستخدام str() نحوّل الرقم إلى نص أولًا فيصبح الدمج ممكنًا، والنتيجة: عمري 20 سنة."}
    ],
    "common_mistakes": [
      "محاولة \"العمر: \" + 20 مباشرة دون str()، مما يسبب TypeError.",
      "استخدام str() على قيمة نصية أصلًا — غير خاطئ لكنه غير ضروري."
    ],
    "tips": [
      "لاحقًا سنتعلم f-strings وهي طريقة أنظف وأسهل لدمج القيم دون الحاجة لـ str() في كل مرة.",
      "str() تعمل مع أي نوع تقريبًا: أرقام، bool، حتى القوائم."
    ],
    "challenge": {
      "prompt": "أنشئ متغير points برقم، ثم اطبع جملة تدمج نصًا مع هذا الرقم باستخدام str().",
      "starter_code": "points = 95\nprint(\"حصلت على \" + str(points) + \" نقطة\")"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'التحويل بين int وfloat',
  'تعمّق في تحويل الأعداد الصحيحة والعشرية وما يحدث عند فقدان الدقة.',
  '["استخدام int() لتقريب/قطع الجزء العشري", "فهم أن int() يقطع الفاصلة ولا يقرّب"]'::jsonb,
  $j${
    "explanation": "عند تحويل float إلى int باستخدام int()، تقوم Python بحذف (قطع) الجزء العشري تمامًا وليس تقريبه رياضيًا؛ فمثلًا int(9.9) تعطي 9 وليس 10. إذا أردت تقريبًا رياضيًا حقيقيًا، تستخدم الدالة round() بدلًا من int(). هذا الفرق مهم جدًا ويسبب أخطاء منطقية شائعة عند المبتدئين.",
    "code_examples": [
      {"code": "price = 9.9\nprint(int(price))     # قطع الجزء العشري\nprint(round(price))    # تقريب رياضي حقيقي", "explanation": "int(9.9) يقطع الجزء العشري فيعطي 9. أما round(9.9) فيقرّب رياضيًا للأقرب فيعطي 10. النتيجتان مختلفتان رغم أن المصدر نفسه!"}
    ],
    "common_mistakes": [
      "الاعتقاد أن int() تقرّب الرقم — في الحقيقة هي فقط تحذف كل ما بعد الفاصلة العشرية.",
      "استخدام int() في حسابات تتطلب دقة مالية، مما يفقد جزءًا من القيمة الحقيقية."
    ],
    "tips": [
      "استخدم round() عندما تريد أقرب قيمة صحيحة منطقيًا، وint() فقط عندما تريد تجاهل الكسور عمدًا.",
      "round(value, digits) تسمح لك أيضًا بالتقريب لعدد معين من الخانات العشرية، مثل round(3.14159, 2)."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرًا float مثل 7.6، واطبع نتيجة int() وnتيجة round() عليه لترى الفرق.",
      "starter_code": "value = 7.6\nprint(\"int:\", int(value))\nprint(\"round:\", round(value))"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'تمارين على تحويل الأنواع',
  'وحّد فهمك لـ int()، float()، وstr() في تمرين شامل.',
  '["دمج التحويل مع input في برنامج واقعي", "تجنب الأخطاء الشائعة في التحويل"]'::jsonb,
  $j${
    "explanation": "لنبنِ برنامجًا يحسب سعر فاتورة بعد الضريبة، يستخدم input() لقراءة السعر الأساسي كنص، يحوّله لـ float، يحسب الضريبة، ثم يعرض النتيجة النهائية كنص منسّق. هذا مثال واقعي يجمع كل ما تعلمته في هذا الفصل.",
    "code_examples": [
      {"code": "base_price = float(input(\"سعر المنتج: \"))\ntax_rate = 0.15\ntax_amount = base_price * tax_rate\ntotal = base_price + tax_amount\n\nprint(\"الضريبة: \" + str(round(tax_amount, 2)))\nprint(\"الإجمالي: \" + str(round(total, 2)))", "explanation": "نقرأ السعر كنص عبر input()، نحوله لـ float للحساب، نحسب الضريبة والإجمالي، ثم نحوّل النتائج لنص عبر str() لدمجها في رسالة، مع تقريبها بـ round() لخانتين عشريتين."}
    ],
    "common_mistakes": [
      "نسيان تحويل base_price من input() إلى float قبل ضربه في tax_rate.",
      "طباعة أرقام عشرية طويلة جدًا دون تقريبها بـ round() فتبدو النتيجة غير منظمة."
    ],
    "tips": [
      "دائمًا اسأل نفسك: هل هذه القيمة تحتاج لتكون رقمًا للحساب، أم نصًا للعرض؟",
      "التقريب بـ round(value, 2) شائع جدًا في أي حسابات مالية لعرض رقمين بعد الفاصلة فقط."
    ],
    "challenge": {
      "prompt": "اطلب من المستخدم درجتين في مادتين، احسب المعدل، واطبعه مقربًا لخانة عشرية واحدة.",
      "starter_code": "grade1 = float(input(\"الدرجة الأولى: \"))\ngrade2 = float(input(\"الدرجة الثانية: \"))\naverage = (grade1 + grade2) / 2\nprint(\"المعدل:\", round(average, 1))"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا يحدث عند جمع int مع float في Python؟', 'multiple_choice',
  '["خطأ دائمًا", "تحويل ضمني تلقائي والناتج float", "يبقى الناتج int", "يجب تحويلهما يدويًا أولًا"]'::jsonb,
  'تحويل ضمني تلقائي والناتج float', 'Python تقوم بتحويل ضمني تلقائي عند جمع int وfloat، والنتيجة تكون دائمًا من نوع float.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'لماذا نحتاج str() عند دمج نص مع رقم بعلامة +؟', 'multiple_choice',
  '["لأن + لا تعمل مع الأنواع المختلطة مباشرة", "لتسريع الكود", "لأن print تتطلب ذلك دائمًا", "لا حاجة فعلية لها"]'::jsonb,
  'لأن + لا تعمل مع الأنواع المختلطة مباشرة', 'محاولة دمج str مع int مباشرة بعلامة + تسبب TypeError، لذا نحوّل الرقم لنص أولًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا يطبع print(int(9.9))؟', 'predict_output',
  '["10", "9", "9.9", "خطأ"]'::jsonb,
  '9', 'int() تقطع الجزء العشري دون تقريب، لذا int(9.9) يعطي 9 وليس 10.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'الدالة round() تقرّب الرقم رياضيًا، بينما int() تقطع الجزء العشري فقط.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'هذا هو الفرق الجوهري بين الدالتين، وهو مصدر خطأ منطقي شائع عند المبتدئين إن لم يُفهم جيدًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 4;
