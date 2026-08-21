-- ============================================================
-- Eleven — Migration 0024: Chapter 17 — القواميس (Dictionaries)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هو القاموس (Dictionary)؟',
  'خزّن البيانات على شكل أزواج مفتاح-قيمة بدل الاعتماد على المواقع الرقمية فقط.',
  '["فهم مفهوم مفتاح (Key) وقيمة (Value)", "إنشاء قاموس والوصول لقيمة عبر مفتاحها", "فهم أن المفاتيح يجب أن تكون فريدة"]'::jsonb,
  $j${
    "explanation": "القاموس (Dictionary) هو هيكل بيانات يخزّن المعلومات على شكل أزواج: مفتاح (Key) وقيمة (Value) مرتبطة به، بدلًا من الاعتماد فقط على المواقع الرقمية كما في القوائم. تُنشأ القواميس بأقواس معقوفة {} مع كتابة كل زوج بصيغة key: value مفصولة بفواصل. للوصول لقيمة، تستخدم المفتاح بدلًا من الموقع الرقمي: dict[key]. يجب أن تكون المفاتيح فريدة (لا تكرار)، بينما القيم يمكن أن تتكرر بحرية.",
    "code_examples": [
      {"code": "student = {\"name\": \"سارة\", \"age\": 22, \"major\": \"هندسة\"}\n\nprint(student[\"name\"])   # سارة\nprint(student[\"age\"])    # 22", "explanation": "بدل تذكّر أن الاسم في الموقع 0 والعمر في الموقع 1 (كما في القوائم)، نصل مباشرة عبر مفتاح واضح المعنى مثل \"name\" أو \"age\"، مما يجعل الكود أوضح بكثير."}
    ],
    "common_mistakes": [
      "محاولة الوصول لمفتاح غير موجود مباشرة مثل student[\"job\"]، مما يسبب خطأ KeyError.",
      "الخلط بين استخدام أقواس مربعة [] للوصول للقيمة، وأقواس معقوفة {} لإنشاء القاموس نفسه."
    ],
    "tips": [
      "القواميس هي أحد أهم هياكل البيانات في Python، وستستخدمها كثيرًا جدًا لتمثيل \"كائن\" واحد له عدة خصائص.",
      "اختر أسماء مفاتيح واضحة ومعبّرة (مثل \"full_name\" بدل \"n\") لجعل الكود مقروءًا بذاته."
    ],
    "challenge": {
      "prompt": "أنشئ قاموسًا يمثل كتابًا (title, author, pages)، واطبع كل قيمة عبر مفتاحها.",
      "starter_code": "book = {\"title\": \"...\", \"author\": \"...\", \"pages\": 250}\nprint(book[\"title\"])\nprint(book[\"author\"])\nprint(book[\"pages\"])"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'الإضافة والتعديل والحذف',
  'أضف مفاتيح جديدة، عدّل قيمًا موجودة، واحذف مفاتيح من القاموس.',
  '["إضافة زوج مفتاح-قيمة جديد", "تعديل قيمة مفتاح موجود", "حذف مفتاح باستخدام del أو pop()"]'::jsonb,
  $j${
    "explanation": "لإضافة مفتاح جديد أو تعديل قيمة مفتاح موجود، تستخدم نفس الصيغة: dict[key] = value — إن كان المفتاح موجودًا تتحدث قيمته، وإن لم يكن موجودًا يُضاف تلقائيًا كزوج جديد. للحذف، يمكنك استخدام del dict[key] لحذف مفتاح مباشرة، أو dict.pop(key) التي تحذف المفتاح وتُرجع قيمته في نفس الوقت (مفيدة إن أردت استخدام القيمة قبل حذفها).",
    "code_examples": [
      {"code": "student = {\"name\": \"سارة\", \"age\": 22}\n\nstudent[\"age\"] = 23        # تعديل قيمة موجودة\nstudent[\"city\"] = \"القاهرة\" # إضافة مفتاح جديد\nprint(student)\n\ndel student[\"city\"]\nprint(student)", "explanation": "student[\"age\"] = 23 عدّلت القيمة الموجودة مسبقًا لمفتاح age. student[\"city\"] = \"القاهرة\" أضافت مفتاحًا جديدًا بالكامل لم يكن موجودًا. del student[\"city\"] حذفت هذا المفتاح بالكامل من القاموس."}
    ],
    "common_mistakes": [
      "استخدام del على مفتاح غير موجود أصلًا، مما يسبب خطأ KeyError تمامًا كمحاولة الوصول لمفتاح غير موجود.",
      "الخلط بين إضافة مفتاح جديد وتعديل مفتاح موجود — كلاهما يستخدم نفس الصيغة dict[key] = value لكن بنتيجة مختلفة حسب وجود المفتاح مسبقًا أو عدمه."
    ],
    "tips": [
      "استخدم pop(key) بدل del عندما تحتاج القيمة المحذوفة نفسها لاستخدامها لاحقًا في البرنامج.",
      "يمكنك التحقق من وجود مفتاح قبل الوصول إليه باستخدام in، مثل if \"city\" in student:."
    ],
    "challenge": {
      "prompt": "أنشئ قاموسًا لمنتج، أضف مفتاح \"discount\"، عدّل السعر، ثم احذف مفتاح \"discount\" باستخدام pop() واطبع قيمته قبل الحذف.",
      "starter_code": "product = {\"name\": \"laptop\", \"price\": 15000}\nproduct[\"discount\"] = 1000\nproduct[\"price\"] = 14000\nremoved_discount = product.pop(\"discount\")\nprint(\"الخصم المحذوف:\", removed_discount)\nprint(product)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'keys(), values(), items()',
  'استخرج كل المفاتيح، كل القيم، أو الأزواج كاملة من القاموس دفعة واحدة.',
  '["استخدام keys() لاستخراج كل المفاتيح", "استخدام values() لاستخراج كل القيم", "استخدام items() لاستخراج كل الأزواج معًا"]'::jsonb,
  $j${
    "explanation": "توفر القواميس ثلاث دوال مفيدة جدًا لاستخراج محتواها بالكامل: keys() تُرجع كل المفاتيح، values() تُرجع كل القيم، وitems() تُرجع كل زوج (مفتاح، قيمة) معًا كـTuple. هذه الدوال أساسية جدًا عند المرور على القاموس بالكامل باستخدام حلقة for، وهو ما سنتعمق فيه في الفصل القادم مباشرة.",
    "code_examples": [
      {"code": "prices = {\"apple\": 5, \"banana\": 3, \"mango\": 8}\n\nprint(list(prices.keys()))     # ['apple', 'banana', 'mango']\nprint(list(prices.values()))   # [5, 3, 8]\nprint(list(prices.items()))    # [('apple', 5), ('banana', 3), ('mango', 8)]", "explanation": "قمنا بتحويل نتيجة كل دالة إلى list() لعرضها بوضوح كقائمة عادية. items() تُرجع كل زوج كـTuple يحتوي المفتاح والقيمة معًا، وهو مفيد جدًا عند الحاجة لكليهما في نفس الوقت."}
    ],
    "common_mistakes": [
      "توقّع أن keys() أو values() تُرجع قائمة عادية مباشرة — هي تُرجع نوعًا خاصًا يحتاج لتحويله بـlist() إن أردت التعامل معه كقائمة تقليدية.",
      "استخدام keys() فقط عندما تحتاج فعليًا للقيم أيضًا، بدل استخدام items() مباشرة التي تعطيك الاثنين معًا."
    ],
    "tips": [
      "items() هي الأكثر فائدة عند المرور على القاموس بحلقة for لأنها تعطيك المفتاح والقيمة معًا في خطوة واحدة.",
      "in تعمل افتراضيًا على المفاتيح: \"apple\" in prices تتحقق من وجود apple كمفتاح، وليس كقيمة."
    ],
    "challenge": {
      "prompt": "أنشئ قاموسًا لدرجات 3 مواد، واطبع قائمة بكل أسماء المواد فقط باستخدام keys().",
      "starter_code": "grades = {\"math\": 90, \"science\": 85, \"art\": 95}\nsubjects = list(grades.keys())\nprint(subjects)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'قواميس متداخلة وتمارين',
  'تعرّف على القاموس داخل قاموس، وطبّق ما تعلمته في مثال شامل.',
  '["فهم مفهوم قاموس متداخل (Nested Dictionary)", "بناء سجل بيانات متكامل يشبه قاعدة بيانات مصغّرة"]'::jsonb,
  $j${
    "explanation": "تمامًا كالقوائم المتداخلة، يمكن أن تكون قيمة مفتاح في قاموس هي نفسها قاموس آخر، وهذا يُسمى قاموس متداخل (Nested Dictionary)، ويُستخدم كثيرًا جدًا لتمثيل بيانات معقدة الهيكل، مثل ملف مستخدم كامل يحتوي معلومات شخصية وعنوانًا منفصلًا. هذا النمط شائع جدًا في تطبيقات حقيقية وحتى في تبادل البيانات بين الأنظمة (JSON يعتمد على نفس الفكرة تقريبًا).",
    "code_examples": [
      {"code": "user = {\n    \"name\": \"محمد\",\n    \"contact\": {\n        \"email\": \"m@example.com\",\n        \"phone\": \"0100000000\"\n    }\n}\n\nprint(user[\"name\"])\nprint(user[\"contact\"][\"email\"])", "explanation": "user[\"contact\"] يصل للقاموس الفرعي كاملًا. للوصول لقيمة داخل ذلك القاموس الفرعي تحديدًا، نضيف مفتاحًا آخر مباشرة: user[\"contact\"][\"email\"]، تمامًا كما فعلنا مع القوائم المتداخلة."}
    ],
    "common_mistakes": [
      "نسيان المفتاح الثاني عند محاولة الوصول لقيمة داخل قاموس فرعي، فتحصل على القاموس الفرعي كاملًا بدل القيمة المحددة.",
      "بناء تداخل عميق جدًا وغير منظم يصعب تتبعه، بدل تقسيم البيانات لهيكل أوضح."
    ],
    "tips": [
      "القواميس المتداخلة هي أساس تمثيل بيانات JSON، وهي الصيغة الأكثر شيوعًا لتبادل البيانات بين تطبيقات الويب الحقيقية.",
      "ارسم هيكل القاموس المتداخل على ورقة (كشجرة) إن التبس عليك تتبع المستويات."
    ],
    "challenge": {
      "prompt": "أنشئ قاموسًا لطالب يحتوي اسمه ودرجاته كقاموس فرعي لمادتين، واطبع درجة إحدى المواد مباشرة.",
      "starter_code": "student = {\n    \"name\": \"ليلى\",\n    \"grades\": {\"math\": 95, \"science\": 88}\n}\nprint(student[\"name\"])\nprint(student[\"grades\"][\"math\"])"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'كيف تصل لقيمة في قاموس؟', 'multiple_choice',
  '["عبر مفتاحها dict[key]", "عبر موقعها الرقمي فقط", "لا يمكن الوصول لقيم القاموس", "باستخدام + فقط"]'::jsonb,
  'عبر مفتاحها dict[key]', 'القواميس تُستخدم فيها المفاتيح للوصول للقيم بدلًا من المواقع الرقمية كما في القوائم.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي دالة تحذف مفتاحًا من قاموس وتُرجع قيمته في نفس الوقت؟', 'multiple_choice',
  '["pop()", "del", "keys()", "add()"]'::jsonb,
  'pop()', 'pop(key) تحذف المفتاح المحدد وتُرجع قيمته، بعكس del التي تحذف فقط دون إرجاع شيء.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي دالة تُرجع كل الأزواج (مفتاح، قيمة) معًا من القاموس؟', 'multiple_choice',
  '["items()", "keys()", "values()", "pop()"]'::jsonb,
  'items()', 'items() تُرجع كل زوج كـTuple يحتوي المفتاح والقيمة معًا، مفيدة جدًا عند المرور بحلقة for.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nuser = {"contact": {"email": "a@x.com"}}\nprint(user["contact"]["email"])', 'predict_output',
  '["a@x.com", "{''email'': ''a@x.com''}", "contact", "خطأ"]'::jsonb,
  'a@x.com', 'المفتاح الأول contact يصل للقاموس الفرعي، والمفتاح الثاني email يصل للقيمة النهائية داخله مباشرة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 4;
