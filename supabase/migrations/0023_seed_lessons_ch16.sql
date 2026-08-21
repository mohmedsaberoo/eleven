-- ============================================================
-- Eleven — Migration 0023: Chapter 16 — المجموعات (Sets)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'ما هي المجموعة (Set)؟',
  'تعرّف على هيكل بيانات يخزّن قيمًا فريدة فقط بدون أي تكرار.',
  '["فهم أن Set لا يقبل عناصر مكررة", "إنشاء Set والتعامل معه", "فهم أن Set غير مرتب (Unordered)"]'::jsonb,
  $j${
    "explanation": "المجموعة (Set) هي حاوية تخزّن قيمًا فريدة فقط — إن حاولت إضافة قيمة موجودة مسبقًا، تُتجاهل تلقائيًا دون أي خطأ. تُنشأ بأقواس معقوفة {} (مثل القواميس التي سنراها لاحقًا، لكن بدون أزواج مفتاح-قيمة). ميزة مهمة: الـ Set غير مرتب (Unordered)، أي لا يوجد فهرسة (Indexing) للوصول لعنصر بموقعه كما في القوائم؛ الترتيب الداخلي قد يختلف عن ترتيب الإدخال.",
    "code_examples": [
      {"code": "numbers = {1, 2, 3, 2, 1}\nprint(numbers)     # {1, 2, 3} — التكرارات حُذفت تلقائيًا\n\nfruits = set()\nfruits.add(\"apple\")\nfruits.add(\"banana\")\nfruits.add(\"apple\")   # تُتجاهل لأنها مكررة\nprint(fruits)       # {'apple', 'banana'}", "explanation": "رغم كتابة 1 و2 مرتين في numbers، خزّنت Python كل قيمة مرة واحدة فقط تلقائيًا. لإنشاء Set فارغ يجب استخدام set() وليس {} (لأن {} فارغة تعني Dictionary فارغ كما سنرى لاحقًا)."}
    ],
    "common_mistakes": [
      "استخدام {} لإنشاء Set فارغ — هذا ينشئ Dictionary فارغًا بالخطأ؛ يجب استخدام set() صراحة.",
      "محاولة الوصول لعنصر بموقعه مثل fruits[0] — Sets لا تدعم الفهرسة إطلاقًا لأنها غير مرتبة."
    ],
    "tips": [
      "Sets مثالية جدًا عندما تريد التأكد من عدم وجود تكرار في بياناتك تلقائيًا دون كتابة كود إضافي.",
      "تحويل قائمة تحتوي تكرارات إلى Set ثم إعادتها لقائمة، طريقة سريعة وشائعة جدًا لإزالة التكرارات: list(set(my_list))."
    ],
    "challenge": {
      "prompt": "أنشئ Set من الأرقام الزوجية من 2 إلى 10، وحاول إضافة رقم مكرر لترى أنه يُتجاهل.",
      "starter_code": "even_numbers = {2, 4, 6, 8, 10}\neven_numbers.add(4)\nprint(even_numbers)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'عمليات المجموعات: union, intersection',
  'استخدم عمليات المجموعات الرياضية الكلاسيكية بسهولة تامة.',
  '["استخدام union() لدمج مجموعتين", "استخدام intersection() لإيجاد العناصر المشتركة", "استخدام difference() لإيجاد الفرق بينهما"]'::jsonb,
  $j${
    "explanation": "تدعم Sets في Python عمليات المجموعات الرياضية المألوفة مباشرة: union() (الاتحاد) يدمج كل عناصر مجموعتين في مجموعة واحدة بدون تكرار. intersection() (التقاطع) يُرجع فقط العناصر المشتركة بين المجموعتين. difference() (الفرق) يُرجع عناصر المجموعة الأولى التي لا توجد في الثانية. هذه العمليات مفيدة جدًا في مسائل مقارنة البيانات.",
    "code_examples": [
      {"code": "python_students = {\"Ali\", \"Sara\", \"Omar\"}\njs_students = {\"Sara\", \"Mona\", \"Ali\"}\n\nprint(python_students.union(js_students))          # كل الطلاب بدون تكرار\nprint(python_students.intersection(js_students))    # الطلاب المشتركون\nprint(python_students.difference(js_students))      # طلاب Python فقط دون JS", "explanation": "union() تجمع كل الأسماء الفريدة من المجموعتين معًا. intersection() تُرجع فقط من يدرس الاثنين معًا (Ali وSara). difference() تُرجع من يدرس Python فقط وليس JS (Omar)."}
    ],
    "common_mistakes": [
      "الخلط بين intersection() (المشترك) وdifference() (الموجود في الأولى فقط دون الثانية) — لهما معنى معاكس تقريبًا.",
      "توقّع ترتيب معين في نتيجة هذه العمليات — تذكّر أن Sets غير مرتبة أصلًا."
    ],
    "tips": [
      "يمكن أيضًا استخدام رموز مختصرة: | للاتحاد، & للتقاطع، - للفرق، بدلًا من كتابة اسم الدالة كاملًا.",
      "هذه العمليات مفيدة جدًا في مسائل مثل \"أوجد العناصر المشتركة بين قائمتين\" أو \"أوجد الفرق بين مجموعتي بيانات\"."
    ],
    "challenge": {
      "prompt": "أنشئ مجموعتين لهوايات شخصين، واطبع الهوايات المشتركة بينهما فقط باستخدام intersection().",
      "starter_code": "person1_hobbies = {\"قراءة\", \"سباحة\", \"برمجة\"}\nperson2_hobbies = {\"رياضة\", \"برمجة\", \"طبخ\"}\ncommon = person1_hobbies.intersection(person2_hobbies)\nprint(\"هوايات مشتركة:\", common)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'إزالة التكرارات بسرعة',
  'استخدم Sets كأداة عملية سريعة لتنظيف البيانات من التكرار.',
  '["تحويل قائمة تحتوي تكرارًا إلى بيانات فريدة", "فهم لماذا Sets أسرع للبحث من القوائم"]'::jsonb,
  $j${
    "explanation": "من أكثر الاستخدامات العملية شيوعًا لـ Sets هو إزالة التكرار من قائمة بسرعة وبساطة: تحويل القائمة إلى set() يحذف كل التكرارات تلقائيًا، ثم يمكنك تحويلها مرة أخرى لقائمة إن أردت الحفاظ على شكل List. ميزة إضافية مهمة: البحث عن قيمة داخل Set أسرع بكثير من البحث في قائمة كبيرة، خصوصًا مع البيانات الضخمة.",
    "code_examples": [
      {"code": "emails = [\"a@x.com\", \"b@x.com\", \"a@x.com\", \"c@x.com\", \"b@x.com\"]\nunique_emails = list(set(emails))\nprint(len(emails))          # 5 (مع التكرار)\nprint(len(unique_emails))    # 3 (فريدة فقط)", "explanation": "قائمة emails تحتوي بريدين مكررين. تحويلها لـ set() ثم إعادتها لقائمة يحذف التكرار تلقائيًا، فيصبح العدد النهائي 3 عناوين فريدة فقط بدل 5."}
    ],
    "common_mistakes": [
      "توقّع أن list(set(my_list)) يحافظ على الترتيب الأصلي — لا يوجد ضمان لذلك لأن Sets غير مرتبة.",
      "استخدام هذا الأسلوب مع بيانات تحتاج ترتيبها الأصلي محفوظًا بدقة دون تفكير في البديل المناسب."
    ],
    "tips": [
      "list(set(items)) هي طريقة سريعة وشائعة جدًا جدًا لإزالة التكرار، احفظها في ذاكرتك.",
      "إن احتجت الحفاظ على الترتيب الأصلي مع إزالة التكرار، الحل الأدق هو استخدام حلقة for مع Set مساعد كما فعلنا في تمرين سابق."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة أرقام تحتوي تكرارًا، واطبع عدد القيم الفريدة فيها فقط باستخدام len(set(...)).",
      "starter_code": "numbers = [1, 2, 2, 3, 3, 3, 4]\nunique_count = len(set(numbers))\nprint(\"عدد القيم الفريدة:\", unique_count)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'تمارين على Sets',
  'طبّق Sets في مسألة عملية مقارنة بيانات حقيقية.',
  '["استخدام Sets لمقارنة مجموعتي بيانات", "دمج Sets مع القوائم والتحويل بينهما"]'::jsonb,
  $j${
    "explanation": "لنستخدم Sets في مسألة عملية: مقارنة قائمتي تسوق لشخصين لمعرفة ما يحتاجان شراءه معًا وما يحتاج كل واحد بمفرده. هذا مثال واقعي رائع يوضح قوة عمليات المجموعات (union, intersection, difference) في حل مشكلة حقيقية بسطور قليلة جدًا.",
    "code_examples": [
      {"code": "list1 = [\"milk\", \"bread\", \"eggs\"]\nlist2 = [\"bread\", \"cheese\", \"eggs\", \"butter\"]\n\nset1 = set(list1)\nset2 = set(list2)\n\nprint(\"مشترك:\", set1.intersection(set2))\nprint(\"يحتاجه الأول فقط:\", set1.difference(set2))\nprint(\"يحتاجه الثاني فقط:\", set2.difference(set1))\nprint(\"كل المطلوب معًا:\", set1.union(set2))", "explanation": "نحوّل كل قائمة تسوق إلى Set أولًا، ثم نستخدم عمليات المجموعات الثلاث لمعرفة العناصر المشتركة، وما يخص كل شخص وحده، وكل شيء مطلوب في النهاية بدون تكرار."}
    ],
    "common_mistakes": [
      "محاولة استخدام عمليات المجموعات مباشرة على القوائم دون تحويلها لـ Sets أولًا، مما يسبب خطأ.",
      "الخلط بين set1.difference(set2) وset2.difference(set1) — النتيجة مختلفة تمامًا حسب اتجاه المقارنة."
    ],
    "tips": [
      "هذا النمط (تحويل قائمتين لـSets ثم مقارنتهما) شائع جدًا في تطبيقات حقيقية مثل مقارنة قوائم أصدقاء أو صلاحيات مستخدمين.",
      "تذكّر أن نتيجة كل هذه العمليات هي Set جديد، ويمكنك تحويله لقائمة لاحقًا إن احتجت ترتيبًا أو فهرسة."
    ],
    "challenge": {
      "prompt": "أنشئ مجموعتين لمهارات شخصين، واطبع المهارات التي يمتلكها الشخص الأول فقط ولا يمتلكها الثاني.",
      "starter_code": "person1_skills = {\"Python\", \"SQL\", \"Design\"}\nperson2_skills = {\"Python\", \"JavaScript\"}\nonly_person1 = person1_skills.difference(person2_skills)\nprint(only_person1)"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint({1, 2, 2, 3})', 'predict_output',
  '["{1, 2, 3}", "{1, 2, 2, 3}", "[1, 2, 3]", "خطأ"]'::jsonb,
  '{1, 2, 3}', 'المجموعات تخزّن كل قيمة مرة واحدة فقط تلقائيًا، فتُحذف التكرارات دون أي كود إضافي.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي دالة تُرجع العناصر المشتركة فقط بين مجموعتين؟', 'multiple_choice',
  '["intersection()", "union()", "difference()", "add()"]'::jsonb,
  'intersection()', 'intersection() (التقاطع) تُرجع فقط العناصر الموجودة في كلتا المجموعتين معًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الطريقة الشائعة لإزالة التكرار من قائمة بسرعة؟', 'multiple_choice',
  '["list(set(my_list))", "my_list.remove_duplicates()", "sorted(my_list)", "my_list.unique()"]'::jsonb,
  'list(set(my_list))', 'تحويل القائمة لـSet يحذف التكرار تلقائيًا، ثم إعادة تحويلها لقائمة يعطي النتيجة المطلوبة بسطر واحد.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'تدعم Sets الفهرسة المباشرة مثل set[0] للوصول لعنصر بموقعه.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'Sets غير مرتبة (Unordered) ولا تدعم الفهرسة إطلاقًا، على عكس القوائم والـTuples.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 8;
