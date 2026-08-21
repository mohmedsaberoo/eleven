-- ============================================================
-- Eleven — Migration 0022: Chapter 15 — الصفوف (Tuples)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 1, 'ما هو الـTuple؟',
  'تعرّف على قائمة خاصة لا يمكن تعديلها بعد إنشائها.',
  '["فهم مفهوم Tuple كقائمة Immutable", "إنشاء Tuple والوصول لعناصره", "معرفة متى تُفضَّل Tuple على List"]'::jsonb,
  $j${
    "explanation": "الـ Tuple (الصفّ) يشبه القائمة تمامًا في أنه حاوية مرتبة لعدة قيم، لكنه يُنشأ بأقواس عادية () بدلًا من المربعة []، والفرق الجوهري: الـ Tuple Immutable تمامًا مثل النصوص، أي لا يمكن تعديل عناصره بعد إنشائه إطلاقًا. تُستخدم الـ Tuples عندما تريد التأكد أن مجموعة من القيم لن تتغير أبدًا أثناء تشغيل البرنامج، مثل إحداثيات ثابتة أو أيام الأسبوع.",
    "code_examples": [
      {"code": "point = (10, 20)\nprint(point[0])    # 10\nprint(point[1])    # 20\n\ndays = (\"Sat\", \"Sun\", \"Mon\")\nprint(days)", "explanation": "point هو Tuple من قيمتين يمثل إحداثيات (x, y)، والوصول لعناصره يتم بنفس طريقة الفهرسة في القوائم، لكن دون إمكانية تعديل point[0] لاحقًا."}
    ],
    "common_mistakes": [
      "محاولة تعديل عنصر في Tuple مثل point[0] = 5، مما يسبب خطأ TypeError لأنه Immutable.",
      "نسيان الفاصلة عند إنشاء Tuple بعنصر واحد فقط، مثل (5) التي تُعتبر رقمًا وليست Tuple — الصيغة الصحيحة هي (5,)."
    ],
    "tips": [
      "استخدم Tuple عندما تريد ضمان عدم تغيّر البيانات، وList عندما تحتاج مرونة التعديل.",
      "الـ Tuples أسرع قليلًا من القوائم في المعالجة الداخلية، لذا تُفضَّل أحيانًا للبيانات الثابتة الكبيرة."
    ],
    "challenge": {
      "prompt": "أنشئ Tuple يمثل تاريخ ميلادك (يوم، شهر، سنة) واطبع كل جزء منه على حدة.",
      "starter_code": "birth_date = (15, 6, 2005)\nprint(\"اليوم:\", birth_date[0])\nprint(\"الشهر:\", birth_date[1])\nprint(\"السنة:\", birth_date[2])"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 2, 'فك التغليف (Unpacking)',
  'استخرج قيم Tuple مباشرة إلى متغيرات منفصلة بسطر واحد.',
  '["استخدام Tuple Unpacking لتوزيع القيم على متغيرات", "فهم أن عدد المتغيرات يجب أن يطابق عدد العناصر"]'::jsonb,
  $j${
    "explanation": "فك التغليف (Unpacking) يسمح لك بتوزيع عناصر Tuple مباشرة على عدة متغيرات في سطر واحد فقط، بدلًا من الوصول لكل عنصر بفهرسته على حدة. هذا يجعل الكود أنظف وأوضح بشكل كبير، خصوصًا عند التعامل مع بيانات ذات معنى واضح لكل عنصر مثل الإحداثيات أو معلومات شخص.",
    "code_examples": [
      {"code": "point = (10, 20)\nx, y = point\nprint(x)   # 10\nprint(y)   # 20\n\nname, age, city = (\"سارة\", 22, \"القاهرة\")\nprint(f\"{name} عمرها {age} من {city}\")", "explanation": "x, y = point توزّع القيمتين في point مباشرة على x وy بترتيبهما. نفس المبدأ يعمل مع أي عدد من العناصر طالما عدد المتغيرات على اليسار مطابق تمامًا لعدد عناصر الـTuple."}
    ],
    "common_mistakes": [
      "محاولة فك تغليف Tuple بعدد متغيرات لا يطابق عدد عناصره بالضبط، مما يسبب خطأ ValueError.",
      "نسيان أن الترتيب مهم جدًا: أول متغير يأخذ أول قيمة، وهكذا بالتسلسل."
    ],
    "tips": [
      "فك التغليف يُستخدم كثيرًا جدًا عند إرجاع أكثر من قيمة من دالة واحدة، كما سنرى في فصل الدوال لاحقًا.",
      "يمكنك أيضًا فك تغليف قوائم بنفس الطريقة تمامًا، وليس فقط Tuples."
    ],
    "challenge": {
      "prompt": "أنشئ Tuple بثلاث قيم لمنتج (اسم، سعر، كمية)، وفكّ تغليفه مباشرة لثلاثة متغيرات واطبعها بجملة واحدة.",
      "starter_code": "product = (\"سماعة\", 150, 5)\nname, price, quantity = product\nprint(f\"{name}: {quantity} قطعة بسعر {price} لكل واحدة\")"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 3, 'Tuple مقابل List',
  'قارن بدقة بين القوائم والـTuples ومتى تختار كل واحدة.',
  '["مقارنة عملية بين List وTuple", "التحويل بين النوعين باستخدام list() وtuple()"]'::jsonb,
  $j${
    "explanation": "القائمة (List) والـ Tuple متشابهان جدًا في كونهما حاويات مرتبة للقيم، لكن الفرق الجوهري هو القابلية للتعديل: القوائم Mutable (قابلة للتعديل) والـTuples Immutable (ثابتة بعد الإنشاء). يمكنك التحويل من نوع لآخر بسهولة باستخدام list() لتحويل Tuple لقائمة، أو tuple() لتحويل قائمة لـTuple، حسب ما يناسب احتياجك في لحظة معينة.",
    "code_examples": [
      {"code": "my_tuple = (1, 2, 3)\nmy_list = list(my_tuple)\nmy_list.append(4)\nprint(my_list)          # [1, 2, 3, 4]\n\nback_to_tuple = tuple(my_list)\nprint(back_to_tuple)    # (1, 2, 3, 4)", "explanation": "حوّلنا Tuple لقائمة باستخدام list() لنتمكن من إضافة عنصر إليه بـappend() (وهو مستحيل على Tuple مباشرة)، ثم أعدنا تحويله لـTuple مرة أخرى بـtuple() إذا أردنا ذلك."}
    ],
    "common_mistakes": [
      "استخدام List في كل الحالات دون التفكير في Tuple، رغم أن Tuple أنسب دلاليًا للبيانات الثابتة.",
      "نسيان أن التحويل list() أو tuple() يُنشئ نسخة جديدة تمامًا مستقلة عن الأصل."
    ],
    "tips": [
      "قاعدة بسيطة: إذا كانت البيانات لن تتغير أبدًا (مثل أيام الأسبوع)، استخدم Tuple. إذا كانت ستُعدَّل، استخدم List.",
      "Tuples يمكن استخدامها كمفاتيح في Dictionaries (سنتعلمها قريبًا) بينما القوائم لا يمكن — ميزة إضافية مهمة."
    ],
    "challenge": {
      "prompt": "أنشئ Tuple بثلاثة ألوان، حوّله لقائمة، أضف لونًا رابعًا، ثم اطبع القائمة النهائية.",
      "starter_code": "colors = (\"أحمر\", \"أزرق\", \"أخضر\")\ncolors_list = list(colors)\ncolors_list.append(\"أصفر\")\nprint(colors_list)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 8)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 4, 'تمارين على Tuples',
  'طبّق كل ما تعلمته عن Tuples في تمرين عملي.',
  '["استخدام Tuples لتمثيل بيانات ثابتة ذات معنى", "دمج فك التغليف مع f-strings"]'::jsonb,
  $j${
    "explanation": "لنستخدم Tuples لتمثيل مجموعة إحداثيات جغرافية ثابتة لمدن مختلفة، ونطبع معلومات كل مدينة بشكل منسّق باستخدام فك التغليف وf-strings معًا. هذا مثال واقعي شائع: البيانات الجغرافية الثابتة (خط الطول والعرض) من أفضل الحالات لاستخدام Tuples لأنها لا تتغير.",
    "code_examples": [
      {"code": "cairo = (\"القاهرة\", 30.04, 31.23)\ndubai = (\"دبي\", 25.20, 55.27)\n\nfor city in [cairo, dubai]:\n    name, lat, lon = city\n    print(f\"{name}: خط عرض {lat}, خط طول {lon}\")", "explanation": "كل مدينة مُمثَّلة كـTuple ثابت من 3 عناصر. نمرّ على قائمة تحتوي هذه الـTuples (سنتعمق في حلقة for قريبًا)، ونفك تغليف كل واحدة لثلاثة متغيرات واضحة قبل طباعتها بجملة منسّقة."}
    ],
    "common_mistakes": [
      "محاولة تعديل إحداثيات مدينة موجودة مباشرة بدل إنشاء Tuple جديد بالكامل.",
      "الخلط بين ترتيب خط العرض وخط الطول عند فك التغليف، مما يعكس المعنى دون أن يظهر كخطأ برمجي."
    ],
    "tips": [
      "لا تقلق إن بدت حلقة for هنا غير مألوفة تمامًا بعد؛ سنتعمق فيها بالتفصيل في الفصل القادم مباشرة.",
      "تسمية المتغيرات بوضوح (name, lat, lon) بعد فك التغليف يجعل الكود أسهل قراءة بكثير من استخدام city[0], city[1]."
    ],
    "challenge": {
      "prompt": "أنشئ Tuple يمثل بيانات كتاب (العنوان، المؤلف، سنة النشر)، وفكّ تغليفه واطبعه بجملة واحدة منسّقة.",
      "starter_code": "book = (\"مئة عام من العزلة\", \"غابرييل غارسيا ماركيز\", 1967)\ntitle, author, year = book\nprint(f\"{title} بقلم {author}، نُشر عام {year}\")"
    }
  }$j$::jsonb, 9, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما القوسان المستخدمان لإنشاء Tuple؟', 'multiple_choice',
  '["()", "[]", "{}", "<>"]'::jsonb,
  '()', 'الـTuples تُنشأ باستخدام الأقواس العادية ().', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 1;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ماذا يحدث عند محاولة تعديل عنصر في Tuple؟', 'multiple_choice',
  '["خطأ TypeError", "يتم التعديل بنجاح", "يتحول تلقائيًا لقائمة", "لا شيء يحدث"]'::jsonb,
  'خطأ TypeError', 'الـTuples Immutable، لذا أي محاولة تعديل مباشر تسبب خطأ TypeError.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 2;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\na, b = (5, 10)\nprint(a + b)', 'predict_output',
  '["15", "510", "5, 10", "خطأ"]'::jsonb,
  '15', 'فك التغليف يوزّع 5 على a و10 على b، وجمعهما ينتج 15.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 3;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'يمكن تحويل Tuple إلى List باستخدام الدالة list().', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'list(some_tuple) تُنشئ قائمة جديدة قابلة للتعديل تحتوي نفس عناصر الـTuple الأصلي.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 8 and l.lesson_number = 4;
