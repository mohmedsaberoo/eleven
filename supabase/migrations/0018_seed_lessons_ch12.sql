-- ============================================================
-- Eleven — Migration 0018: Chapter 12 — الفهرسة والتقطيع (Slicing)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'الفهرسة (Indexing)',
  'الوصول لحرف واحد محدد من النص باستخدام موقعه (Index).',
  '["فهم أن الفهرسة تبدأ من الصفر", "الوصول لحرف بموقعه من البداية", "استخدام الفهرسة السالبة للوصول من النهاية"]'::jsonb,
  $j${
    "explanation": "بما أن النص سلسلة مرتبة من الحروف، يمكنك الوصول لأي حرف فيها عبر موقعه (Index) باستخدام أقواس مربعة []. مهم جدًا: الفهرسة في Python تبدأ من 0 وليس من 1، فأول حرف موقعه 0، والثاني موقعه 1، وهكذا. كما تدعم Python الفهرسة السالبة للوصول من النهاية: -1 يعني آخر حرف، -2 يعني قبل الأخير، وهكذا.",
    "code_examples": [
      {"code": "word = \"Python\"\nprint(word[0])    # P (أول حرف)\nprint(word[1])    # y\nprint(word[-1])   # n (آخر حرف)\nprint(word[-2])   # o (قبل الأخير)", "explanation": "word[0] يُرجع أول حرف P وليس الحرف الثاني، لأن الفهرسة تبدأ من 0. word[-1] طريقة سهلة جدًا للوصول لآخر حرف دون الحاجة لمعرفة طول النص بالضبط."}
    ],
    "common_mistakes": [
      "الاعتقاد أن الفهرسة تبدأ من 1، وهو خطأ شائع جدًا عند المبتدئين القادمين من لغات أخرى أو من الحدس الطبيعي.",
      "محاولة الوصول لموقع خارج حدود النص، مثل word[100] على نص قصير، مما يسبب خطأ IndexError."
    ],
    "tips": [
      "تذكّر دائمًا: آخر حرف في نص طوله n هو عند الموقع n-1 وليس n.",
      "الفهرسة السالبة (-1, -2, ...) طريقة أنيقة جدًا للوصول من النهاية دون حساب الطول يدويًا."
    ],
    "challenge": {
      "prompt": "اطلب كلمة من المستخدم واطبع أول حرف وآخر حرف فيها باستخدام الفهرسة.",
      "starter_code": "word = input(\"اكتب كلمة: \")\nprint(\"أول حرف:\", word[0])\nprint(\"آخر حرف:\", word[-1])"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'التقطيع الأساسي (Slicing)',
  'استخرج جزءًا كاملًا من نص باستخدام صيغة [start:end].',
  '["فهم صيغة text[start:end]", "معرفة أن end غير مشمول في النتيجة", "استخراج أجزاء مختلفة من نص"]'::jsonb,
  $j${
    "explanation": "التقطيع (Slicing) يسمح لك باستخراج جزء كامل (وليس حرفًا واحدًا فقط) من نص، باستخدام الصيغة text[start:end]. النتيجة تبدأ من الموقع start وتنتهي قبل الموقع end مباشرة (أي end نفسه غير مشمول في النتيجة). إذا تركت start فارغًا، يبدأ من أول النص؛ وإذا تركت end فارغًا، يمتد حتى آخر النص.",
    "code_examples": [
      {"code": "text = \"Python Eleven\"\nprint(text[0:6])    # Python\nprint(text[7:])     # Eleven (حتى النهاية)\nprint(text[:6])     # Python (من البداية)\nprint(text[:])       # نسخة كاملة من النص", "explanation": "text[0:6] يستخرج الحروف من الموقع 0 حتى قبل الموقع 6 (أي 6 حروف: P-y-t-h-o-n). text[7:] يبدأ من الموقع 7 ويمتد للنهاية. text[:6] يبدأ من الصفر تلقائيًا وينتهي قبل 6."}
    ],
    "common_mistakes": [
      "توقّع أن end مشمول في النتيجة — text[0:6] يُرجع 6 حروف بالضبط (المواقع 0 إلى 5)، وليس 7.",
      "الخلط بين text[0:6] وtext[6] — الأول يُرجع نصًا جزئيًا (Slice)، والثاني يُرجع حرفًا واحدًا فقط."
    ],
    "tips": [
      "طريقة سهلة لتذكر العدد: عدد الحروف في text[start:end] يساوي end - start.",
      "text[:] بدون أي أرقام تُرجع نسخة كاملة من النص — مفيدة أحيانًا لإنشاء نسخة مستقلة."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرًا نصيًا لتاريخ بصيغة YYYY-MM-DD، واستخرج السنة والشهر واليوم كل واحد على حدة باستخدام Slicing.",
      "starter_code": "date = \"2026-08-20\"\nyear = date[0:4]\nmonth = date[5:7]\nday = date[8:10]\nprint(\"السنة:\", year)\nprint(\"الشهر:\", month)\nprint(\"اليوم:\", day)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'التقطيع المتقدم: الخطوة (Step)',
  'تحكم في اتجاه وخطوة التقطيع، بما في ذلك عكس النص بالكامل.',
  '["استخدام المعامل الثالث step في Slicing", "عكس نص بالكامل بطريقة أنيقة"]'::jsonb,
  $j${
    "explanation": "يدعم التقطيع معاملًا ثالثًا اختياريًا: text[start:end:step] يحدد \"الخطوة\" بين كل عنصر ومختاره التالي. step بقيمة 2 مثلًا يعني \"خذ كل حرف ثانٍ\". الأجمل من ذلك: استخدام step بقيمة -1 يعكس النص بالكامل في سطر واحد فقط، وهي حيلة شهيرة جدًا ومفيدة في Python.",
    "code_examples": [
      {"code": "text = \"abcdefgh\"\nprint(text[::2])     # aceg (كل حرف ثانٍ)\nprint(text[::-1])    # hgfedcba (النص معكوسًا بالكامل)", "explanation": "text[::2] يبدأ من البداية للنهاية لكن يأخذ كل حرف ثانٍ فقط. text[::-1] بترك start وend فارغين واستخدام step=-1 يعكس النص بالكامل — وهي طريقة شائعة جدًا وأنيقة لعكس أي نص."}
    ],
    "common_mistakes": [
      "نسيان النقطتين الإضافيتين عند استخدام step فقط دون start أو end، الصيغة الصحيحة هي [::step].",
      "الاعتقاد أن عكس النص يحتاج حلقة معقدة — بينما [::-1] يفعل ذلك في خطوة واحدة بسيطة جدًا."
    ],
    "tips": [
      "text[::-1] من أشهر \"حيل\" Python وستستخدمها كثيرًا جدًا في مسائل Problem Solving المتعلقة بالنصوص.",
      "جرّب قيمًا مختلفة لـ step (مثل 3 أو -2) على نص من اختيارك لترى تأثيرها بنفسك."
    ],
    "challenge": {
      "prompt": "اطلب كلمة من المستخدم واطبعها معكوسة باستخدام [::-1]، ثم تحقق هل هي Palindrome (تُقرأ نفسها بالعكس).",
      "starter_code": "word = input(\"اكتب كلمة: \")\nreversed_word = word[::-1]\nprint(\"معكوسة:\", reversed_word)\nif word == reversed_word:\n    print(\"هذه الكلمة Palindrome!\")\nelse:\n    print(\"ليست Palindrome\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'تمارين على الفهرسة والتقطيع',
  'طبّق الفهرسة والتقطيع في مسائل عملية متنوعة.',
  '["دمج الفهرسة والتقطيع في حل مسائل حقيقية", "استخراج أجزاء محددة من نصوص منسّقة"]'::jsonb,
  $j${
    "explanation": "لنطبّق كل ما تعلمناه في مسألة عملية: استخراج الاسم الأول من اسم كامل، والحصول على أول 3 حروف من كلمة كنوع من الاختصار (Abbreviation) الشائع في كثير من التطبيقات مثل رموز الدول أو أكواد المنتجات.",
    "code_examples": [
      {"code": "full_name = \"Ahmed Mohamed Ali\"\nfirst_space = full_name.find(\" \")\nfirst_name = full_name[:first_space]\nprint(\"الاسم الأول:\", first_name)\n\nproduct_code = \"laptop\"[:3].upper()\nprint(\"كود المنتج:\", product_code)", "explanation": "find(\" \") تُرجع موقع أول مسافة في النص، ثم نستخدم هذا الموقع في Slicing لاستخراج كل ما قبلها (الاسم الأول). للكود الثاني، نأخذ أول 3 حروف من كلمة laptop ونحولها لأحرف كبيرة للحصول على LAP."}
    ],
    "common_mistakes": [
      "استخدام موقع ثابت (مثل [:5]) بدل البحث الفعلي عن المسافة بـ find()، مما يفشل مع أسماء بأطوال مختلفة.",
      "نسيان أن find() تُرجع -1 إن لم تجد الجزء المطلوب، مما قد يسبب نتائج غير متوقعة إن لم تتحقق من ذلك."
    ],
    "tips": [
      "find(text) دالة نصية مفيدة جدًا تُرجع موقع أول ظهور لجزء نصي، أو -1 إن لم تجده.",
      "الجمع بين find() وSlicing نمط قوي جدًا لاستخراج أجزاء ديناميكية من نصوص متغيرة الطول."
    ],
    "challenge": {
      "prompt": "اطلب اسمًا كاملًا من كلمتين، واستخرج الاسم الأخير فقط باستخدام find() وSlicing.",
      "starter_code": "full_name = input(\"الاسم الكامل: \")\nspace_pos = full_name.find(\" \")\nlast_name = full_name[space_pos + 1:]\nprint(\"الاسم الأخير:\", last_name)"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما موقع أول حرف في أي نص في Python؟', 'multiple_choice',
  '["0", "1", "-1", "لا يوجد موقع"]'::jsonb,
  '0', 'الفهرسة في Python تبدأ دائمًا من 0، لذا أول حرف موقعه 0.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint("Python"[0:3])', 'predict_output',
  '["Pyt", "Pyth", "yth", "Python"]'::jsonb,
  'Pyt', 'التقطيع من 0 إلى 3 يُرجع 3 حروف بالضبط (المواقع 0، 1، 2)، أي P-y-t، دون شمول الموقع 3.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الطريقة الأنيقة لعكس نص كامل في Python؟', 'multiple_choice',
  '["text[::-1]", "text.reverse()", "reverse(text)", "text[-1:]"]'::jsonb,
  'text[::-1]', 'استخدام step=-1 مع ترك start وend فارغين يعكس النص بالكامل في خطوة واحدة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'دالة find() تُرجع -1 إذا لم تجد الجزء النصي المطلوب.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'هذا سلوك مهم يجب التحقق منه دائمًا قبل استخدام الموقع الناتج في عمليات أخرى مثل Slicing.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 8;
