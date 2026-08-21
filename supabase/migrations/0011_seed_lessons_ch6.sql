-- ============================================================
-- Eleven — Migration 0011: Chapter 6 — العمليات (Operators)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'العمليات الحسابية',
  'تعرّف على عمليات الجمع، الطرح، الضرب، القسمة، وباقي القسمة.',
  '["استخدام + - * / بثقة", "فهم الفرق بين / و //", "فهم عامل باقي القسمة %"]'::jsonb,
  $j${
    "explanation": "توفر Python العمليات الحسابية الأساسية: + للجمع، - للطرح، * للضرب، / للقسمة (وتُرجع دائمًا float)، // للقسمة الصحيحة (تُرجع العدد الصحيح فقط دون كسور)، و% لباقي القسمة (Modulo) الذي يُرجع الباقي بعد القسمة. هذه العمليات هي الأساس لكل حساب رياضي في برامجك.",
    "code_examples": [
      {"code": "a = 17\nb = 5\nprint(a + b)   # 22\nprint(a - b)   # 12\nprint(a * b)   # 85\nprint(a / b)   # 3.4\nprint(a // b)  # 3\nprint(a % b)   # 2", "explanation": "17 / 5 تعطي 3.4 (float كاملة). 17 // 5 تعطي 3 فقط (القسمة الصحيحة بدون كسر). 17 % 5 تعطي 2 وهو الباقي بعد القسمة (17 = 5×3 + 2)."}
    ],
    "common_mistakes": [
      "الخلط بين / (قسمة عادية تُرجع float) و// (قسمة صحيحة تُرجع int أو float بدون كسر).",
      "نسيان أن % مفيد جدًا لمعرفة إن كان رقم يقبل القسمة على آخر (الباقي = 0)."
    ],
    "tips": [
      "% أداة أساسية لمعرفة الأعداد الزوجية والفردية: n % 2 == 0 يعني عدد زوجي.",
      "تذكّر ترتيب العمليات الرياضية (الأولوية) كما في الرياضيات: الضرب والقسمة قبل الجمع والطرح، ويمكن استخدام الأقواس للتحكم في الترتيب."
    ],
    "challenge": {
      "prompt": "اطلب رقمين من المستخدم واطبع ناتج القسمة العادية، القسمة الصحيحة، والباقي بينهما.",
      "starter_code": "a = int(input(\"الرقم الأول: \"))\nb = int(input(\"الرقم الثاني: \"))\nprint(a / b)\nprint(a // b)\nprint(a % b)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'عمليات المقارنة',
  'قارن بين قيمتين واحصل دائمًا على قيمة bool.',
  '["استخدام == != > < >= <=", "فهم أن نتيجة أي مقارنة هي دائمًا bool"]'::jsonb,
  $j${
    "explanation": "عمليات المقارنة تقارن بين قيمتين وتُرجع دائمًا True أو False. أهمها: == (يساوي)، != (لا يساوي)، > (أكبر من)، < (أصغر من)، >= (أكبر من أو يساوي)، <= (أصغر من أو يساوي). هذه العمليات هي التي ستبني عليها شروط if في الفصل القادم مباشرة، فمن المهم إتقانها جيدًا الآن.",
    "code_examples": [
      {"code": "age = 20\nprint(age == 18)   # False\nprint(age != 18)   # True\nprint(age > 18)    # True\nprint(age >= 20)   # True", "explanation": "كل مقارنة هنا تُنتج bool: age == 18 خطأ لأن 20 لا يساوي 18، بينما age > 18 صحيح لأن 20 أكبر من 18."}
    ],
    "common_mistakes": [
      "استخدام = (إسناد) بدلًا من == (مقارنة) داخل شرط، وهو من أشهر الأخطاء عند المبتدئين.",
      "مقارنة نص برقم مباشرة مثل \"20\" == 20 والاعتقاد أنها True — في الحقيقة هي False لاختلاف النوعين."
    ],
    "tips": [
      "تذكّر: == للمقارنة، = للتخزين — لا تخلط بينهما أبدًا.",
      "اطبع نتيجة أي مقارنة تشك فيها مباشرة لترى قيمتها الفعلية True/False."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرين رقميين واطبع نتيجة كل عمليات المقارنة الستة بينهما.",
      "starter_code": "a = 10\nb = 7\nprint(a == b)\nprint(a != b)\nprint(a > b)\nprint(a < b)\nprint(a >= b)\nprint(a <= b)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'العمليات المنطقية',
  'ادمج أكثر من شرط معًا باستخدام and وor وnot.',
  '["استخدام and لتحقق شرطين معًا", "استخدام or لتحقق أي من شرطين", "استخدام not لعكس قيمة منطقية"]'::jsonb,
  $j${
    "explanation": "العمليات المنطقية تسمح بدمج أكثر من شرط في تعبير واحد: and تُرجع True فقط إذا كان كلا الشرطين صحيحين، or تُرجع True إذا كان أحد الشرطين على الأقل صحيحًا، وnot تعكس القيمة المنطقية (تحوّل True إلى False والعكس). هذه العمليات ضرورية لبناء شروط أكثر تعقيدًا وواقعية.",
    "code_examples": [
      {"code": "age = 25\nhas_id = True\n\ncan_enter = age >= 18 and has_id\nprint(can_enter)   # True\n\nis_weekend = False\nis_holiday = True\ncan_rest = is_weekend or is_holiday\nprint(can_rest)    # True\n\nprint(not has_id)  # False", "explanation": "can_enter يتحقق من شرطين معًا بـ and (العمر كافٍ ولديه هوية). can_rest يكفي تحقق شرط واحد فقط بـ or. not has_id تعكس القيمة True إلى False."}
    ],
    "common_mistakes": [
      "الاعتقاد أن or تتطلب تحقق الشرطين معًا مثل and — في الحقيقة يكفي شرط واحد فقط.",
      "نسيان أولوية العمليات عند دمج and وor معًا في نفس السطر دون أقواس توضيحية."
    ],
    "tips": [
      "استخدم الأقواس لتوضيح ترتيب التقييم عند دمج أكثر من عملية منطقية، حتى لو لم تكن إلزامية دائمًا.",
      "and وor وnot ستكون أدواتك الأساسية لبناء شروط ذكية في الفصل القادم."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرين bool يمثلان (هل الجو مشمس) و(هل معك وقت فراغ)، واطبع نتيجة and وor وnot عليهما.",
      "starter_code": "is_sunny = True\nhas_free_time = False\nprint(is_sunny and has_free_time)\nprint(is_sunny or has_free_time)\nprint(not is_sunny)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 3)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'عمليات الإسناد المختصرة',
  'اختصر كودك باستخدام +=، -=، *=، /= وغيرها.',
  '["استخدام عمليات الإسناد المختصرة الأربع الأساسية", "فهم أنها تعادل كتابة العملية كاملة يدويًا"]'::jsonb,
  $j${
    "explanation": "عمليات الإسناد المختصرة (Compound Assignment) تجمع بين عملية حسابية وإسناد النتيجة لنفس المتغير في خطوة واحدة، مما يجعل الكود أقصر وأوضح. مثلًا score += 5 تعادل تمامًا كتابة score = score + 5 لكنها أقصر. تتوفر لجميع العمليات الحسابية: +=, -=, *=, /=, //=, %=.",
    "code_examples": [
      {"code": "balance = 100\nbalance -= 30   # balance = balance - 30\nprint(balance)  # 70\n\nbalance *= 2    # balance = balance * 2\nprint(balance)  # 140", "explanation": "balance -= 30 تطرح 30 من الرصيد الحالي وتحفظ الناتج مباشرة في balance. ثم balance *= 2 تضاعف القيمة الحالية بنفس الطريقة المختصرة."}
    ],
    "common_mistakes": [
      "الاعتقاد أن += تعني \"أضف\" فقط بدون تخزين — في الحقيقة هي تُخزّن النتيجة الجديدة في نفس المتغير مباشرة.",
      "استخدام المتغير في += قبل تعريفه بقيمة ابتدائية، مما يسبب خطأ NameError."
    ],
    "tips": [
      "استخدم هذه العمليات المختصرة كلما أمكن — ستراها كثيرًا جدًا في حلقات العدّ لاحقًا.",
      "تذكّر: كل عملية حسابية أساسية لها نسخة مختصرة مطابقة (+ → +=، - → -=، إلخ)."
    ],
    "challenge": {
      "prompt": "أنشئ متغير score يبدأ من 0، ثم زده بـ10 باستخدام +=، ثم اضربه في 3 باستخدام *=، ثم اطبع القيمة النهائية.",
      "starter_code": "score = 0\nscore += 10\nscore *= 3\nprint(score)"
    }
  }$j$::jsonb, 8, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما ناتج 17 // 5 في Python؟', 'predict_output',
  '["3.4", "3", "2", "4"]'::jsonb,
  '3', 'القسمة الصحيحة // تُرجع العدد الصحيح فقط بدون كسر، و17 مقسومة على 5 تعطي 3 صحيحة والباقي 2.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا تُرجع أي عملية مقارنة مثل == أو > في Python؟', 'multiple_choice',
  '["قيمة bool دائمًا (True أو False)", "رقمًا دائمًا", "نصًا دائمًا", "لا شيء"]'::jsonb,
  'قيمة bool دائمًا (True أو False)', 'كل عمليات المقارنة تنتج قيمة منطقية True أو False فقط.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint(True and False)', 'predict_output',
  '["True", "False", "None", "خطأ"]'::jsonb,
  'False', 'and تتطلب أن يكون كلا الطرفين True لتُرجع True، وبما أن أحدهما False فالناتج False.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nscore = 10\nscore *= 3\nprint(score)', 'predict_output',
  '["13", "30", "10", "3"]'::jsonb,
  '30', 'score *= 3 تعادل score = score * 3، أي 10 * 3 = 30.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 3 and l.lesson_number = 8;
