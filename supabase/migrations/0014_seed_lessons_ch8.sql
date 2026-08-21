-- ============================================================
-- Eleven — Migration 0014: Chapter 8 — الشروط: elif و else
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'else — الحالة البديلة',
  'أضف كودًا يُنفَّذ فقط عندما يفشل شرط if.',
  '["استخدام else مع if", "فهم أن else يُنفَّذ فقط عند فشل الشرط"]'::jsonb,
  $j${
    "explanation": "حتى الآن، إذا فشل شرط if، لا يحدث شيء ببساطة. لكن غالبًا نريد تنفيذ كود بديل في هذه الحالة، وهنا يأتي دور else. تُكتب else بدون شرط (لأنها تعني حرفيًا: في كل الحالات الأخرى)، وتحتوي على كود يُنفَّذ فقط عندما يكون شرط if الذي يسبقها False.",
    "code_examples": [
      {"code": "age = 15\nif age >= 18:\n    print(\"يمكنك التصويت\")\nelse:\n    print(\"لا يمكنك التصويت بعد\")", "explanation": "بما أن 15 أصغر من 18، فشرط if هو False، لذا يُنفَّذ كود else بدلًا منه ويُطبع \"لا يمكنك التصويت بعد\"."}
    ],
    "common_mistakes": [
      "كتابة شرط بعد else — else لا تقبل أي شرط أبدًا، فهي تمثل كل الحالات الأخرى.",
      "نسيان أن else يجب أن تكون بنفس مستوى إزاحة if التي تتبعها بالضبط."
    ],
    "tips": [
      "فكّر في if/else كسؤال بإجابتين فقط: إما هذا وإما ذاك، لا وسط بينهما.",
      "لاحظ الفرق بين if منفردة (قد لا يُنفَّذ شيء) وif/else (يُنفَّذ أحد المسارين دائمًا)."
    ],
    "challenge": {
      "prompt": "اطلب رقمًا من المستخدم واطبع \"موجب\" أو \"غير موجب\" حسب قيمته.",
      "starter_code": "number = int(input(\"أدخل رقمًا: \"))\nif number > 0:\n    print(\"موجب\")\nelse:\n    print(\"غير موجب\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'elif — احتمالات متعددة',
  'تحقق من أكثر من شرط بالترتيب باستخدام elif.',
  '["استخدام elif للتحقق من أكثر من احتمال", "فهم أن Python تتوقف عند أول شرط صحيح"]'::jsonb,
  $j${
    "explanation": "عندما يكون لديك أكثر من احتمالين، تستخدم elif (اختصار else if) بين if وelse. تتحقق Python من الشروط بالترتيب من الأعلى للأسفل، وبمجرد أن يتحقق أحدها، يُنفَّذ الكود المقابل له وتتوقف عن فحص باقي الشروط تمامًا (حتى لو كانت صحيحة أيضًا). يمكنك استخدام عدة elif متتالية حسب حاجتك.",
    "code_examples": [
      {"code": "grade = 75\nif grade >= 90:\n    print(\"ممتاز\")\nelif grade >= 75:\n    print(\"جيد جدًا\")\nelif grade >= 60:\n    print(\"جيد\")\nelse:\n    print(\"يحتاج تحسين\")", "explanation": "Python تفحص الشروط بالترتيب: 75 >= 90 خطأ، فتنتقل لـ 75 >= 75 وهو صحيح، فتطبع \"جيد جدًا\" وتتوقف فورًا دون فحص باقي الشروط."}
    ],
    "common_mistakes": [
      "استخدام عدة if منفصلة بدلًا من elif، مما قد يؤدي لتنفيذ أكثر من كتلة كود في نفس الوقت دون قصد.",
      "ترتيب الشروط بشكل خاطئ، مثل وضع grade >= 60 قبل grade >= 90، مما يجعل الشروط الأعلى لا تُفحص أبدًا."
    ],
    "tips": [
      "رتّب شروط elif دائمًا من الأكثر تحديدًا (الأعلى قيمة) إلى الأقل تحديدًا لتجنب أخطاء منطقية.",
      "يمكنك استخدام أي عدد تريده من elif بين if وelse واحدة."
    ],
    "challenge": {
      "prompt": "اطلب درجة طالب من المستخدم واطبع تقديره (ممتاز/جيد جدًا/جيد/راسب) حسب نطاقات مناسبة.",
      "starter_code": "grade = int(input(\"الدرجة: \"))\nif grade >= 90:\n    print(\"ممتاز\")\nelif grade >= 75:\n    print(\"جيد جدًا\")\nelif grade >= 50:\n    print(\"جيد\")\nelse:\n    print(\"راسب\")"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'ترتيب تقييم الشروط',
  'افهم بدقة كيف تختار Python أي كتلة تُنفَّذ عند تعدد الاحتمالات.',
  '["تتبع تنفيذ if/elif/else خطوة بخطوة", "توقع نتيجة كود يحتوي شروطًا متعددة"]'::jsonb,
  $j${
    "explanation": "من المهارات الأساسية للمبرمج أن يستطيع \"تتبع\" الكود ذهنيًا قبل تشغيله، أي تخيل كيف ستُقيَّم الشروط سطرًا بسطر. في سلسلة if/elif/elif/else، تتحقق Python من كل شرط بالترتيب، وأول شرط يكون True يُنفَّذ كوده، وبعدها تتجاهل كل ما تبقى من elif وelse تلقائيًا — حتى لو كانت شروط لاحقة صحيحة أيضًا.",
    "code_examples": [
      {"code": "x = 10\nif x > 5:\n    print(\"A\")\nelif x > 8:\n    print(\"B\")\nelse:\n    print(\"C\")", "explanation": "رغم أن x > 8 صحيح أيضًا (10 > 8)، لن يُطبع B أبدًا! لأن Python توقفت عند أول شرط صحيح وهو x > 5، فطبعت A فقط وتجاهلت الباقي تمامًا."}
    ],
    "common_mistakes": [
      "توقّع أن كل الشروط الصحيحة ستُنفَّذ — في الحقيقة فقط أول شرط صحيح يُنفَّذ.",
      "عدم الانتباه لهذا السلوك عند بناء منطق يعتمد على ترتيب دقيق للشروط."
    ],
    "tips": [
      "قبل تشغيل أي كود يحتوي شروطًا متعددة، جرّب تتبعه يدويًا على ورقة أولًا — هذه مهارة تتحسن بالممارسة.",
      "إذا أردت فحص كل الشروط بشكل مستقل (وليس التوقف عند أول صحيح)، استخدم عدة جمل if منفصلة بدلًا من elif."
    ],
    "challenge": {
      "prompt": "توقع ماذا سيطبع الكود التالي قبل تشغيله، ثم شغّله للتأكد: x=7, if x>3: A, elif x>5: B, else: C",
      "starter_code": "x = 7\nif x > 3:\n    print(\"A\")\nelif x > 5:\n    print(\"B\")\nelse:\n    print(\"C\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 4)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: مصنّف الأرقام',
  'ابنِ برنامجًا متكاملًا يستخدم if/elif/else في سيناريو حقيقي.',
  '["دمج if/elif/else في برنامج واحد متكامل", "التعامل مع أكثر من حالة حدّية (boundary case)"]'::jsonb,
  $j${
    "explanation": "لنبنِ برنامجًا يصنّف درجة حرارة الجو إلى: بارد جدًا، بارد، معتدل، حار، أو حار جدًا، بناءً على نطاقات محددة. هذا النوع من البرامج (التصنيف حسب نطاقات) شائع جدًا في تطبيقات حقيقية، ويجمع كل مهارات هذا الفصل في مثال واحد متكامل.",
    "code_examples": [
      {"code": "temp = int(input(\"درجة الحرارة: \"))\n\nif temp < 0:\n    print(\"بارد جدًا ❄️\")\nelif temp < 15:\n    print(\"بارد 🧥\")\nelif temp < 25:\n    print(\"معتدل 🙂\")\nelif temp < 35:\n    print(\"حار ☀️\")\nelse:\n    print(\"حار جدًا 🔥\")", "explanation": "كل نطاق مغطى بشرط مناسب، وبما أن Python تتوقف عند أول شرط صحيح، فإن ترتيب الشروط من الأصغر للأكبر يضمن تصنيفًا دقيقًا لأي درجة حرارة يدخلها المستخدم."}
    ],
    "common_mistakes": [
      "نسيان تغطية إحدى الحالات الحدّية (مثل temp == 0 بالضبط)، مما يسبب سلوكًا غير متوقع عند القيم الحدّية.",
      "استخدام أقل من (<) في مكان يحتاج أقل من أو يساوي (<=) أو العكس."
    ],
    "tips": [
      "اختبر برنامجك دائمًا بالقيم الحدّية بالضبط (مثل 0، 15، 25، 35) للتأكد من أنها تُصنَّف كما تتوقع.",
      "هذا النمط (تصنيف عبر نطاقات متتالية) سيتكرر كثيرًا جدًا في مسائل Problem Solving لاحقًا."
    ],
    "challenge": {
      "prompt": "ابنِ مصنّف درجات: A إذا 90+، B إذا 80-89، C إذا 70-79، وإلا F.",
      "starter_code": "grade = int(input(\"الدرجة: \"))\nif grade >= 90:\n    print(\"A\")\nelif grade >= 80:\n    print(\"B\")\nelif grade >= 70:\n    print(\"C\")\nelse:\n    print(\"F\")"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'متى يُنفَّذ كود else؟', 'multiple_choice',
  '["فقط عندما يكون شرط if الذي قبلها False", "دائمًا بغض النظر عن الشرط", "فقط عند حدوث خطأ", "لا يُنفَّذ أبدًا"]'::jsonb,
  'فقط عندما يكون شرط if الذي قبلها False', 'else تمثل كل الحالات التي لم يتحقق فيها أي شرط سابق (if أو elif).', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا تطبع؟\ngrade=75\nif grade>=90: A\nelif grade>=75: B\nelif grade>=60: C\nelse: D', 'predict_output',
  '["A", "B", "C", "D"]'::jsonb,
  'B', '75>=90 خطأ، لكن 75>=75 صحيح، فتطبع B وتتوقف Python فورًا دون فحص الشروط الأخرى.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في سلسلة if/elif/elif/else، يمكن تنفيذ أكثر من كتلة كود واحدة في نفس التشغيل.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'تتوقف Python عند أول شرط صحيح وتُنفّذ كتلته فقط، متجاهلة كل الشروط اللاحقة حتى لو كانت صحيحة أيضًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما ترتيب الشروط الأنسب عند بناء مصنّف نطاقات باستخدام elif؟', 'multiple_choice',
  '["من الأكثر تحديدًا (الأعلى) للأقل تحديدًا", "لا يهم الترتيب إطلاقًا", "من الأقل للأعلى دائمًا", "عشوائي"]'::jsonb,
  'من الأكثر تحديدًا (الأعلى) للأقل تحديدًا', 'ترتيب الشروط من الأعلى قيمة للأقل يضمن تصنيفًا صحيحًا، لأن Python تتوقف عند أول شرط يتحقق.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 4 and l.lesson_number = 8;
