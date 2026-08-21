-- ============================================================
-- Eleven — Migration 0027: Chapter 11 — break/continue ومقدمة الدوال
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'break — الخروج المبكر من الحلقة',
  'أوقف تنفيذ الحلقة فورًا بمجرد تحقق شرط معين، حتى لو لم تنتهِ طبيعيًا.',
  '["فهم متى نحتاج للخروج المبكر من حلقة", "استخدام break داخل for وwhile"]'::jsonb,
  $j${
    "explanation": "break هي كلمة مفتاحية تُوقف تنفيذ الحلقة (سواء for أو while) فورًا وبالكامل، بمجرد الوصول إليها، بغض النظر عمّا تبقى من عناصر أو دورات. تُستخدم عادة داخل شرط if للخروج من الحلقة بمجرد تحقق حالة معينة، مثل العثور على قيمة نبحث عنها، فلا داعي لمتابعة فحص باقي العناصر.",
    "code_examples": [
      {"code": "numbers = [4, 9, 15, 7, 22]\nfor n in numbers:\n    if n > 10:\n        print(\"وجدت رقمًا أكبر من 10:\", n)\n        break\n    print(\"فحص:\", n)", "explanation": "تفحص الحلقة كل رقم بالترتيب. عند الوصول لـ15 (أول رقم أكبر من 10)، تُطبع رسالة الإيجاد ثم break تُوقف الحلقة فورًا، فلا تُفحص 7 و22 إطلاقًا رغم وجودهما في القائمة."}
    ],
    "common_mistakes": [
      "توقّع أن break تخرج فقط من الشرط if وليس من الحلقة كاملة — في الحقيقة تخرج من الحلقة المحيطة بها بالكامل.",
      "استخدام break في مكان لا يحتاج فعليًا للتوقف المبكر، مما يفوّت معالجة عناصر أخرى كان يجب فحصها."
    ],
    "tips": [
      "break مفيدة جدًا في البحث: بمجرد إيجاد ما تبحث عنه، لا داعي لإهدار وقت فحص باقي العناصر.",
      "في حلقات متداخلة، break تخرج فقط من الحلقة الداخلية التي تحتويها مباشرة، وليس من كل الحلقات الخارجية أيضًا."
    ],
    "challenge": {
      "prompt": "ابحث عن أول رقم يقبل القسمة على 7 في قائمة، واستخدم break للتوقف فور إيجاده.",
      "starter_code": "numbers = [3, 8, 14, 21, 30]\nfor n in numbers:\n    if n % 7 == 0:\n        print(\"وجدت:\", n)\n        break"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'continue — تخطي دورة واحدة',
  'تجاوز باقي كود الدورة الحالية والانتقال مباشرة للعنصر التالي.',
  '["فهم الفرق بين break وcontinue", "استخدام continue لتخطي عناصر معينة أثناء المعالجة"]'::jsonb,
  $j${
    "explanation": "continue تختلف عن break: بدلًا من إيقاف الحلقة بالكامل، continue تتخطى فقط باقي الكود في الدورة الحالية وتنتقل مباشرة لبدء الدورة التالية. تُستخدم عندما تريد \"تجاهل\" عنصر معين لا يحقق شرطًا معينًا، دون إيقاف معالجة بقية العناصر.",
    "code_examples": [
      {"code": "numbers = [1, 2, 3, 4, 5, 6]\nfor n in numbers:\n    if n % 2 != 0:\n        continue\n    print(n)", "explanation": "عند كل رقم فردي، يتحقق الشرط n % 2 != 0 فتُنفَّذ continue فتنتقل الحلقة مباشرة للرقم التالي متجاهلة print(n) لهذه الدورة تحديدًا. النتيجة: تُطبع فقط الأرقام الزوجية 2، 4، 6."}
    ],
    "common_mistakes": [
      "الخلط بين break (توقف كامل) وcontinue (تخطي دورة واحدة فقط ومتابعة الباقي) — هما سلوكان مختلفان تمامًا.",
      "وضع كود مهم بعد continue داخل نفس الدورة، ظنًا أنه سيُنفَّذ — لن يُنفَّذ أبدًا لأن continue تتجاوز كل ما بعدها في تلك الدورة."
    ],
    "tips": [
      "فكّر في continue كـ\"تخطَّ هذا العنصر وانتقل للتالي\"، وbreak كـ\"توقف تمامًا عن كل شيء\".",
      "continue مفيدة جدًا لتبسيط الكود بدل استخدام شروط if/else متداخلة معقدة لتجاهل حالات معينة."
    ],
    "challenge": {
      "prompt": "اطبع كل الأرقام من 1 إلى 10 باستثناء المضاعفات الخاصة بـ3، باستخدام continue.",
      "starter_code": "for n in range(1, 11):\n    if n % 3 == 0:\n        continue\n    print(n)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'else مع الحلقات',
  'استخدم else مع for أو while لتنفيذ كود فقط إذا اكتملت الحلقة بدون break.',
  '["فهم ميزة else الخاصة بالحلقات في Python", "التمييز بين اكتمال الحلقة طبيعيًا والخروج منها بـ break"]'::jsonb,
  $j${
    "explanation": "ميزة فريدة في Python: يمكن إضافة else بعد حلقة for أو while، وتُنفَّذ فقط إذا اكتملت الحلقة بالكامل دون أي break. إذا حدث break في أي لحظة، لن تُنفَّذ else إطلاقًا. هذا النمط مفيد جدًا في حالات البحث: \"إن لم أجد ما أبحث عنه بعد فحص كل العناصر، افعل كذا\".",
    "code_examples": [
      {"code": "numbers = [2, 4, 6, 8]\nfor n in numbers:\n    if n % 2 != 0:\n        print(\"وجدت رقمًا فرديًا!\")\n        break\nelse:\n    print(\"كل الأرقام زوجية\")", "explanation": "بما أن كل الأرقام في القائمة زوجية، لن يتحقق شرط if أبدًا فلن تُنفَّذ break، وبالتالي تكتمل الحلقة طبيعيًا وتُنفَّذ else فتُطبع \"كل الأرقام زوجية\". لو كان هناك رقم فردي واحد، كانت ستُنفَّذ break ولن تُنفَّذ else إطلاقًا."}
    ],
    "common_mistakes": [
      "الاعتقاد أن else هنا تعمل مثل else العادية مع if (أي \"إن لم يتحقق الشرط\") — هي في الحقيقة مرتبطة باكتمال الحلقة بالكامل دون break.",
      "عدم استخدام هذه الميزة رغم أنها مفيدة جدًا، والاعتماد بدلًا منها على متغير bool إضافي (وهو حل صحيح أيضًا لكنه أطول قليلًا)."
    ],
    "tips": [
      "هذه الميزة (for...else) خاصة نسبيًا بـPython وقد لا تجدها بنفس الشكل في لغات أخرى، فهي جديرة بالتذكر.",
      "استخدمها تحديدًا في سيناريوهات البحث: حلقة تبحث عن شيء، وbreak عند الإيجاد، وelse لحالة \"لم يُوجد\"."
    ],
    "challenge": {
      "prompt": "ابحث في قائمة أرقام عن قيمة أكبر من 100؛ إن لم تجدها، اطبع رسالة عبر else الحلقة.",
      "starter_code": "numbers = [10, 25, 47, 63]\nfor n in numbers:\n    if n > 100:\n        print(\"وجدت رقمًا كبيرًا:\", n)\n        break\nelse:\n    print(\"لا يوجد رقم أكبر من 100\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'مراجعة شاملة على الحلقات',
  'وحّد كل ما تعلمته عن for وwhile وbreak وcontinue في تمرين متكامل.',
  '["دمج كل أدوات التحكم بالحلقات في مسألة واحدة", "بناء منطق بحث وفلترة معقد قليلًا"]'::jsonb,
  $j${
    "explanation": "لنطبّق كل ما تعلمناه عن الحلقات في مسألة متكاملة: البحث عن أول عدد أولي (Prime) في قائمة أرقام، مع تخطي الأرقام السالبة تمامًا (باستخدام continue) والتوقف فور إيجاد أول عدد أولي (باستخدام break). هذا التمرين يدمج for، if، continue، وbreak معًا في منطق واحد متماسك.",
    "code_examples": [
      {"code": "numbers = [-4, 8, -2, 9, 11, 15]\n\nfor n in numbers:\n    if n < 0:\n        continue\n    if n < 2:\n        continue\n    is_prime = True\n    for i in range(2, n):\n        if n % i == 0:\n            is_prime = False\n            break\n    if is_prime:\n        print(\"أول عدد أولي وُجد:\", n)\n        break", "explanation": "الحلقة الخارجية تتخطى الأرقام السالبة والأصغر من 2 بـcontinue فورًا. لكل رقم متبقٍ، نفحص أوليته بحلقة داخلية منفصلة (تشبه ما رأيناه في مسألة سابقة). بمجرد إيجاد أول عدد أولي، نطبعه ونخرج من الحلقة الخارجية بـbreak."}
    ],
    "common_mistakes": [
      "الخلط بين break الخاصة بالحلقة الداخلية (فحص الأولية) وbreak الخاصة بالحلقة الخارجية (إيجاد أول نتيجة) — لكل واحدة نطاقها الخاص.",
      "نسيان أن continue تنتقل للعنصر التالي في نفس الحلقة التي كُتبت بداخلها فقط، وليس أي حلقة أخرى."
    ],
    "tips": [
      "عند التعامل مع حلقات متداخلة مع break/continue، تتبع بعناية أي حلقة (الداخلية أم الخارجية) يتأثر بكل أمر تحكم.",
      "هذا المستوى من الدمج (for + if + continue + break + حلقة متداخلة) يمثل تقريبًا ذروة تعقيد الحلقات الأساسية التي ستحتاجها كمبتدئ."
    ],
    "challenge": {
      "prompt": "ابحث في قائمة نصوص عن أول كلمة طولها أكبر من 5 أحرف، متجاهلًا الكلمات الفارغة تمامًا.",
      "starter_code": "words = [\"\", \"hi\", \"python\", \"go\", \"programming\"]\nfor w in words:\n    if w == \"\":\n        continue\n    if len(w) > 5:\n        print(\"وجدت:\", w)\n        break"
    }
  }$j$::jsonb, 10, 15
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'لماذا نحتاج الدوال؟',
  'اكتشف مشكلة تكرار الكود، وكيف تحلها الدوال (Functions) بأناقة.',
  '["فهم مشكلة تكرار الكود دون دوال", "فهم الفائدة الأساسية للدوال: إعادة الاستخدام"]'::jsonb,
  $j${
    "explanation": "تخيّل أنك تحتاج لحساب مساحة مستطيل في 5 أماكن مختلفة من برنامجك — بدون دوال، ستضطر لتكرار نفس معادلة الحساب (الطول × العرض) في كل مكان يدويًا. هذا يجعل الكود طويلًا، ويصعّب التعديل لاحقًا (لو غيّرت المعادلة، يجب تعديلها في كل مكان تكرر فيه). الدالة (Function) تحل هذه المشكلة: تكتب الكود مرة واحدة فقط، وتعطيه اسمًا، ثم تستدعيه (Call) بهذا الاسم في أي مكان تحتاجه لاحقًا.",
    "code_examples": [
      {"code": "print(\"مساحة 1:\", 4 * 5)\nprint(\"مساحة 2:\", 6 * 3)\nprint(\"مساحة 3:\", 10 * 2)\n\n# لاحظ أن كل سطر أعاد كتابة نفس منطق الضرب يدويًا — سنحل هذا بالدوال في الدرس القادم مباشرة", "explanation": "هذا الكود يعمل، لكنه يكرر نفس فكرة \"الطول × العرض\" ثلاث مرات. لو أردنا تعديل الحساب (مثلًا إضافة تقريب)، يجب تعديله في 3 أماكن منفصلة يدويًا — وهذا بالضبط ما تحله الدوال."}
    ],
    "common_mistakes": [
      "الاستمرار في تكرار نفس الكود يدويًا في عدة أماكن دون التفكير في دالة، مما يجعل الصيانة لاحقًا صعبة ومعرضة للأخطاء.",
      "الاعتقاد أن الدوال معقدة أو للمحترفين فقط — هي في الحقيقة أداة أساسية تبسّط الكود من أول درس فيها."
    ],
    "tips": [
      "قاعدة DRY الشهيرة في البرمجة: Don't Repeat Yourself (لا تكرر نفسك) — الدوال هي الأداة الأساسية لتطبيق هذا المبدأ.",
      "كلما وجدت نفسك تنسخ وتلصق نفس الكود في أكثر من مكان، فكّر فورًا: هل يجب أن تكون هذه دالة؟"
    ],
    "challenge": {
      "prompt": "لاحظ التكرار في الكود التالي (حساب مربع 3 أرقام مختلفة)، وفكّر كيف يمكن تحسينه (سنطبّق الحل فعليًا في الدرس القادم).",
      "starter_code": "print(4 * 4)\nprint(7 * 7)\nprint(10 * 10)"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'تعريف واستدعاء دالة',
  'اكتب أول دالة خاصة بك باستخدام def، ثم استدعِها.',
  '["استخدام def لتعريف دالة جديدة", "استدعاء الدالة بكتابة اسمها متبوعًا بأقواس"]'::jsonb,
  $j${
    "explanation": "لتعريف دالة جديدة، تستخدم الكلمة المفتاحية def متبوعة باسم الدالة ثم أقواس () ثم نقطتين :، وبعدها كتلة الكود التي ستُنفَّذ في كل مرة تُستدعى فيها الدالة (بنفس مبدأ المسافة البادئة الذي تعلمناه مع if). بعد التعريف، تستدعي (Call) الدالة ببساطة بكتابة اسمها متبوعًا بأقواس ()، وحينها فقط يُنفَّذ الكود بداخلها.",
    "code_examples": [
      {"code": "def greet():\n    print(\"مرحبًا بك في Eleven!\")\n    print(\"استمتع بتعلم Python\")\n\ngreet()\ngreet()\nprint(\"سطر بعد استدعاء الدالة\")", "explanation": "def greet(): تُعرّف الدالة لكن لا تُنفّذها بعد (مجرد تعريف، مثل كتابة وصفة دون طبخها). فقط عند كتابة greet() فعليًا يُنفَّذ الكود بداخلها. استدعيناها مرتين، فطُبعت الرسالتان مرتين كاملتين."}
    ],
    "common_mistakes": [
      "نسيان الأقواس () عند استدعاء الدالة، مثل كتابة greet بدل greet() — هذا لا يُنفّذ الدالة إطلاقًا.",
      "نسيان النقطتين : بعد الأقواس في سطر def، تمامًا كخطأ شائع في if."
    ],
    "tips": [
      "تعريف الدالة (def) يجب أن يأتي قبل أول استدعاء لها في الكود، وإلا ستحصل على خطأ NameError.",
      "اختر أسماء دوال تصف بوضوح ماذا تفعل الدالة، عادة بصيغة فعل مثل greet أو calculate_total."
    ],
    "challenge": {
      "prompt": "اكتب دالة اسمها print_divider تطبع خطًا فاصلًا من 20 شرطة، ثم استدعِها 3 مرات.",
      "starter_code": "def print_divider():\n    print(\"-\" * 20)\n\nprint_divider()\nprint(\"محتوى بين الفواصل\")\nprint_divider()"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'دوال بمعامل واحد',
  'اجعل دالتك تستقبل قيمة من الخارج لتتعامل معها بمرونة.',
  '["إضافة معامل (Parameter) لدالة", "تمرير قيمة (Argument) عند الاستدعاء"]'::jsonb,
  $j${
    "explanation": "الدالة greet() في الدرس السابق ثابتة تمامًا: تطبع نفس الرسالة دائمًا بغض النظر عن أي شيء. لجعل الدوال أكثر مرونة وفائدة، يمكنك إضافة معامل (Parameter) داخل الأقواس عند التعريف، ليكون بمثابة \"فراغ\" يُملأ بقيمة مختلفة في كل استدعاء. عند الاستدعاء، تمرر قيمة فعلية (تُسمى Argument) داخل الأقواس لتُستخدم بدل ذلك المعامل داخل الدالة.",
    "code_examples": [
      {"code": "def greet(name):\n    print(f\"مرحبًا بك يا {name}!\")\n\ngreet(\"سارة\")\ngreet(\"محمد\")", "explanation": "name هو معامل (Parameter) — متغير محلي خاص بالدالة يستقبل قيمة عند كل استدعاء. \"سارة\" و\"محمد\" هما الوسيطان (Arguments) الفعليان الممرران في كل استدعاء، فتطبع الدالة رسالة مخصصة لكل اسم دون تكرار الكود."}
    ],
    "common_mistakes": [
      "استدعاء دالة تتطلب معاملًا دون تمرير أي قيمة، مثل greet() بدل greet(\"سارة\")، مما يسبب خطأ TypeError.",
      "الخلط بين مصطلحي Parameter (في التعريف) وArgument (في الاستدعاء) — الفرق دقيق لكنه مهم للتواصل الدقيق مع مبرمجين آخرين."
    ],
    "tips": [
      "يمكن أن يحمل المعامل أي اسم تختاره؛ اختر اسمًا واضحًا يصف ماذا يمثل (مثل name وليس x).",
      "المعامل هو متغير محلي فقط داخل الدالة؛ لا يمكن الوصول إليه من خارجها (سنتعمق في هذا في فصل النطاق لاحقًا)."
    ],
    "challenge": {
      "prompt": "اكتب دالة اسمها square تستقبل رقمًا وتطبع مربعه.",
      "starter_code": "def square(number):\n    print(number * number)\n\nsquare(4)\nsquare(7)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 11)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: دوال مساعدة',
  'ابنِ مجموعة دوال صغيرة مفيدة تعيد استخدامها معًا.',
  '["كتابة أكثر من دالة في نفس البرنامج", "استدعاء الدوال مع قيم مختلفة لأغراض متنوعة"]'::jsonb,
  $j${
    "explanation": "لنطبّق ما تعلمناه ببناء مجموعة صغيرة من \"الدوال المساعدة\" (Helper Functions) المستقلة، كل واحدة تقوم بمهمة بسيطة ومحددة، ثم نستخدمها معًا. هذا النمط -تقسيم برنامج كبير لدوال صغيرة، كل واحدة بمسؤولية واحدة واضحة- هو أساس كتابة كود منظم واحترافي، وسنبني عليه أكثر في الفصول القادمة.",
    "code_examples": [
      {"code": "def print_welcome(name):\n    print(f\"أهلًا بك، {name}!\")\n\ndef print_stars(count):\n    print(\"*\" * count)\n\ndef print_goodbye(name):\n    print(f\"إلى اللقاء يا {name}، اعتنِ بنفسك\")\n\nprint_welcome(\"أحمد\")\nprint_stars(15)\nprint_goodbye(\"أحمد\")", "explanation": "ثلاث دوال مستقلة، كل واحدة بمسؤولية واحدة واضحة (ترحيب، طباعة فاصل، وداع). استدعيناها بالترتيب لبناء \"تجربة\" متكاملة، لكن كل دالة تبقى مستقلة ويمكن إعادة استخدامها في أي سياق آخر بسهولة."}
    ],
    "common_mistakes": [
      "بناء دالة واحدة ضخمة تفعل كل شيء معًا بدل تقسيمها لدوال أصغر ذات مسؤولية واحدة واضحة لكل منها.",
      "تكرار نفس منطق الكود داخل أكثر من دالة بدل استخراجه لدالة مساعدة مشتركة يمكن استدعاؤها من الجميع."
    ],
    "tips": [
      "قاعدة جيدة: كل دالة يجب أن \"تفعل شيئًا واحدًا\" وتفعله جيدًا، بدل أن تكون متعددة الأغراض ومعقدة.",
      "سنتعلم في الدروس القادمة كيف تُرجع الدوال قيمًا (return) بدل الاكتفاء بالطباعة المباشرة، مما يفتح إمكانيات أكبر بكثير."
    ],
    "challenge": {
      "prompt": "اكتب دالتين: واحدة تطبع عنوانًا بخط فاصل حوله، وأخرى تطبع قائمة عناصر مرقّمة، ثم استخدمهما معًا.",
      "starter_code": "def print_title(title):\n    print(\"=\" * 20)\n    print(title)\n    print(\"=\" * 20)\n\ndef print_numbered_list(items):\n    for i, item in enumerate(items, start=1):\n        print(f\"{i}. {item}\")\n\nprint_title(\"قائمة التسوق\")\nprint_numbered_list([\"تفاح\", \"خبز\", \"حليب\"])"
    }
  }$j$::jsonb, 11, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا تفعل break داخل حلقة؟', 'multiple_choice',
  '["تُوقف الحلقة بالكامل فورًا", "تتخطى دورة واحدة فقط", "تعيد تشغيل الحلقة من البداية", "لا تفعل شيئًا"]'::jsonb,
  'تُوقف الحلقة بالكامل فورًا', 'break تخرج من الحلقة المحيطة بها بالكامل فور الوصول إليها، بغض النظر عن العناصر المتبقية.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nfor n in [1,2,3,4]:\n    if n == 2:\n        continue\n    print(n)', 'predict_output',
  '["1 3 4", "1 2 3 4", "1", "2 3 4"]'::jsonb,
  '1 3 4', 'continue تتخطى فقط الدورة التي فيها n=2 (فلا تُطبع)، وتستمر الحلقة بمعالجة باقي العناصر بشكل طبيعي.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'متى تُنفَّذ else المرتبطة بحلقة for في Python؟', 'multiple_choice',
  '["فقط إذا اكتملت الحلقة بالكامل دون break", "دائمًا بعد انتهاء الحلقة", "فقط إذا حدث break", "أبدًا لا تُنفَّذ"]'::jsonb,
  'فقط إذا اكتملت الحلقة بالكامل دون break', 'هذه ميزة خاصة في Python: else مع الحلقة تُنفَّذ فقط إذا لم يحدث break أثناء التنفيذ.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'continue تنتقل مباشرة للدورة التالية من نفس الحلقة التي كُتبت بداخلها.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'continue تتجاوز باقي كود الدورة الحالية فقط وتنتقل مباشرة لبدء الدورة التالية في نفس الحلقة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 4;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الفائدة الأساسية من استخدام الدوال؟', 'multiple_choice',
  '["تجنب تكرار الكود وإعادة استخدامه بسهولة", "جعل البرنامج أبطأ", "زيادة عدد الأسطر فقط", "لا فائدة حقيقية منها"]'::jsonb,
  'تجنب تكرار الكود وإعادة استخدامه بسهولة', 'الدوال تسمح بكتابة الكود مرة واحدة واستدعائه بسهولة في أي مكان يحتاجه، بدل تكراره يدويًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الكلمة المفتاحية المستخدمة لتعريف دالة في Python؟', 'multiple_choice',
  '["def", "function", "func", "define"]'::jsonb,
  'def', 'def هي الكلمة المفتاحية المستخدمة لتعريف أي دالة في Python.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في def greet(name):، ماذا يُسمى name؟', 'multiple_choice',
  '["معامل (Parameter)", "وسيط (Argument)", "دالة", "قيمة راجعة"]'::jsonb,
  'معامل (Parameter)', 'name في سطر التعريف يُسمى Parameter، بينما القيمة الفعلية الممررة عند الاستدعاء تُسمى Argument.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'من الممارسات الجيدة أن تقوم كل دالة بمهمة واحدة واضحة بدل أن تكون معقدة ومتعددة الأغراض.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'تقسيم البرنامج لدوال صغيرة، كل واحدة بمسؤولية واحدة واضحة، يجعل الكود أسهل فهمًا وصيانة واختبارًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 11 and l.lesson_number = 8;
