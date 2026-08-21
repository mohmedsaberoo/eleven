-- ============================================================
-- Eleven — Migration 0016: Chapter 10 — النصوص (Strings) - الأساسيات
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'مراجعة وتعميق: النصوص',
  'تعمّق أكثر في كيفية إنشاء النصوص والتعامل معها في Python.',
  '["إنشاء نصوص متعددة الأسطر", "استخدام الأحرف الخاصة مثل \\n و\\t", "فهم أن النصوص Immutable (لا يمكن تعديلها مباشرة)"]'::jsonb,
  $j${
    "explanation": "تعلمنا سابقًا أساسيات str، والآن سنتعمق أكثر. يمكنك إنشاء نص متعدد الأسطر باستخدام ثلاث علامات تنصيص متتالية \"\"\" أو '''. كما توجد أحرف خاصة (Escape Characters) مثل \\n لسطر جديد و\\t لعلامة تبويب داخل النص. ميزة مهمة جدًا: النصوص في Python غير قابلة للتعديل المباشر (Immutable)، أي أنك لا تستطيع تغيير حرف واحد داخل نص موجود؛ بدلًا من ذلك تُنشئ نصًا جديدًا.",
    "code_examples": [
      {"code": "poem = \"\"\"السطر الأول\nالسطر الثاني\nالسطر الثالث\"\"\"\nprint(poem)\n\nprint(\"عمود1\\tعمود2\")", "explanation": "النص متعدد الأسطر بين ثلاث علامات تنصيص يحافظ على فواصل الأسطر كما كُتبت. \\t يضيف مسافة تبويب بين \"عمود1\" و\"عمود2\" لتنسيق أفضل."}
    ],
    "common_mistakes": [
      "محاولة تعديل حرف داخل نص مباشرة مثل text[0] = \"a\"، مما يسبب خطأ TypeError لأن النصوص Immutable.",
      "نسيان إغلاق علامات التنصيص الثلاث في النصوص متعددة الأسطر."
    ],
    "tips": [
      "لتعديل نص فعليًا، أنشئ نصًا جديدًا وخزّنه في نفس المتغير أو متغير جديد.",
      "\\n و\\t من أكثر الأحرف الخاصة استخدامًا؛ تذكّرهما جيدًا."
    ],
    "challenge": {
      "prompt": "أنشئ نصًا يحتوي 3 أسطر عن نفسك باستخدام \\n داخل نص عادي (بدون علامات ثلاثية).",
      "starter_code": "bio = \"الاسم: ...\\nالعمر: ...\\nالهواية: ...\"\nprint(bio)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'f-strings',
  'تعرّف على أسهل وأنظف طريقة لدمج القيم داخل النصوص.',
  '["كتابة f-string بالصيغة الصحيحة", "تضمين متغيرات وتعبيرات داخل النص مباشرة"]'::jsonb,
  $j${
    "explanation": "f-strings (النصوص المُنسَّقة) هي أسهل طريقة لدمج قيم داخل نص، وقد حلّت محل الاعتماد الكثيف على + وstr(). لإنشاء f-string، تضع الحرف f قبل علامة التنصيص مباشرة، ثم تكتب أي متغير أو تعبير داخل أقواس معقوفة {} ليتم تقييمه ودمجه في النص تلقائيًا — بدون الحاجة لـ str() يدويًا.",
    "code_examples": [
      {"code": "name = \"سارة\"\nage = 22\nprint(f\"اسمي {name} وعمري {age} سنة\")\nprint(f\"العام القادم سأصبح {age + 1}\")", "explanation": "الأقواس المعقوفة {name} و{age} تُستبدل تلقائيًا بقيمهما الفعلية. حتى التعبيرات الحسابية مثل {age + 1} تُحسب مباشرة داخل f-string دون الحاجة لمتغير وسيط."}
    ],
    "common_mistakes": [
      "نسيان الحرف f قبل علامة التنصيص، فتظهر الأقواس المعقوفة كنص حرفي بدل استبدالها بالقيمة.",
      "استخدام أقواس عادية () بدلًا من المعقوفة {} داخل f-string."
    ],
    "tips": [
      "f-strings أسرع وأوضح بكثير من دمج النصوص بـ + — استخدمها كطريقتك الافتراضية من الآن فصاعدًا.",
      "يمكنك حتى استدعاء دوال داخل f-string مباشرة، مثل f\"الطول: {len(name)}\"."
    ],
    "challenge": {
      "prompt": "أنشئ متغيرات لمنتج (اسم وسعر)، واطبع جملة تصفه باستخدام f-string فقط.",
      "starter_code": "product = \"سماعة\"\nprice = 149.99\nprint(f\"سعر {product} هو {price} جنيه\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'طول النص وعناصره',
  'استخدم len() وتعرّف على مفهوم أن النص سلسلة من الحروف.',
  '["استخدام len() لمعرفة طول أي نص", "فهم أن النص هو سلسلة (Sequence) من الحروف"]'::jsonb,
  $j${
    "explanation": "النص في Python هو في جوهره سلسلة (Sequence) مرتبة من الحروف، ولكل حرف فيها موقع (Index) يبدأ من الصفر. الدالة len() تُرجع عدد الحروف الكلي في النص، بما في ذلك المسافات وعلامات الترقيم. هذا الفهم — أن النص سلسلة مرتبة من العناصر — أساسي جدًا وسيتكرر لاحقًا مع القوائم أيضًا.",
    "code_examples": [
      {"code": "text = \"Python\"\nprint(len(text))       # 6\n\nsentence = \"I love coding\"\nprint(len(sentence))    # 13 (تشمل المسافات)", "explanation": "len(\"Python\") تُرجع 6 لأن الكلمة تحتوي 6 أحرف بالضبط. len(\"I love coding\") تُرجع 13 لأنها تحسب المسافات أيضًا كجزء من طول النص."}
    ],
    "common_mistakes": [
      "نسيان أن len() تحسب المسافات وعلامات الترقيم أيضًا وليس فقط الحروف الأبجدية.",
      "الخلط بين طول النص (عدد الحروف) وعدد الكلمات فيه — هما مفهومان مختلفان تمامًا."
    ],
    "tips": [
      "len() ستكون أداتك الأساسية للتحقق من طول أي نص، خصوصًا في مسائل التحقق من صحة المدخلات.",
      "جرّب len() على نص فارغ \"\" لترى أنها تُرجع 0."
    ],
    "challenge": {
      "prompt": "اطلب من المستخدم كلمة مرور واطبع رسالة تخبره بعدد أحرفها بالضبط.",
      "starter_code": "password = input(\"أدخل كلمة مرور: \")\nprint(f\"كلمة مرورك تحتوي {len(password)} حرفًا\")"
    }
  }$j$::jsonb, 7, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 5)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'تمارين على النصوص',
  'وحّد فهمك للنصوص وf-strings وlen() في تمرين شامل.',
  '["دمج f-string وlen() وif في برنامج واحد", "بناء أداة تحقق من صحة اسم مستخدم"]'::jsonb,
  $j${
    "explanation": "لنبنِ أداة بسيطة للتحقق من صحة اسم مستخدم (Username Validator): يجب أن يكون طوله بين 3 و15 حرفًا. هذا التمرين يجمع بين النصوص، len()، if/else، وf-strings في برنامج عملي واحد يشبه ما تراه فعليًا في نماذج التسجيل بالمواقع الحقيقية.",
    "code_examples": [
      {"code": "username = input(\"اختر اسم مستخدم: \")\nlength = len(username)\n\nif length < 3:\n    print(f\"اسم المستخدم قصير جدًا ({length} حرف)، يجب 3 على الأقل\")\nelif length > 15:\n    print(f\"اسم المستخدم طويل جدًا ({length} حرف)، الحد الأقصى 15\")\nelse:\n    print(f\"اسم المستخدم '{username}' مقبول ✅\")", "explanation": "نحسب طول الاسم أولًا في متغير منفصل length لتفادي تكرار len() عدة مرات، ثم نستخدم if/elif/else لفحص كل حالة ونعرض رسالة واضحة تشمل الطول الفعلي باستخدام f-string."}
    ],
    "common_mistakes": [
      "استدعاء len(username) عدة مرات بدل تخزينها في متغير واحد يُعاد استخدامه.",
      "نسيان تغطية الحد الأدنى والحد الأقصى معًا، فيتم فحص أحدهما فقط."
    ],
    "tips": [
      "تخزين نتيجة دالة تُستخدم أكثر من مرة (مثل len()) في متغير يجعل الكود أنظف وأسرع قليلًا.",
      "هذا النمط (تحقق من صحة مُدخل بحدود دنيا وعليا) شائع جدًا في أي نموذج تسجيل حقيقي."
    ],
    "challenge": {
      "prompt": "طوّر الأداة لتتحقق أيضًا أن اسم المستخدم لا يحتوي مسافات، باستخدام \" \" in username.",
      "starter_code": "username = input(\"اختر اسم مستخدم: \")\nif \" \" in username:\n    print(\"لا يجب أن يحتوي اسم المستخدم على مسافات\")\nelif len(username) < 3:\n    print(\"قصير جدًا\")\nelse:\n    print(\"مقبول ✅\")"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'هل يمكن تعديل حرف واحد داخل نص موجود مباشرة في Python؟', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'خطأ', 'النصوص في Python غير قابلة للتعديل (Immutable)؛ لتغيير محتوى نص يجب إنشاء نص جديد بالكامل.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الحرف الذي يجب وضعه قبل علامة التنصيص لإنشاء f-string؟', 'multiple_choice',
  '["f", "s", "%", "@"]'::jsonb,
  'f', 'وضع f مباشرة قبل علامة التنصيص يجعل Python تعامل النص كـ f-string وتُقيّم أي شيء داخل {}.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nprint(len("Hello World"))', 'predict_output',
  '["10", "11", "12", "5"]'::jsonb,
  '11', '"Hello World" تحتوي 11 حرفًا بما فيها المسافة بين الكلمتين.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nname = "Sam"\nprint(f"Hi {name}!")', 'predict_output',
  '["Hi Sam!", "Hi {name}!", "Hi name!", "خطأ"]'::jsonb,
  'Hi Sam!', 'f-string تستبدل {name} تلقائيًا بقيمة المتغير name، فتكون النتيجة Hi Sam!.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 5 and l.lesson_number = 8;
