-- ============================================================
-- Eleven — Migration 0029: Chapter 12 — معاملات الدوال والقيمة الراجعة
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'دوال بعدة معاملات',
  'استقبل أكثر من قيمة في نفس الدالة.',
  '["إضافة أكثر من معامل لدالة واحدة", "فهم أن الترتيب مهم عند تمرير القيم"]'::jsonb,
  $j${
    "explanation": "يمكن لأي دالة أن تستقبل أكثر من معامل واحد، بفصلهم بفواصل داخل الأقواس عند التعريف. عند الاستدعاء، يجب تمرير قيمة لكل معامل بنفس الترتيب الذي عُرّفت به المعاملات (يُسمى هذا Positional Arguments)، وإلا ستُسند القيم لمعاملات خاطئة دون أن يظهر خطأ بالضرورة.",
    "code_examples": [
      {"code": "def introduce(name, age, city):\n    print(f\"{name}, عمره {age} سنة، من {city}\")\n\nintroduce(\"أحمد\", 25, \"القاهرة\")", "explanation": "الدالة introduce تستقبل 3 معاملات. عند الاستدعاء، تُسند \"أحمد\" لـname، و25 لـage، و\"القاهرة\" لـcity، بنفس الترتيب المُعرَّف به تمامًا."}
    ],
    "common_mistakes": [
      "تمرير القيم بترتيب خاطئ، مثل introduce(25, \"أحمد\", \"القاهرة\")، مما يُنتج نتيجة غير منطقية دون خطأ برمجي واضح.",
      "نسيان تمرير أحد المعاملات المطلوبة، مما يسبب خطأ TypeError يوضح أن معاملًا مفقودًا."
    ],
    "tips": [
      "رتّب المعاملات في التعريف بترتيب منطقي يسهل تذكره عند الاستدعاء.",
      "سنتعلم لاحقًا Keyword Arguments التي تسمح بتمرير القيم بالاسم بدل الترتيب لتفادي هذا النوع من الأخطاء."
    ],
    "challenge": {
      "prompt": "اكتب دالة add_numbers تستقبل رقمين وتطبع مجموعهما.",
      "starter_code": "def add_numbers(a, b):\n    print(a + b)\n\nadd_numbers(5, 3)\nadd_numbers(10, 20)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'الوسائط بالاسم (Keyword Arguments)',
  'مرّر القيم للدالة باسم المعامل بدل الاعتماد على الترتيب فقط.',
  '["استخدام name=value عند استدعاء دالة", "تمرير الوسائط بترتيب مختلف بأمان باستخدام الاسم"]'::jsonb,
  $j${
    "explanation": "بدلًا من الاعتماد فقط على ترتيب القيم (Positional Arguments)، يمكنك تمرير القيم صراحة باسم المعامل: function(param_name=value). هذا يسمح بتمرير القيم بأي ترتيب تريده دون قلق من الخلط، ويجعل الاستدعاء أوضح للقارئ خصوصًا مع دوال لها معاملات كثيرة.",
    "code_examples": [
      {"code": "def introduce(name, age, city):\n    print(f\"{name}, عمره {age} سنة، من {city}\")\n\nintroduce(city=\"دبي\", name=\"سارة\", age=30)", "explanation": "رغم أن الترتيب هنا مختلف تمامًا عن ترتيب التعريف (city أولًا)، تعمل Python بشكل صحيح تمامًا لأننا حددنا اسم كل معامل صراحة، فلا مجال للخلط."}
    ],
    "common_mistakes": [
      "الخلط بين اسم المعامل الفعلي في تعريف الدالة واسم مختلف عند الاستدعاء، مما يسبب خطأ TypeError.",
      "استخدام Keyword Arguments مع كل دالة حتى البسيطة جدًا، مما قد يجعل الكود أطول دون داعٍ حقيقي."
    ],
    "tips": [
      "استخدم Keyword Arguments خصوصًا مع الدوال التي لها عدة معاملات من نفس النوع (مثل أرقام) لتجنب الخلط بينها.",
      "يمكن مزج الطريقتين: بعض القيم بالترتيب وبعضها بالاسم، لكن يجب أن تأتي القيم بالترتيب أولًا قبل تلك بالاسم."
    ],
    "challenge": {
      "prompt": "استدعِ دالة introduce بترتيب معاملات مختلف تمامًا عن التعريف، باستخدام Keyword Arguments.",
      "starter_code": "def introduce(name, age, city):\n    print(f\"{name}, {age}, {city}\")\n\nintroduce(age=22, city=\"باريس\", name=\"ليلى\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'القيمة الراجعة: return',
  'اجعل الدالة تُرجع نتيجة يمكن استخدامها لاحقًا، بدل الاكتفاء بالطباعة المباشرة.',
  '["فهم الفرق الجوهري بين print() وreturn داخل دالة", "استخدام القيمة الراجعة من دالة في متغير أو تعبير آخر"]'::jsonb,
  $j${
    "explanation": "حتى الآن، دوالنا كانت تطبع النتيجة مباشرة (print) داخل الدالة نفسها. لكن هذا يحد من إعادة استخدام النتيجة لاحقًا في حسابات أخرى. الحل الأفضل غالبًا هو استخدام return لإرجاع القيمة الناتجة من الدالة إلى المكان الذي استدعاها، لتُخزَّن في متغير أو تُستخدم مباشرة في تعبير آخر — وهذا يجعل الدالة أكثر مرونة بكثير من مجرد الطباعة المباشرة.",
    "code_examples": [
      {"code": "def add(a, b):\n    return a + b\n\nresult = add(5, 3)\nprint(result)          # 8\nprint(add(2, 2) * 10)  # 40 — استخدام مباشر للناتج في تعبير آخر", "explanation": "بدل أن تطبع الدالة add النتيجة مباشرة، تُرجعها بـreturn، فيمكننا تخزينها في result لاستخدامها لاحقًا، أو حتى استخدامها مباشرة داخل عملية حسابية أخرى مثل الضرب في 10."}
    ],
    "common_mistakes": [
      "الخلط بين print() (تعرض قيمة على الشاشة فقط) وreturn (تُعيد قيمة يمكن استخدامها برمجيًا لاحقًا) — الأولى للعرض، الثانية للاستخدام البرمجي.",
      "نسيان return تمامًا، فتعود الدالة تلقائيًا بقيمة None، مما يسبب نتائج غير متوقعة عند محاولة استخدام الناتج لاحقًا."
    ],
    "tips": [
      "بمجرد تنفيذ return داخل دالة، تتوقف الدالة فورًا عن التنفيذ — أي كود بعدها في نفس الدالة لن يُنفَّذ أبدًا.",
      "القاعدة الذهبية: إذا كنت ستستخدم نتيجة الدالة لاحقًا في البرنامج، استخدم return وليس print() فقط."
    ],
    "challenge": {
      "prompt": "اكتب دالة multiply تُرجع حاصل ضرب رقمين (بدل طباعته مباشرة)، ثم استخدم الناتج في عملية حسابية أخرى.",
      "starter_code": "def multiply(a, b):\n    return a * b\n\nresult = multiply(4, 5)\nprint(result + 10)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'إرجاع أكثر من قيمة',
  'أرجع أكثر من نتيجة من نفس الدالة باستخدام Tuple ضمنيًا.',
  '["إرجاع عدة قيم مفصولة بفواصل بعد return", "فك تغليف النتائج المتعددة عند استدعاء الدالة"]'::jsonb,
  $j${
    "explanation": "يمكن لدالة أن تُرجع أكثر من قيمة واحدة، بفصل القيم بفواصل بعد return — تُغلَّف Python هذه القيم تلقائيًا في Tuple. عند استدعاء الدالة، يمكنك فك تغليف هذا الـTuple مباشرة لعدة متغيرات، تمامًا كما تعلمنا في فصل Tuples سابقًا.",
    "code_examples": [
      {"code": "def get_min_max(numbers):\n    return min(numbers), max(numbers)\n\nsmallest, largest = get_min_max([4, 9, 2, 7])\nprint(smallest, largest)", "explanation": "الدالة تُرجع قيمتين معًا (أصغر وأكبر رقم) كـTuple ضمني. عند الاستدعاء، نفك تغليف النتيجة مباشرة لمتغيرين smallest وlargest، تمامًا كأي Tuple عادي."}
    ],
    "common_mistakes": [
      "محاولة استقبال القيم المتعددة في متغير واحد فقط دون فك تغليف، فيصبح ذلك المتغير Tuple كاملًا بدل قيمة مفردة.",
      "نسيان تطابق عدد المتغيرات عند فك التغليف مع عدد القيم المُرجعة فعليًا من الدالة."
    ],
    "tips": [
      "min() وmax() دالتان جاهزتان في Python تُرجعان أصغر وأكبر قيمة من قائمة مباشرة دون كتابة حلقة يدوية.",
      "إرجاع عدة قيم مفيد جدًا عندما تحتاج لأكثر من نتيجة مرتبطة من نفس الحساب، بدل استدعاء الدالة مرتين منفصلتين."
    ],
    "challenge": {
      "prompt": "اكتب دالة get_stats تستقبل قائمة أرقام وتُرجع مجموعها ومتوسطها معًا.",
      "starter_code": "def get_stats(numbers):\n    total = sum(numbers)\n    average = total / len(numbers)\n    return total, average\n\ns, avg = get_stats([10, 20, 30])\nprint(\"المجموع:\", s)\nprint(\"المتوسط:\", avg)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'الدوال والشروط معًا',
  'استخدم if/elif/else داخل دالة لإرجاع نتائج مختلفة حسب الحالة.',
  '["دمج شروط متعددة داخل جسم دالة", "إرجاع قيم مختلفة من مسارات مختلفة داخل نفس الدالة"]'::jsonb,
  $j${
    "explanation": "من الشائع جدًا أن تحتوي الدوال على شروط if/elif/else بداخلها، حيث تُرجع كل حالة قيمة مختلفة حسب المدخلات. بمجرد الوصول لأي return داخل أي فرع من الشرط، تتوقف الدالة فورًا وتُرجع تلك القيمة تحديدًا، متجاهلة باقي الفروع الأخرى تمامًا (بنفس منطق elif الذي تعلمناه سابقًا).",
    "code_examples": [
      {"code": "def classify_age(age):\n    if age < 13:\n        return \"طفل\"\n    elif age < 20:\n        return \"مراهق\"\n    else:\n        return \"بالغ\"\n\nprint(classify_age(10))\nprint(classify_age(16))\nprint(classify_age(25))", "explanation": "الدالة تفحص العمر بالترتيب وتُرجع تصنيفًا مختلفًا لكل نطاق. كل return يُنهي تنفيذ الدالة فورًا بمجرد الوصول إليه، فلا حاجة لـelse إضافية بعد كل فرع بشكل متداخل."}
    ],
    "common_mistakes": [
      "استخدام print() بدل return داخل فروع الشرط، مما يمنع استخدام النتيجة لاحقًا برمجيًا.",
      "نسيان تغطية كل الحالات الممكنة بشرط else، مما قد يجعل الدالة تُرجع None في حالات لم تُتوقع."
    ],
    "tips": [
      "تأكد أن كل مسار ممكن داخل الدالة (كل فرع من الشرط) ينتهي بـreturn قيمة واضحة، لتفادي إرجاع None بالخطأ.",
      "هذا النمط (دالة تصنّف مدخلًا لعدة فئات) شائع جدًا وستستخدمه كثيرًا في حل المسائل البرمجية."
    ],
    "challenge": {
      "prompt": "اكتب دالة get_grade_letter تستقبل درجة وتُرجع الحرف المناسب (A, B, C, F) حسب نطاقات مناسبة.",
      "starter_code": "def get_grade_letter(score):\n    if score >= 90:\n        return \"A\"\n    elif score >= 80:\n        return \"B\"\n    elif score >= 70:\n        return \"C\"\n    else:\n        return \"F\"\n\nprint(get_grade_letter(85))"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'الدوال والحلقات معًا',
  'استخدم حلقة for أو while داخل دالة لمعالجة مجموعة من البيانات.',
  '["كتابة دالة تعالج قائمة كاملة بحلقة داخلية", "إرجاع نتيجة مبنية على معالجة تكرارية"]'::jsonb,
  $j${
    "explanation": "من أقوى استخدامات الدوال هو دمجها مع الحلقات: تستقبل الدالة قائمة أو مجموعة بيانات كمعامل، وتستخدم حلقة for أو while بداخلها لمعالجة كل عنصر، ثم تُرجع نتيجة نهائية واحدة (أو أكثر) تلخّص هذه المعالجة. هذا النمط يجمع كل ما تعلمته حتى الآن (حلقات، شروط، دوال) في أداة واحدة قوية جدًا وقابلة لإعادة الاستخدام.",
    "code_examples": [
      {"code": "def count_positive(numbers):\n    count = 0\n    for n in numbers:\n        if n > 0:\n            count += 1\n    return count\n\nresult = count_positive([-3, 5, 8, -1, 0, 12])\nprint(result)", "explanation": "الدالة تستقبل قائمة، وتستخدم نمط العدّاد بحلقة for بداخلها لحساب عدد الأرقام الموجبة فقط، ثم تُرجع النتيجة النهائية كرقم واحد مباشرة، جاهزة للاستخدام في أي مكان آخر من البرنامج."}
    ],
    "common_mistakes": [
      "وضع return داخل الحلقة نفسها بالخطأ، مما يوقف الدالة من أول دورة بدل معالجة كل العناصر.",
      "نسيان تهيئة متغير النتيجة (مثل count = 0) قبل بدء الحلقة داخل الدالة."
    ],
    "tips": [
      "تأكد أن return يأتي بعد انتهاء الحلقة كاملة (بنفس مستوى إزاحة for، وليس بداخلها) عندما تريد النتيجة النهائية الكاملة.",
      "هذا النمط -دالة تستقبل قائمة وتُرجع نتيجة ملخّصة- هو أساس تحويل كل الأنماط التي تعلمتها في فصل الحلقات (عدّاد، تجميع، بحث) لدوال قابلة لإعادة الاستخدام."
    ],
    "challenge": {
      "prompt": "اكتب دالة get_total تستقبل قائمة أرقام وتُرجع مجموعها الكلي باستخدام حلقة for (بدون استخدام sum() الجاهزة).",
      "starter_code": "def get_total(numbers):\n    total = 0\n    for n in numbers:\n        total += n\n    return total\n\nprint(get_total([10, 20, 30]))"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'استدعاء دالة داخل دالة أخرى',
  'استخدم دالة موجودة بالفعل كجزء من بناء دالة جديدة.',
  '["استدعاء دالة من داخل دالة أخرى", "بناء دوال مركّبة تعتمد على دوال مساعدة أبسط"]'::jsonb,
  $j${
    "explanation": "يمكن لأي دالة أن تستدعي دالة أخرى بداخلها، تمامًا كأي استدعاء عادي. هذا يسمح ببناء دوال أكثر تعقيدًا اعتمادًا على دوال أبسط تم بناؤها مسبقًا، بدل إعادة كتابة نفس المنطق من الصفر في كل مرة. هذا النمط أساسي جدًا في البرمجة الاحترافية: تبني \"قوالب بناء\" صغيرة، ثم تُركّب برامج أكبر منها.",
    "code_examples": [
      {"code": "def is_even(n):\n    return n % 2 == 0\n\ndef count_evens(numbers):\n    count = 0\n    for n in numbers:\n        if is_even(n):\n            count += 1\n    return count\n\nprint(count_evens([1, 2, 3, 4, 5, 6]))", "explanation": "count_evens تستدعي is_even بداخلها لكل عنصر بدل إعادة كتابة شرط n % 2 == 0 مباشرة. هذا يجعل الكود أوضح (is_even اسم يشرح نفسه) وأسهل لإعادة الاستخدام في دوال أخرى مستقبلًا."}
    ],
    "common_mistakes": [
      "تكرار نفس منطق دالة موجودة بالفعل بدل استدعائها مباشرة، مما يخالف مبدأ عدم التكرار (DRY).",
      "بناء دالة معقدة جدًا دفعة واحدة بدل تقسيمها لدوال أبسط تتعاون معًا."
    ],
    "tips": [
      "هذا النمط (دوال تستدعي دوالًا أخرى) هو أساس بناء أي برنامج كبير حقيقي — البرامج الضخمة هي في جوهرها آلاف الدوال الصغيرة المتعاونة معًا.",
      "كلما استطعت تسمية جزء من منطقك كدالة مستقلة بوضوح (مثل is_even)، فافعل ذلك — يحسّن قراءة الكود بشكل كبير."
    ],
    "challenge": {
      "prompt": "اكتب دالة is_prime بسيطة، ثم دالة أخرى count_primes تستدعيها لحساب عدد الأعداد الأولية في قائمة.",
      "starter_code": "def is_prime(n):\n    if n < 2:\n        return False\n    for i in range(2, n):\n        if n % i == 0:\n            return False\n    return True\n\ndef count_primes(numbers):\n    count = 0\n    for n in numbers:\n        if is_prime(n):\n            count += 1\n    return count\n\nprint(count_primes([2, 4, 5, 9, 11, 15]))"
    }
  }$j$::jsonb, 10, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 12)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: آلة حاسبة بالدوال',
  'ابنِ آلة حاسبة منظّمة تستخدم دالة منفصلة لكل عملية.',
  '["تنظيم برنامج كامل حول عدة دوال متعاونة", "دمج input، الشروط، والدوال في مشروع متكامل"]'::jsonb,
  $j${
    "explanation": "لنبنِ آلة حاسبة كاملة ومنظّمة: دالة منفصلة لكل عملية حسابية (جمع، طرح، ضرب، قسمة)، ودالة رئيسية تقرأ اختيار المستخدم وتستدعي الدالة المناسبة بناءً عليه. هذا المشروع يجمع كل ما تعلمناه في هذا الفصل: معاملات متعددة، return، الشروط داخل الدوال، واستدعاء دالة من دالة أخرى — في برنامج عملي كامل ومنظم بشكل احترافي.",
    "code_examples": [
      {"code": "def add(a, b):\n    return a + b\n\ndef subtract(a, b):\n    return a - b\n\ndef multiply(a, b):\n    return a * b\n\ndef divide(a, b):\n    if b == 0:\n        return \"لا يمكن القسمة على صفر\"\n    return a / b\n\nnum1 = float(input(\"الرقم الأول: \"))\nnum2 = float(input(\"الرقم الثاني: \"))\noperation = input(\"العملية (+ - * /): \")\n\nif operation == \"+\":\n    print(add(num1, num2))\nelif operation == \"-\":\n    print(subtract(num1, num2))\nelif operation == \"*\":\n    print(multiply(num1, num2))\nelif operation == \"/\":\n    print(divide(num1, num2))\nelse:\n    print(\"عملية غير معروفة\")", "explanation": "كل عملية حسابية أصبحت دالة مستقلة وواضحة المسؤولية، بما فيها التعامل الآمن مع القسمة على صفر داخل divide() نفسها. الجزء الرئيسي من البرنامج يقرأ فقط اختيار المستخدم ويستدعي الدالة المناسبة — منظم وسهل التوسعة بإضافة عمليات جديدة لاحقًا."}
    ],
    "common_mistakes": [
      "وضع كل منطق العمليات الحسابية في مكان واحد ضخم بدل تقسيمها لدوال منفصلة، مما يصعّب الصيانة لاحقًا.",
      "نسيان التعامل مع حالة القسمة على صفر بشكل خاص داخل دالة divide، مما قد يوقف البرنامج بخطأ غير متوقع."
    ],
    "tips": [
      "هذا النمط (دالة منفصلة لكل عملية + دالة أو منطق رئيسي يوجّه الاستدعاء المناسب) هو أساس تصميم برامج كبيرة كثيرة حقيقية.",
      "لاحظ كيف أن التعامل مع الخطأ (القسمة على صفر) أصبح جزءًا من الدالة نفسها بدل تعقيد الكود الرئيسي بشروط إضافية."
    ],
    "challenge": {
      "prompt": "أضف عملية خامسة للآلة الحاسبة: دالة power تحسب num1 مرفوعة للأس num2 باستخدام **.",
      "starter_code": "def power(a, b):\n    return a ** b\n\nprint(power(2, 5))\nprint(power(10, 2))"
    }
  }$j$::jsonb, 12, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'عند استدعاء دالة بمعاملات متعددة بدون تحديد الأسماء، ما الذي يحدد أي قيمة تذهب لأي معامل؟', 'multiple_choice',
  '["الترتيب", "طول القيمة", "نوع القيمة", "لا يوجد نظام محدد"]'::jsonb,
  'الترتيب', 'في حالة Positional Arguments، تُسند القيم للمعاملات بنفس الترتيب المكتوبة به عند الاستدعاء.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما ميزة استخدام Keyword Arguments؟', 'multiple_choice',
  '["يمكن تمرير القيم بأي ترتيب بأمان", "أسرع من الطريقة العادية", "يمنع استخدام return", "لا فائدة حقيقية"]'::jsonb,
  'يمكن تمرير القيم بأي ترتيب بأمان', 'تحديد اسم المعامل صراحة يجعل الترتيب غير مهم، ويقلل احتمال الخلط بين القيم.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الفرق الجوهري بين print() وreturn داخل دالة؟', 'multiple_choice',
  '["print تعرض فقط، return تُعيد قيمة قابلة للاستخدام برمجيًا", "لا فرق بينهما إطلاقًا", "return أبطأ من print", "print تُستخدم فقط خارج الدوال"]'::jsonb,
  'print تعرض فقط، return تُعيد قيمة قابلة للاستخدام برمجيًا', 'return تُرجع القيمة للمكان الذي استدعى الدالة لتُستخدم لاحقًا، بينما print() فقط تعرضها على الشاشة دون إمكانية استخدامها برمجيًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\ndef f():\n    return 1, 2\na, b = f()\nprint(a+b)', 'predict_output',
  '["3", "12", "(1, 2)", "خطأ"]'::jsonb,
  '3', 'الدالة تُرجع Tuple ضمني (1, 2)، نفك تغليفه لـa=1 وb=2، وجمعهما ينتج 3.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 4;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'بمجرد تنفيذ return داخل دالة، يتوقف تنفيذ الدالة فورًا.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'أي كود بعد return في نفس المسار لن يُنفَّذ أبدًا، لأن الدالة تنتهي فور الوصول لـreturn.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'عند دمج حلقة داخل دالة، أين يجب وضع return غالبًا لإرجاع النتيجة النهائية الكاملة؟', 'multiple_choice',
  '["بعد انتهاء الحلقة، بنفس مستوى إزاحتها", "داخل الحلقة دائمًا", "قبل بدء الحلقة", "لا يهم المكان"]'::jsonb,
  'بعد انتهاء الحلقة، بنفس مستوى إزاحتها', 'وضع return داخل الحلقة يوقف الدالة من أول دورة، بينما وضعه بعدها يضمن معالجة كل العناصر أولًا قبل إرجاع النتيجة النهائية.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'يمكن لدالة أن تستدعي دالة أخرى بداخلها.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'هذا نمط شائع وأساسي جدًا، ويسمح ببناء دوال معقدة اعتمادًا على دوال أبسط تم بناؤها مسبقًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في مشروع الآلة الحاسبة، لماذا تم التعامل مع القسمة على صفر داخل دالة divide نفسها؟', 'multiple_choice',
  '["لجعل المنطق مغلَّفًا ومسؤولية الدالة نفسها", "لأن Python تتطلب ذلك إجباريًا", "لتسريع تنفيذ البرنامج", "لا سبب حقيقي"]'::jsonb,
  'لجعل المنطق مغلَّفًا ومسؤولية الدالة نفسها', 'وضع التحقق داخل الدالة المسؤولة عن العملية يجعل الكود الرئيسي أبسط، وكل دالة تتحمل مسؤولية التعامل مع حالاتها الخاصة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 12 and l.lesson_number = 8;
