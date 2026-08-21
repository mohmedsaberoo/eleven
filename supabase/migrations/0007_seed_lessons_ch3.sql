-- ============================================================
-- Eleven — Migration 0007: Chapter 3 full lesson content — أنواع البيانات
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'الأعداد: int و float',
  'الفرق بين الأعداد الصحيحة والأعداد العشرية في Python.',
  '["التفريق بين int و float", "إجراء عمليات حسابية بسيطة", "استخدام type() لمعرفة نوع القيمة"]'::jsonb,
  $j${
    "explanation": "في Python نوعان أساسيان للأرقام: int (Integer) وهو العدد الصحيح بدون فاصلة عشرية مثل 5 أو -12، وfloat وهو العدد العشري الذي يحتوي على فاصلة مثل 3.14 أو 0.5. يمكنك معرفة نوع أي قيمة باستخدام الدالة الجاهزة type(). التفريق بين النوعين مهم لأن بعض العمليات تتصرف بشكل مختلف قليلًا حسب النوع، خصوصًا في القسمة.",
    "code_examples": [
      {"code": "age = 20\nprice = 19.99\nprint(type(age))\nprint(type(price))", "explanation": "age هو int لأنه عدد صحيح بدون فاصلة، وprice هو float لاحتوائه على فاصلة عشرية. type() تطبع نوع كل قيمة: <class 'int'> و<class 'float'>."}
    ],
    "common_mistakes": [
      "الاعتقاد أن 5 و5.0 لهما نفس النوع تمامًا — الأول int والثاني float رغم تساوي القيمة رياضيًا.",
      "نسيان أن القسمة بعلامة / في Python تُرجع دائمًا float حتى لو كانت الأعداد صحيحة."
    ],
    "tips": [
      "استخدم type() كثيرًا في بداية تعلمك للتأكد من نوع القيمة التي تتعامل معها.",
      "float يُستخدم غالبًا في الأسعار، الأوزان، وأي قياس دقيق."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرًا int لعدد الطلاب في صفك، ومتغيرًا float لمعدلهم الدراسي، واطبع النوعين.",
      "starter_code": "students_count = 30\naverage_grade = 85.5\nprint(type(students_count))\nprint(type(average_grade))"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'النصوص: str',
  'تعرّف على نوع النصوص (String) وكيفية إنشائه ودمجه.',
  '["إنشاء قيم نصية بعلامات تنصيص مفردة أو مزدوجة", "دمج النصوص باستخدام +", "تكرار نص باستخدام *"]'::jsonb,
  $j${
    "explanation": "str (String) هو نوع البيانات الذي يمثل النصوص، ويُكتب بين علامتي تنصيص مفردتين ' ' أو مزدوجتين \" \" (كلاهما صحيح في Python، لكن يُفضّل الالتزام بنوع واحد في مشروعك). يمكنك دمج نصين باستخدام +، وتكرار نص عدة مرات باستخدام *.",
    "code_examples": [
      {"code": "first = \"Python\"\nsecond = \"Eleven\"\ncombined = first + \" \" + second\nprint(combined)\nprint(\"ha\" * 3)", "explanation": "دمجنا first وsecond مع مسافة بينهما باستخدام +، فطبعنا Python Eleven. ثم كررنا \"ha\" ثلاث مرات فأنتجت hahaha."}
    ],
    "common_mistakes": [
      "محاولة جمع نص مع رقم مباشرة مثل \"العمر\" + 20، مما يسبب خطأ TypeError — يجب تحويل الرقم لنص أولًا.",
      "نسيان المسافة عند دمج النصوص فتلتصق الكلمات ببعضها."
    ],
    "tips": [
      "استخدم علامة تنصيص واحدة (مفردة أو مزدوجة) بثبات في كل مشروعك لتفادي الالتباس.",
      "عملية * على النصوص مفيدة جدًا لرسم خطوط فاصلة، مثل print(\"-\" * 20)."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرين نصيين لاسمك الأول والأخير، وادمجهما في متغير full_name، ثم اطبعه.",
      "starter_code": "first_name = \"...\"\nlast_name = \"...\"\nfull_name = first_name + \" \" + last_name\nprint(full_name)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'القيم المنطقية: bool',
  'تعرّف على True و False واستخدامهما في اتخاذ القرارات.',
  '["فهم أن bool له قيمتان فقط True/False", "معرفة كيف تنتج عمليات المقارنة قيمًا منطقية", "التمهيد لمفهوم الشرط if"]'::jsonb,
  $j${
    "explanation": "bool (Boolean) هو نوع بيانات له قيمتان فقط: True (صحيح) أو False (خطأ)، وتُكتب دائمًا بحرف كبير في البداية. هذا النوع أساسي جدًا لأنه العمود الفقري لاتخاذ القرارات في البرمجة (سنراه بكثرة في فصل الشروط القادم). عمليات المقارنة مثل == (يساوي) و> (أكبر من) تُنتج دائمًا قيمة bool.",
    "code_examples": [
      {"code": "is_student = True\nage = 20\nis_adult = age >= 18\nprint(is_student)\nprint(is_adult)", "explanation": "is_student قيمته True مباشرة. is_adult يخزّن نتيجة المقارنة age >= 18، وبما أن 20 أكبر من أو يساوي 18، فالقيمة الناتجة True."}
    ],
    "common_mistakes": [
      "كتابة true أو false بحرف صغير — في Python يجب أن تبدأ بحرف كبير: True و False.",
      "الخلط بين = (إسناد) و== (مقارنة) عند كتابة شرط."
    ],
    "tips": [
      "تذكّر: أي عملية مقارنة (==, !=, >, <, >=, <=) تُرجع دائمًا bool.",
      "bool سيكون أداتك الأساسية في الفصل القادم للتحكم في تدفق البرنامج."
    ],
    "challenge": {
      "prompt": "أنشئ متغير عمر، ثم متغير bool اسمه can_vote يخزّن نتيجة المقارنة هل العمر >= 18، واطبعه.",
      "starter_code": "age = 17\ncan_vote = age >= 18\nprint(can_vote)"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 2)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'مراجعة أنواع البيانات',
  'وحّد فهمك لجميع الأنواع الأساسية (int, float, str, bool) في تمرين شامل.',
  '["التفريق بين الأنواع الأربعة بثقة", "استخدام type() للتحقق من النوع في مواقف مختلفة", "بناء برنامج يجمع الأنواع الأربعة معًا"]'::jsonb,
  $j${
    "explanation": "تعلمنا حتى الآن 4 أنواع بيانات أساسية: int للأعداد الصحيحة، float للأعداد العشرية، str للنصوص، وbool للقيم المنطقية. في هذا الدرس سنجمعها معًا في برنامج واحد بسيط يمثل ملف بيانات منتج في متجر إلكتروني، لتشاهد كيف تتعايش هذه الأنواع في برنامج حقيقي.",
    "code_examples": [
      {"code": "product_name = \"سماعة لاسلكية\"\nprice = 149.99\nquantity = 12\nin_stock = quantity > 0\n\nprint(product_name, type(product_name))\nprint(price, type(price))\nprint(quantity, type(quantity))\nprint(in_stock, type(in_stock))", "explanation": "أربعة متغيرات بأربعة أنواع مختلفة تصف منتجًا واحدًا: اسم (str)، سعر (float)، كمية (int)، وحالة توفر (bool) محسوبة تلقائيًا من مقارنة الكمية بالصفر."}
    ],
    "common_mistakes": [
      "التفكير أن كل الأرقام من نوع واحد فقط بدون تمييز int عن float.",
      "نسيان أن نتيجة مقارنة تُخزَّن كـ bool تلقائيًا دون الحاجة لكتابة True/False يدويًا."
    ],
    "tips": [
      "قبل كل مشروع، فكّر: ما نوع كل بيانة سأخزنها؟ هذا يجنبك أخطاء كثيرة لاحقًا.",
      "لا تقلق إن التبس عليك الأمر أول مرة؛ التمييز بين الأنواع يصبح تلقائيًا مع الممارسة."
    ],
    "challenge": {
      "prompt": "صمم متغيرات لبطاقة كتاب: عنوان (str)، سعر (float)، عدد نسخ متوفرة (int)، وهل هو الأكثر مبيعًا (bool)، ثم اطبعها جميعًا مع أنواعها.",
      "starter_code": "title = \"...\"\nprice = 0.0\ncopies = 0\nis_bestseller = False\nprint(title, type(title))"
    }
  }$j$::jsonb, 9, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي القيم التالية من نوع float؟', 'multiple_choice',
  '["7", "\"7\"", "7.5", "True"]'::jsonb,
  '7.5', 'float هو أي عدد يحتوي على فاصلة عشرية مثل 7.5.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint("ha" * 2)', 'predict_output',
  '["haha", "ha ha", "h a h a", "خطأ"]'::jsonb,
  'haha', 'عملية * على نص تكرره العدد المحدد من المرات بدون أي فواصل تلقائية.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما ناتج 20 >= 18 في Python؟', 'multiple_choice',
  '["True", "False", "20", "خطأ"]'::jsonb,
  'True', '20 أكبر من أو يساوي 18 فعلًا، لذلك ناتج المقارنة True.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'bool في Python له 3 قيم ممكنة: True وFalse وNone.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'bool له قيمتان فقط: True و False. None نوع مختلف تمامًا يمثل غياب القيمة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 2 and l.lesson_number = 4;
