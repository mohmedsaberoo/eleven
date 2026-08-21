-- ============================================================
-- Eleven — Migration 0017: Chapter 11 — دوال النصوص (String Methods)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'تنسيق الحالة: upper, lower, title',
  'غيّر حالة أحرف النص بسهولة باستخدام دوال جاهزة.',
  '["استخدام upper() وlower() لتوحيد حالة النص", "استخدام title() لتنسيق العناوين", "فهم أن هذه الدوال تُرجع نصًا جديدًا"]'::jsonb,
  $j${
    "explanation": "النصوص في Python تمتلك دوال جاهزة (Methods) نستدعيها بكتابة اسم المتغير متبوعًا بنقطة ثم اسم الدالة. upper() تحوّل كل الحروف لأحرف كبيرة، lower() تحوّلها لأحرف صغيرة، وtitle() تجعل أول حرف من كل كلمة كبيرًا. تذكّر أن النصوص Immutable، لذا هذه الدوال لا تُعدّل النص الأصلي، بل تُرجع نصًا جديدًا يجب تخزينه إن أردت الاحتفاظ به.",
    "code_examples": [
      {"code": "name = \"python eleven\"\nprint(name.upper())   # PYTHON ELEVEN\nprint(name.lower())   # python eleven\nprint(name.title())   # Python Eleven", "explanation": "كل دالة تُرجع نسخة جديدة معدّلة من النص الأصلي دون تغيير المتغير name نفسه؛ لهذا نطبع نتيجة كل استدعاء مباشرة."}
    ],
    "common_mistakes": [
      "توقّع أن name.upper() تُغيّر قيمة name نفسها — يجب إعادة تخزين الناتج مثل name = name.upper() إن أردت التغيير الفعلي.",
      "استخدام upper() أو lower() للمقارنة دون تخزين النتيجة، مثل if name.upper() == \"PYTHON\": ثم استخدام name الأصلي لاحقًا بالخطأ."
    ],
    "tips": [
      "upper()/lower() مفيدتان جدًا لمقارنة نصوص بغض النظر عن حالة الأحرف، مثل مقارنة بريد إلكتروني.",
      "يمكنك ربط عدة دوال معًا (Method Chaining) مثل text.strip().lower()."
    ],
    "challenge": {
      "prompt": "اطلب اسم المستخدم واطبعه بثلاث صيغ: كامل بأحرف كبيرة، كامل بأحرف صغيرة، وبصيغة عنوان.",
      "starter_code": "name = input(\"اسمك: \")\nprint(name.upper())\nprint(name.lower())\nprint(name.title())"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'strip, replace, split',
  'نظّف النصوص من المسافات الزائدة، استبدل أجزاء منها، أو قسّمها لأجزاء.',
  '["استخدام strip() لإزالة المسافات الزائدة", "استخدام replace() لاستبدال جزء من النص", "استخدام split() لتقسيم النص لقائمة"]'::jsonb,
  $j${
    "explanation": "strip() تُزيل المسافات (أو أي حروف تحددها) من بداية ونهاية النص فقط، وهي مفيدة جدًا لتنظيف مدخلات المستخدم القادمة من input(). replace(old, new) تستبدل كل ظهور لجزء نصي بجزء آخر. split(separator) تُقسّم النص إلى قائمة (List — سنتعمق فيها قريبًا) من الأجزاء بناءً على فاصل محدد، والفاصل الافتراضي هو المسافة.",
    "code_examples": [
      {"code": "text = \"  Python Eleven  \"\nprint(text.strip())          # \"Python Eleven\"\n\nsentence = \"I like cats\"\nprint(sentence.replace(\"cats\", \"dogs\"))  # I like dogs\n\nwords = sentence.split()\nprint(words)   # ['I', 'like', 'cats']", "explanation": "strip() أزالت المسافات الزائدة من الطرفين فقط (وليس من المنتصف). replace() استبدلت \"cats\" بـ\"dogs\" في كل النص. split() قسّمت الجملة إلى قائمة من ثلاث كلمات منفصلة عند كل مسافة."}
    ],
    "common_mistakes": [
      "الاعتقاد أن strip() تُزيل كل المسافات من النص بالكامل — هي فقط تُزيل من البداية والنهاية.",
      "نسيان أن replace() تستبدل كل التطابقات في النص وليس تطابقًا واحدًا فقط."
    ],
    "tips": [
      "استخدم strip() دائمًا على مدخلات input() الحسّاسة (مثل أسماء المستخدمين) لتفادي مشاكل المسافات غير المقصودة.",
      "split() هي الخطوة الأولى الشائعة جدًا للتعامل مع أي نص يحتوي عدة قيم مفصولة، وسنستخدمها كثيرًا في مسائل Problem Solving."
    ],
    "challenge": {
      "prompt": "اطلب جملة من المستخدم، نظّفها بـstrip()، ثم قسّمها لكلمات واطبع عدد الكلمات باستخدام len().",
      "starter_code": "sentence = input(\"اكتب جملة: \").strip()\nwords = sentence.split()\nprint(f\"عدد الكلمات: {len(words)}\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'البحث داخل النص',
  'تحقق من احتواء نص على جزء معين، وابحث عن موقعه.',
  '["استخدام in للتحقق من احتواء النص على جزء معين", "استخدام startswith() وendswith()", "استخدام count() لعدّ التكرارات"]'::jsonb,
  $j${
    "explanation": "للتحقق هل يحتوي نص على جزء نصي معين، تستخدم الكلمة المفتاحية in داخل شرط، وتُرجع True أو False. startswith(text) تتحقق هل يبدأ النص بجزء معين، وendswith(text) تتحقق هل ينتهي به. count(text) تُرجع عدد مرات ظهور جزء نصي معين داخل النص الكامل. كل هذه الأدوات أساسية جدًا للتعامل مع النصوص في مسائل حقيقية.",
    "code_examples": [
      {"code": "email = \"student@eleven.com\"\nprint(\"@\" in email)                  # True\nprint(email.startswith(\"student\"))   # True\nprint(email.endswith(\".com\"))        # True\nprint(email.count(\"e\"))              # عدد ظهور حرف e", "explanation": "in تتحقق ببساطة من وجود @ في النص. startswith وendswith تتحققان من بداية ونهاية النص تحديدًا. count() تعدّ كل مرات ظهور الحرف e في كامل النص."}
    ],
    "common_mistakes": [
      "استخدام == بدل in عند البحث عن جزء من نص وليس النص كاملًا.",
      "نسيان أن هذه العمليات حسّاسة لحالة الأحرف (Case-Sensitive)، فـ \"Python\" لا تساوي \"python\" في المقارنة."
    ],
    "tips": [
      "in تعمل أيضًا مع القوائم لاحقًا وليس فقط النصوص — مفهوم مشترك سترى تكراره كثيرًا.",
      "لتجاهل حالة الأحرف عند البحث، حوّل الطرفين لنفس الحالة أولًا: text.lower() in other.lower()."
    ],
    "challenge": {
      "prompt": "اطلب بريدًا إلكترونيًا من المستخدم وتحقق أنه يحتوي على @ وينتهي بـ.com.",
      "starter_code": "email = input(\"البريد الإلكتروني: \")\nif \"@\" in email and email.endswith(\".com\"):\n    print(\"بريد إلكتروني صالح الشكل\")\nelse:\n    print(\"صيغة غير صحيحة\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 6)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'تمارين على دوال النصوص',
  'وحّد كل دوال النصوص التي تعلمتها في أداة تحقق متكاملة.',
  '["دمج عدة دوال نصية معًا في برنامج واحد", "بناء مدقق كلمة مرور متقدم"]'::jsonb,
  $j${
    "explanation": "لنبنِ مدقق كلمة مرور أكثر واقعية يتحقق من عدة شروط معًا: الطول الكافي، احتواء رقم واحد على الأقل، واحتواء حرف كبير واحد على الأقل. هذا التمرين يجمع len()، الحلقات (سنستخدم مفهومًا بسيطًا منها هنا)، والدوال النصية في أداة عملية شبيهة بما تراه في مواقع التسجيل الحقيقية.",
    "code_examples": [
      {"code": "password = input(\"كلمة المرور: \").strip()\n\nhas_digit = any(ch.isdigit() for ch in password)\nhas_upper = any(ch.isupper() for ch in password)\n\nif len(password) >= 8 and has_digit and has_upper:\n    print(\"كلمة مرور قوية ✅\")\nelse:\n    print(\"كلمة المرور ضعيفة، أضف رقمًا وحرفًا كبيرًا وتأكد من الطول\")", "explanation": "isdigit() تتحقق هل الحرف رقم، وisupper() تتحقق هل الحرف كبير — هما دالتان نصيتان إضافيتان مفيدتان جدًا. any() تتحقق إن كان أي عنصر في القائمة الناتجة True (سنتعمق في هذا النمط لاحقًا مع الحلقات)."}
    ],
    "common_mistakes": [
      "نسيان strip() على مدخل كلمة المرور، فتُحسب مسافة زائدة ضمن الطول أو الشروط بشكل غير مقصود.",
      "التحقق من الشروط بشكل منفصل بدل دمجها بـ and في شرط واحد شامل."
    ],
    "tips": [
      "isdigit()، isalpha()، isupper()، islower() كلها دوال نصية جاهزة مفيدة جدًا — جرّبها بنفسك على أمثلة مختلفة.",
      "لا تقلق إن بدا كود any() مع الحلقة الصغيرة داخله غريبًا الآن؛ سنتعمق في الحلقات (for) في الفصل القادم مباشرة."
    ],
    "challenge": {
      "prompt": "طوّر مدقق كلمة المرور ليتحقق أيضًا أنها لا تحتوي على مسافات إطلاقًا.",
      "starter_code": "password = input(\"كلمة المرور: \")\nhas_space = \" \" in password\nif len(password) >= 8 and not has_space:\n    print(\"مقبولة\")\nelse:\n    print(\"غير مقبولة\")"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint("python".upper())', 'predict_output',
  '["PYTHON", "python", "Python", "خطأ"]'::jsonb,
  'PYTHON', 'upper() تحوّل كل حروف النص إلى أحرف كبيرة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا تفعل دالة split() بدون أي معامل؟', 'multiple_choice',
  '["تقسّم النص عند كل مسافة إلى قائمة", "تحذف كل المسافات", "تدمج نصين", "تحوّل النص لأحرف كبيرة"]'::jsonb,
  'تقسّم النص عند كل مسافة إلى قائمة', 'split() بدون معامل تستخدم المسافة كفاصل افتراضي وتُرجع قائمة من الأجزاء الناتجة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint("@" in "test@mail.com")', 'predict_output',
  '["True", "False", "1", "خطأ"]'::jsonb,
  'True', 'الرمز @ موجود فعلًا داخل النص، لذا in تُرجع True.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'الدوال النصية مثل upper() وlower() تُعدّل المتغير الأصلي مباشرة.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'النصوص Immutable في Python، لذا هذه الدوال تُرجع نصًا جديدًا ولا تُعدّل المتغير الأصلي إلا إذا أعدت تخزين الناتج فيه.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 6 and l.lesson_number = 4;
