-- ============================================================
-- Eleven — Migration 0026: Chapter 10 — حلقة for والحلقات المتداخلة
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'مقدمة إلى حلقة for',
  'مرّ على كل عنصر في قائمة أو نص تلقائيًا بدون حاجة لعدّاد يدوي.',
  '["فهم الفرق بين for وwhile", "المرور على عناصر قائمة باستخدام for", "المرور على حروف نص باستخدام for"]'::jsonb,
  $j${
    "explanation": "بينما تعتمد while على شرط قد يتحقق أو لا، حلقة for مصممة خصيصًا للمرور على كل عنصر في مجموعة (قائمة، نص، Tuple، إلخ) بشكل تلقائي ومباشر، دون الحاجة لعدّاد يدوي أو شرط توقف صريح. الصيغة: for item in collection: حيث item متغير جديد يأخذ قيمة كل عنصر بالتتابع في كل دورة.",
    "code_examples": [
      {"code": "fruits = [\"apple\", \"banana\", \"cherry\"]\nfor fruit in fruits:\n    print(fruit)\n\nfor letter in \"Hi\":\n    print(letter)", "explanation": "الحلقة الأولى تمرّ على كل عنصر في fruits تلقائيًا، فتطبع كل فاكهة في سطر منفصل. الحلقة الثانية تمرّ على كل حرف في النص \"Hi\" بنفس الطريقة تمامًا، لأن النصوص أيضًا سلسلة (Sequence) قابلة للمرور عليها."}
    ],
    "common_mistakes": [
      "محاولة تعديل قيمة item ظنًا أنه سيُغيّر العنصر الأصلي في القائمة — item هو مجرد نسخة من القيمة في كل دورة وليس مرجعًا مباشرًا للتعديل.",
      "الخلط في اسم متغير الحلقة (item) مع اسم القائمة نفسها (collection)، فيصبح الكود مربكًا."
    ],
    "tips": [
      "اختر اسمًا مفردًا واضحًا لمتغير الحلقة يصف عنصرًا واحدًا، مثل fruit لعناصر fruits — يجعل الكود أسهل قراءة بكثير.",
      "for أبسط وأوضح بكثير من while عندما تعرف مسبقًا أنك تريد المرور على كل عناصر مجموعة معينة."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بأسماء 4 مدن، ومرّ عليها بحلقة for لتطبع كل مدينة مع رسالة ترحيبية.",
      "starter_code": "cities = [\"القاهرة\", \"دبي\", \"باريس\", \"طوكيو\"]\nfor city in cities:\n    print(f\"مرحبًا بك في {city}!\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'دالة range()',
  'كرّر تنفيذ كود عددًا محددًا من المرات باستخدام range() بدل قائمة جاهزة.',
  '["استخدام range(n) للتكرار من 0 حتى n-1", "استخدام range(start, end) وrange(start, end, step)"]'::jsonb,
  $j${
    "explanation": "range() دالة جاهزة تُنشئ سلسلة أرقام يمكن المرور عليها بـfor، وهي الطريقة الأكثر شيوعًا للتكرار عددًا محددًا من المرات دون الحاجة لقائمة جاهزة مسبقًا. range(n) تُنتج أرقامًا من 0 حتى n-1 (n رقم غير مشمول تمامًا مثل نهاية Slicing). range(start, end) تبدأ من start بدل الصفر. range(start, end, step) تضيف خطوة مخصصة بين كل رقم والتالي.",
    "code_examples": [
      {"code": "for i in range(5):\n    print(i)\n\nfor i in range(2, 6):\n    print(i)\n\nfor i in range(0, 10, 2):\n    print(i)", "explanation": "range(5) تُنتج 0,1,2,3,4 (خمسة أرقام، ليس 5 مشمولًا). range(2, 6) تُنتج 2,3,4,5. range(0, 10, 2) تُنتج 0,2,4,6,8 بخطوة 2 بين كل رقم والتالي."}
    ],
    "common_mistakes": [
      "توقّع أن range(5) تشمل الرقم 5 نفسه — تمامًا كنهاية Slicing، الرقم الأخير غير مشمول أبدًا.",
      "الخلط بين range(n) (من 0) وrange(start, end) (بداية مخصصة) دون تحديد أيهما تحتاج فعليًا."
    ],
    "tips": [
      "range() لا تُنشئ قائمة كاملة في الذاكرة فعليًا؛ إنها كفؤة جدًا حتى مع أعداد كبيرة جدًا من التكرارات.",
      "for i in range(len(my_list)): نمط شائع عندما تحتاج الموقع (index) وليس فقط القيمة نفسها أثناء المرور."
    ],
    "challenge": {
      "prompt": "استخدم range() لطباعة جدول ضرب العدد 5 من 1 إلى 10.",
      "starter_code": "for i in range(1, 11):\n    print(f\"5 x {i} = {5 * i}\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'for مع enumerate',
  'احصل على الموقع والقيمة معًا أثناء المرور على قائمة.',
  '["استخدام enumerate() للحصول على الموقع والقيمة معًا", "فهم لماذا enumerate أفضل من range(len(list))"]'::jsonb,
  $j${
    "explanation": "أحيانًا تحتاج أثناء المرور على قائمة لمعرفة موقع كل عنصر (index) وليس فقط قيمته. الحل الأنيق لذلك هو enumerate()، التي تُرجع زوجًا من (الموقع، القيمة) في كل دورة، ويمكنك فك تغليفه مباشرة لمتغيرين. هذا أوضح وأنظف بكثير من استخدام range(len(list)) ثم الوصول للعنصر بالفهرسة يدويًا.",
    "code_examples": [
      {"code": "fruits = [\"apple\", \"banana\", \"cherry\"]\nfor index, fruit in enumerate(fruits):\n    print(index, fruit)", "explanation": "enumerate(fruits) تُنتج أزواجًا مثل (0, 'apple'), (1, 'banana'), (2, 'cherry')، ونفك تغليف كل زوج مباشرة إلى index وfruit في نفس سطر for، مما يعطينا الموقع والقيمة معًا بأناقة."}
    ],
    "common_mistakes": [
      "استخدام range(len(list)) ثم list[i] يدويًا بدل enumerate() الأبسط والأوضح في نفس الغرض بالضبط.",
      "الخلط في ترتيب المتغيرين بعد فك التغليف — enumerate تُرجع (index, value) بهذا الترتيب دائمًا."
    ],
    "tips": [
      "enumerate() يمكن أن تبدأ من رقم غير الصفر أيضًا: enumerate(list, start=1) إن أردت ترقيمًا يبدأ من 1.",
      "استخدم enumerate() كلما احتجت الموقع والقيمة معًا؛ استخدم for value in list: العادية إن كنت تحتاج القيمة فقط."
    ],
    "challenge": {
      "prompt": "اطبع قائمة مهام مرقّمة بدءًا من 1 باستخدام enumerate(list, start=1).",
      "starter_code": "tasks = [\"قراءة\", \"رياضة\", \"برمجة\"]\nfor number, task in enumerate(tasks, start=1):\n    print(f\"{number}. {task}\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'دمج for مع if',
  'استخدم شروطًا داخل حلقة for لفلترة أو معالجة عناصر معينة فقط.',
  '["استخدام if داخل حلقة for لفلترة عناصر", "بناء قائمة جديدة تحتوي فقط عناصر مطابقة لشرط"]'::jsonb,
  $j${
    "explanation": "من أكثر الأنماط شيوعًا في البرمجة هو دمج حلقة for مع شرط if بداخلها، لمعالجة أو اختيار عناصر معينة فقط تحقق شرطًا محددًا أثناء المرور على القائمة كاملة. مثلًا: طباعة الأرقام الزوجية فقط، أو بناء قائمة جديدة تحتوي فقط العناصر المطابقة لشرط معين من قائمة أكبر.",
    "code_examples": [
      {"code": "numbers = [1, 2, 3, 4, 5, 6, 7, 8]\neven_numbers = []\n\nfor n in numbers:\n    if n % 2 == 0:\n        even_numbers.append(n)\n\nprint(even_numbers)", "explanation": "نمرّ على كل رقم في numbers، ونتحقق بـif هل هو زوجي (باقي القسمة على 2 يساوي صفر)، وإن كان كذلك نضيفه لقائمة نتيجة جديدة even_numbers بـappend(). هذا نمط \"الفلترة\" (Filtering) الأساسي جدًا في البرمجة."}
    ],
    "common_mistakes": [
      "نسيان إنشاء قائمة النتيجة الفارغة قبل الحلقة، مما يسبب خطأ عند محاولة append() إليها.",
      "استخدام append() خارج كتلة if بالخطأ، مما يضيف كل العناصر بدل العناصر المطابقة للشرط فقط."
    ],
    "tips": [
      "هذا النمط (فلترة عناصر من قائمة بشرط) هو أساس أغلب مسائل Problem Solving المتعلقة بالقوائم.",
      "انتبه جيدًا لمستوى إزاحة append() — يجب أن تكون بالضبط داخل كتلة if وليس خارجها إن أردت الفلترة الفعلية."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بدرجات طلاب، وابنِ قائمة جديدة تحتوي فقط الدرجات الناجحة (50 فأكثر).",
      "starter_code": "grades = [45, 78, 60, 30, 90, 50]\npassed = []\nfor g in grades:\n    if g >= 50:\n        passed.append(g)\nprint(passed)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'الحلقات المتداخلة',
  'ضع حلقة for داخل حلقة for أخرى للتعامل مع بيانات ثنائية الأبعاد.',
  '["فهم مفهوم Nested Loops", "المرور على قائمة متداخلة بحلقتين", "حساب عدد مرات تنفيذ الحلقة الداخلية"]'::jsonb,
  $j${
    "explanation": "الحلقة المتداخلة (Nested Loop) تعني وضع حلقة for كاملة داخل حلقة for أخرى. لكل دورة واحدة من الحلقة الخارجية، تُنفَّذ الحلقة الداخلية بالكامل من البداية للنهاية. هذا مفيد جدًا للتعامل مع بيانات ثنائية الأبعاد مثل الجداول أو الشبكات (Grid)، أو عند الحاجة لمقارنة كل عنصر بكل عنصر آخر.",
    "code_examples": [
      {"code": "for i in range(3):\n    for j in range(2):\n        print(f\"i={i}, j={j}\")", "explanation": "الحلقة الخارجية تُنفَّذ 3 مرات (i=0,1,2)، وفي كل مرة تُنفَّذ الحلقة الداخلية بالكامل مرتين (j=0,1). النتيجة الكلية: 3×2 = 6 أسطر مطبوعة، لأن كل توليفة من i وj تُنفَّذ مرة واحدة."}
    ],
    "common_mistakes": [
      "الخلط بين متغيري الحلقتين (مثل استخدام i في الحلقتين بنفس الاسم)، مما يسبب أخطاء منطقية غير واضحة.",
      "عدم إدراك أن التعقيد الزمني يتضاعف: حلقتان بـn تكرار لكل واحدة تعنيان n×n عملية إجمالية، وهو أمر مهم للانتباه إليه مع البيانات الكبيرة."
    ],
    "tips": [
      "استخدم أسماء متغيرات مختلفة وواضحة لكل حلقة (مثل row وcol) بدل i وj عند التعامل مع بيانات جدولية حقيقية.",
      "تتبع الحلقات المتداخلة يدويًا على ورقة (رسم كل تركيبة i,j) يساعد كثيرًا في فهمها في البداية."
    ],
    "challenge": {
      "prompt": "استخدم حلقتين متداخلتين لطباعة جدول ضرب مصغّر من 1 إلى 3 (كل رقم مضروبًا في كل رقم آخر).",
      "starter_code": "for i in range(1, 4):\n    for j in range(1, 4):\n        print(f\"{i} x {j} = {i * j}\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'المرور على قائمة متداخلة',
  'استخدم حلقات متداخلة للمرور على بيانات جدولية حقيقية (قائمة داخل قائمة).',
  '["المرور على قائمة متداخلة بحلقتين مناسبتين", "الوصول لكل عنصر فردي داخل بنية ثنائية الأبعاد"]'::jsonb,
  $j${
    "explanation": "تذكر أننا تعلمنا سابقًا القوائم المتداخلة (List of Lists). الآن يمكننا استخدام حلقات متداخلة للمرور على كل عنصر بداخلها بشكل منظم وتلقائي: الحلقة الخارجية تمرّ على كل قائمة فرعية (كل صف مثلًا)، والحلقة الداخلية تمرّ على كل عنصر داخل تلك القائمة الفرعية تحديدًا (كل عمود). هذا النمط أساسي جدًا للتعامل مع أي بيانات جدولية.",
    "code_examples": [
      {"code": "grid = [\n    [1, 2, 3],\n    [4, 5, 6],\n    [7, 8, 9]\n]\n\nfor row in grid:\n    for value in row:\n        print(value, end=\" \")\n    print()", "explanation": "الحلقة الخارجية for row in grid تمرّ على كل قائمة فرعية (كل صف). الحلقة الداخلية for value in row تمرّ على كل رقم داخل ذلك الصف تحديدًا وتطبعه بجانب سابقه بفضل end=\" \"، ثم print() فارغة بعد كل صف للانتقال لسطر جديد."}
    ],
    "common_mistakes": [
      "الخلط في تسمية متغيرات الحلقتين (row وvalue) بحيث يصعب تتبع أي واحد يمثل الصف وأيهما العنصر الفردي.",
      "نسيان print() الفارغة بعد الحلقة الداخلية عند الحاجة لفصل الصفوف بصريًا، فتظهر كل الأرقام في سطر واحد طويل."
    ],
    "tips": [
      "هذا النمط (حلقة خارجية للصفوف، وداخلية للأعمدة) أساس التعامل مع أي شبكة أو جدول بيانات في البرمجة، بما فيها الصور والألعاب.",
      "end=\" \" في print() مفيدة جدًا عند طباعة عناصر بجانب بعضها في نفس السطر بدل كل عنصر في سطر منفصل."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة متداخلة تمثل مصفوفة 2×2 من الأرقام، واطبع مجموع كل العناصر باستخدام حلقتين متداخلتين.",
      "starter_code": "matrix = [[1, 2], [3, 4]]\ntotal = 0\nfor row in matrix:\n    for value in row:\n        total += value\nprint(\"المجموع الكلي:\", total)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'أنماط شائعة بالحلقات',
  'تعرّف على أنماط عد وتجميع وبحث شائعة جدًا باستخدام الحلقات.',
  '["بناء نمط العدّاد (Counter Pattern)", "بناء نمط التجميع (Accumulator Pattern)", "بناء نمط البحث عن أقصى/أدنى قيمة"]'::jsonb,
  $j${
    "explanation": "توجد أنماط متكررة جدًا في حل المسائل بالحلقات يستحق تعلمها كقوالب جاهزة: نمط العدّاد (Counter) لحساب عدد عناصر تحقق شرطًا معينًا، نمط التجميع (Accumulator) لجمع أو حساب قيمة تراكمية عبر كل العناصر، ونمط البحث عن القيمة الأقصى أو الأدنى بمقارنة كل عنصر بأفضل قيمة رأيناها حتى الآن. هذه الأنماط الثلاثة تغطي جزءًا كبيرًا جدًا من مسائل البرمجة الأساسية.",
    "code_examples": [
      {"code": "numbers = [4, 9, 2, 7, 1, 9]\n\n# نمط العدّاد\ncount_above_5 = 0\nfor n in numbers:\n    if n > 5:\n        count_above_5 += 1\n\n# نمط التجميع\ntotal = 0\nfor n in numbers:\n    total += n\n\n# نمط البحث عن الأقصى\nmax_value = numbers[0]\nfor n in numbers:\n    if n > max_value:\n        max_value = n\n\nprint(count_above_5, total, max_value)", "explanation": "الأول يعدّ كم عنصرًا أكبر من 5. الثاني يجمع كل الأرقام معًا في total. الثالث يتتبع أكبر قيمة رآها حتى الآن بمقارنة كل عنصر جديد بـmax_value الحالي وتحديثه عند الحاجة."}
    ],
    "common_mistakes": [
      "نسيان تهيئة متغير العدّاد أو التجميع بقيمة ابتدائية صحيحة (0 عادة) قبل بدء الحلقة.",
      "تهيئة max_value بقيمة عشوائية بدل numbers[0]، مما قد يعطي نتيجة خاطئة إن كانت كل القيم أصغر من التهيئة الخاطئة."
    ],
    "tips": [
      "احفظ هذه الأنماط الثلاثة جيدًا؛ ستراها متكررة كثيرًا جدًا جدًا في مسائل Problem Solving القادمة.",
      "Python توفر دوالًا جاهزة تفعل هذا مباشرة أيضًا: sum() للتجميع، max()/min() لإيجاد الأقصى/الأدنى — لكن فهم كيفية بنائها يدويًا بالحلقة أساسي لفهم المنطق."
    ],
    "challenge": {
      "prompt": "استخدم نمط العدّاد لحساب كم عدد الكلمات في جملة تبدأ بحرف كبير.",
      "starter_code": "words = [\"Python\", \"is\", \"Fun\", \"and\", \"Easy\"]\ncount = 0\nfor w in words:\n    if w[0].isupper():\n        count += 1\nprint(\"عدد الكلمات التي تبدأ بحرف كبير:\", count)"
    }
  }$j$::jsonb, 10, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 10)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: طباعة أشكال بالحلقات',
  'استخدم حلقات متداخلة لرسم أشكال هندسية بسيطة بالنجوم.',
  '["دمج حلقات متداخلة مع print(end=) لرسم أشكال", "بناء مثلث من النجوم سطرًا بسطر"]'::jsonb,
  $j${
    "explanation": "من التمارين الكلاسيكية الممتعة لإتقان الحلقات المتداخلة هو رسم أشكال بسيطة بالنجوم *، مثل مثلث متدرج الحجم. هذا التمرين يجبرك على التفكير بدقة في العلاقة بين رقم الصف الخارجي وعدد النجوم في كل صف — وهي مهارة تفكير منطقي قيّمة جدًا تتجاوز مجرد الشكل الناتج نفسه.",
    "code_examples": [
      {"code": "rows = 5\nfor i in range(1, rows + 1):\n    for j in range(i):\n        print(\"*\", end=\"\")\n    print()", "explanation": "الحلقة الخارجية تمرّ على كل صف من 1 إلى 5. الحلقة الداخلية تطبع عدد نجوم يساوي رقم الصف الحالي i بالضبط (لأن range(i) تُنتج i عنصرًا). النتيجة: مثلث متدرج يبدأ بنجمة واحدة وينتهي بـ5 نجوم."}
    ],
    "common_mistakes": [
      "الخلط بين range(i) وrange(rows) في الحلقة الداخلية، مما يعطي مستطيلًا بدل مثلث متدرج.",
      "نسيان print() الفارغة بعد الحلقة الداخلية، فتظهر كل النجوم متصلة في سطر واحد بدل صفوف منفصلة."
    ],
    "tips": [
      "ارسم الشكل المطلوب يدويًا على ورقة أولًا، وحدد العلاقة الرياضية بين رقم الصف وعدد العناصر فيه قبل كتابة الكود.",
      "بعد إتقان هذا النمط، جرّب تعديله لرسم مثلث مقلوب أو مربع كتمرين إضافي لنفسك."
    ],
    "challenge": {
      "prompt": "عدّل الكود لرسم مثلث مقلوب (يبدأ بأكبر عدد نجوم وينتهي بنجمة واحدة).",
      "starter_code": "rows = 5\nfor i in range(rows, 0, -1):\n    for j in range(i):\n        print(\"*\", end=\"\")\n    print()"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'حلقة for مناسبة أكثر عندما تريد:', 'multiple_choice',
  '["المرور على كل عنصر في مجموعة معروفة", "الانتظار حتى شرط غير معروف يتحقق", "لا فرق بينها وبين while إطلاقًا", "تنفيذ كود مرة واحدة فقط"]'::jsonb,
  'المرور على كل عنصر في مجموعة معروفة', 'for مصممة خصيصًا للمرور التلقائي على عناصر مجموعة معروفة مسبقًا مثل قائمة أو نص أو range.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nfor i in range(3):\n    print(i)', 'predict_output',
  '["0 1 2", "1 2 3", "0 1 2 3", "3"]'::jsonb,
  '0 1 2', 'range(3) تُنتج 0، 1، 2 فقط (3 نفسها غير مشمولة)، فتطبع الحلقة هذه الأرقام الثلاثة كل واحد في سطر.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الذي تُرجعه enumerate() في كل دورة من حلقة for؟', 'multiple_choice',
  '["زوج من (الموقع، القيمة)", "القيمة فقط", "الموقع فقط", "قائمة كاملة"]'::jsonb,
  'زوج من (الموقع، القيمة)', 'enumerate() تُرجع (index, value) في كل دورة، ويمكن فك تغليفهما مباشرة لمتغيرين منفصلين.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'دمج if داخل for يُستخدم عادة لفلترة عناصر تحقق شرطًا معينًا فقط.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'هذا نمط أساسي جدًا: المرور على كل العناصر واختيار فقط من يحقق شرطًا معينًا لإضافته لقائمة نتيجة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 4;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'كم مرة ستُنفَّذ الحلقة الداخلية إجمالًا؟\nfor i in range(3):\n    for j in range(4):\n        pass', 'predict_output',
  '["12", "7", "3", "4"]'::jsonb,
  '12', 'الحلقة الخارجية تُنفَّذ 3 مرات، وفي كل مرة تُنفَّذ الداخلية 4 مرات كاملة، أي 3×4 = 12 مرة إجمالًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'عند المرور على قائمة متداخلة (List of Lists)، الحلقة الخارجية عادة تمرّ على:', 'multiple_choice',
  '["كل قائمة فرعية (صف)", "كل رقم منفرد مباشرة", "كل حرف في القائمة", "لا شيء تلقائيًا"]'::jsonb,
  'كل قائمة فرعية (صف)', 'الحلقة الخارجية تمرّ على كل قائمة فرعية (صف)، والحلقة الداخلية تمرّ على عناصر تلك القائمة الفرعية تحديدًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في نمط العدّاد (Counter Pattern)، ما القيمة الابتدائية الصحيحة عادة للمتغير؟', 'multiple_choice',
  '["0", "1", "قيمة عشوائية", "لا حاجة لتهيئته"]'::jsonb,
  '0', 'يجب تهيئة متغير العدّاد بـ0 قبل بدء الحلقة، حتى يبدأ العدّ من الصفر بشكل صحيح.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'لرسم مثلث متدرج بالنجوم حيث الصف i يحتوي i نجمة، ما الحلقة الداخلية الصحيحة؟', 'multiple_choice',
  '["for j in range(i):", "for j in range(rows):", "for j in range(1):", "for j in i:"]'::jsonb,
  'for j in range(i):', 'range(i) تُنتج بالضبط i عنصرًا، فتطبع i نجمة في الصف رقم i، مما يخلق الشكل المتدرج المطلوب.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 10 and l.lesson_number = 8;
