-- ============================================================
-- Eleven — Migration 0020: Chapter 14 — دوال القوائم (List Methods)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'الإضافة: append وinsert',
  'أضف عناصر جديدة لقائمة موجودة بطرق مختلفة.',
  '["استخدام append() لإضافة عنصر في النهاية", "استخدام insert() لإضافة عنصر في موقع محدد"]'::jsonb,
  $j${
    "explanation": "append(value) تضيف عنصرًا جديدًا في نهاية القائمة مباشرة، وهي الطريقة الأكثر استخدامًا لإضافة عناصر تدريجيًا (مثلًا داخل حلقة). insert(index, value) تضيف عنصرًا في موقع محدد بالضبط، وتُزيح كل العناصر التي بعده خطوة واحدة للأمام. كلتا الدالتين تُعدّلان القائمة الأصلية مباشرة (In-place) ولا تُرجعان قائمة جديدة.",
    "code_examples": [
      {"code": "fruits = [\"apple\", \"banana\"]\nfruits.append(\"cherry\")\nprint(fruits)   # ['apple', 'banana', 'cherry']\n\nfruits.insert(1, \"mango\")\nprint(fruits)   # ['apple', 'mango', 'banana', 'cherry']", "explanation": "append(\"cherry\") أضافت العنصر في نهاية القائمة مباشرة. insert(1, \"mango\") أضافت \"mango\" في الموقع 1 بالضبط، فأزاحت \"banana\" و\"cherry\" خطوة واحدة للأمام."}
    ],
    "common_mistakes": [
      "توقّع أن append() تُرجع القائمة الجديدة — في الحقيقة تُعدّل القائمة الأصلية مباشرة وتُرجع None.",
      "كتابة fruits = fruits.append(x) بالخطأ، مما يجعل fruits تصبح None لأن append لا تُرجع شيئًا يُذكر."
    ],
    "tips": [
      "append() هي الأداة الأساسية لبناء قائمة تدريجيًا داخل حلقة for، وستستخدمها كثيرًا جدًا لاحقًا.",
      "insert() أبطأ قليلًا من append() على القوائم الكبيرة لأنها تحتاج إزاحة عناصر؛ استخدم append() ما أمكن."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة فارغة، أضف لها 3 أسماء باستخدام append()، ثم أدرج اسمًا رابعًا في البداية باستخدام insert().",
      "starter_code": "names = []\nnames.append(\"سارة\")\nnames.append(\"محمد\")\nnames.append(\"ليلى\")\nnames.insert(0, \"أحمد\")\nprint(names)"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'الحذف: remove, pop, clear',
  'احذف عناصر من القائمة بثلاث طرق مختلفة حسب حاجتك.',
  '["استخدام remove() للحذف بالقيمة", "استخدام pop() للحذف بالموقع مع استرجاع القيمة المحذوفة", "استخدام clear() لتفريغ القائمة بالكامل"]'::jsonb,
  $j${
    "explanation": "توفر Python عدة طرق للحذف من القائمة حسب حاجتك: remove(value) تحذف أول ظهور لقيمة معينة (وتسبب خطأ إن لم توجد القيمة أصلًا). pop(index) تحذف عنصرًا بموقعه وتُرجع القيمة المحذوفة (مفيدة إن أردت استخدام القيمة بعد حذفها)؛ بدون تحديد موقع، تحذف آخر عنصر تلقائيًا. clear() تُفرّغ القائمة بالكامل فتصبح قائمة فارغة [].",
    "code_examples": [
      {"code": "numbers = [10, 20, 30, 40]\nnumbers.remove(20)\nprint(numbers)        # [10, 30, 40]\n\nlast = numbers.pop()\nprint(last)           # 40\nprint(numbers)        # [10, 30]\n\nnumbers.clear()\nprint(numbers)        # []", "explanation": "remove(20) حذفت القيمة 20 أينما وُجدت أول مرة. pop() بدون موقع حذفت وأرجعت آخر عنصر (40) وخزّناه في last. clear() أفرغت القائمة بالكامل فأصبحت []."}
    ],
    "common_mistakes": [
      "استخدام remove() بقيمة غير موجودة أصلًا في القائمة، مما يسبب خطأ ValueError.",
      "الخلط بين remove(value) الذي يأخذ القيمة نفسها، وpop(index) الذي يأخذ الموقع وليس القيمة."
    ],
    "tips": [
      "استخدم pop() عندما تحتاج القيمة المحذوفة لاستخدامها لاحقًا، وremove() عندما تعرف القيمة فقط ولا يهمك موقعها.",
      "تحقق دائمًا من وجود القيمة (باستخدام in) قبل remove() إن لم تكن متأكدًا من وجودها، لتفادي الخطأ."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بمهام يومية، احذف مهمة معينة بالاسم، ثم احذف آخر مهمة باستخدام pop() واطبعها قبل حذفها.",
      "starter_code": "tasks = [\"قراءة\", \"رياضة\", \"برمجة\", \"نوم مبكر\"]\ntasks.remove(\"رياضة\")\nlast_task = tasks.pop()\nprint(\"آخر مهمة كانت:\", last_task)\nprint(tasks)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'الترتيب والبحث',
  'رتّب عناصر القائمة، اعكس ترتيبها، وابحث عن عناصر بداخلها.',
  '["استخدام sort() لترتيب القائمة", "استخدام reverse() لعكس ترتيبها", "استخدام in وindex() و count() للبحث"]'::jsonb,
  $j${
    "explanation": "sort() ترتّب عناصر القائمة تصاعديًا مباشرة (In-place)؛ لترتيب تنازلي تمرر sort(reverse=True). reverse() تعكس ترتيب العناصر الحالي كما هو دون ترتيبها فعليًا. للبحث: in تتحقق من وجود قيمة (True/False)، index(value) تُرجع موقع أول ظهور لقيمة معينة، وcount(value) تُرجع عدد مرات تكرارها في القائمة.",
    "code_examples": [
      {"code": "nums = [5, 2, 8, 1, 9]\nnums.sort()\nprint(nums)              # [1, 2, 5, 8, 9]\n\nnums.sort(reverse=True)\nprint(nums)              # [9, 8, 5, 2, 1]\n\nprint(8 in nums)         # True\nprint(nums.index(5))     # موقع القيمة 5 في القائمة الحالية", "explanation": "sort() الأولى رتبت القائمة تصاعديًا مباشرة. sort(reverse=True) أعادت ترتيبها تنازليًا. in تحققت من وجود القيمة 8، وindex() أرجعت موقعها الحالي بعد الترتيب (لاحظ أن الموقع يتغير بعد كل sort())."}
    ],
    "common_mistakes": [
      "الخلط بين sort() (ترتيب فعلي حسب القيمة) وreverse() (عكس الترتيب الحالي فقط دون فرز).",
      "استخدام index() بقيمة غير موجودة، مما يسبب خطأ ValueError تمامًا مثل remove()."
    ],
    "tips": [
      "sort() تُعدّل القائمة الأصلية مباشرة ولا تُرجع قائمة جديدة — لا تكتب nums = nums.sort().",
      "sorted(list) دالة مختلفة (وليست method) تُرجع قائمة جديدة مرتبة دون تعديل الأصلية — مفيدة إذا أردت الاحتفاظ بالترتيب الأصلي أيضًا."
    ],
    "challenge": {
      "prompt": "أنشئ قائمة بدرجات غير مرتبة، رتّبها تصاعديًا، ثم اطبع أعلى درجة وأدنى درجة باستخدام الفهرسة بعد الترتيب.",
      "starter_code": "grades = [70, 95, 60, 88, 100]\ngrades.sort()\nprint(\"أدنى درجة:\", grades[0])\nprint(\"أعلى درجة:\", grades[-1])"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 7)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: قائمة مهام (To-Do)',
  'ابنِ نسخة بسيطة من تطبيق قائمة مهام باستخدام دوال القوائم.',
  '["دمج append, remove, in في برنامج متكامل", "التعامل مع قائمة ديناميكية تتغير أثناء التشغيل"]'::jsonb,
  $j${
    "explanation": "لنبنِ نسخة مبسّطة جدًا من تطبيق قائمة مهام (To-Do List)، حيث نضيف مهامًا، نتحقق من وجود مهمة معينة، ونزيل مهمة عند إنجازها. هذا التمرين يحاكي جوهر أي تطبيق حقيقي لإدارة المهام، ويجمع كل دوال القوائم التي تعلمتها في هذا الفصل.",
    "code_examples": [
      {"code": "todo_list = []\n\ntodo_list.append(\"مذاكرة Python\")\ntodo_list.append(\"تمرين رياضي\")\ntodo_list.append(\"قراءة كتاب\")\n\nprint(\"المهام الحالية:\", todo_list)\n\ncompleted_task = \"تمرين رياضي\"\nif completed_task in todo_list:\n    todo_list.remove(completed_task)\n    print(f\"تم إنجاز: {completed_task}\")\n\nprint(\"المهام المتبقية:\", todo_list)", "explanation": "نبدأ بقائمة فارغة ونضيف 3 مهام بـappend(). عند إنجاز مهمة، نتحقق أولًا أنها موجودة فعلًا بـin قبل محاولة حذفها بـremove(), لتفادي أي خطأ محتمل إن لم تكن موجودة."}
    ],
    "common_mistakes": [
      "محاولة remove() لمهمة غير موجودة دون التحقق أولًا بـin، مما يوقف البرنامج بخطأ.",
      "نسيان أن القائمة تتغير فعليًا بعد كل append() أو remove()، فيجب طباعتها من جديد لرؤية الحالة المحدّثة."
    ],
    "tips": [
      "التحقق قبل الحذف (if value in list: list.remove(value)) نمط أساسي ستستخدمه كثيرًا لتفادي الأخطاء.",
      "هذا المشروع المصغّر هو أساس بسيط جدًا يشبه كثيرًا كيف تُبنى تطبيقات إدارة المهام الحقيقية خلف الكواليس."
    ],
    "challenge": {
      "prompt": "طوّر تطبيق قائمة المهام ليطبع أيضًا عدد المهام المتبقية بعد كل حذف باستخدام len().",
      "starter_code": "todo_list = [\"مهمة 1\", \"مهمة 2\", \"مهمة 3\"]\ntodo_list.remove(\"مهمة 2\")\nprint(\"المتبقي:\", len(todo_list), \"مهمة\")\nprint(todo_list)"
    }
  }$j$::jsonb, 10, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما الفرق الأساسي بين append() وinsert()؟', 'multiple_choice',
  '["append تضيف في النهاية، insert تضيف في موقع محدد", "لا فرق بينهما", "insert أسرع دائمًا", "append تحذف عنصرًا"]'::jsonb,
  'append تضيف في النهاية، insert تضيف في موقع محدد', 'append() تضيف دائمًا في نهاية القائمة، بينما insert(index, value) تسمح بتحديد الموقع بدقة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'أي دالة تُرجع القيمة المحذوفة بعد حذفها من القائمة؟', 'multiple_choice',
  '["pop()", "remove()", "clear()", "sort()"]'::jsonb,
  'pop()', 'pop() تحذف عنصرًا بموقعه وتُرجع تلك القيمة، بعكس remove() التي لا تُرجع شيئًا مفيدًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, E'ماذا يطبع؟\nnums = [3,1,2]\nnums.sort()\nprint(nums)', 'predict_output',
  '["[1, 2, 3]", "[3, 1, 2]", "[3, 2, 1]", "None"]'::jsonb,
  '[1, 2, 3]', 'sort() ترتب القائمة تصاعديًا مباشرة داخل نفس القائمة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'من الأفضل التحقق من وجود قيمة بـ in قبل استخدام remove() عليها.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'محاولة remove() لقيمة غير موجودة تسبب خطأ ValueError، لذا التحقق المسبق بـ in يجعل الكود أكثر أمانًا.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 7 and l.lesson_number = 8;
