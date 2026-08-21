-- ============================================================
-- Eleven — Migration 0025: Chapter 9 تكملة — حلقة while (دروس 5-8)
-- ============================================================

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 5, 'مقدمة إلى حلقة while',
  'كرّر تنفيذ كتلة كود طالما شرط معين ما زال متحققًا.',
  '["فهم الحاجة لتكرار الكود بدل نسخه يدويًا", "كتابة أول حلقة while", "فهم متى تتوقف الحلقة"]'::jsonb,
  $j${
    "explanation": "حتى الآن، إذا أردنا تكرار سطر معين 5 مرات، كنا سنكتبه 5 مرات يدويًا — وهذا غير عملي إطلاقًا مع تكرار كبير أو غير معروف العدد مسبقًا. حلقة while تحل هذه المشكلة: تُكرر تنفيذ كتلة كود طالما أن شرطًا معينًا لا يزال True، وتتوقف تلقائيًا بمجرد أن يصبح الشرط False. الصيغة: while condition: متبوعة بكتلة الكود التي ستُكرَّر.",
    "code_examples": [
      {"code": "count = 1\nwhile count <= 5:\n    print(count)\n    count += 1", "explanation": "الحلقة تبدأ بـcount=1، وتتحقق من الشرط count <= 5 في كل دورة. طالما الشرط True تُطبع القيمة وتُزاد بـ1. بعد الوصول لـ6، يصبح الشرط False فتتوقف الحلقة، فتطبع الأرقام من 1 إلى 5."}
    ],
    "common_mistakes": [
      "نسيان تحديث المتغير المستخدم في الشرط (مثل count += 1) داخل الحلقة، مما يجعلها تتكرر إلى ما لا نهاية (Infinite Loop).",
      "كتابة شرط يكون False من البداية، فلا تُنفَّذ الحلقة ولو مرة واحدة."
    ],
    "tips": [
      "تأكد دائمًا أن هناك سطرًا داخل الحلقة يُغيّر قيمة المتغير المستخدم في الشرط، وإلا ستحصل على حلقة لا نهائية.",
      "إذا علقت في حلقة لا نهائية أثناء التجربة، يمكنك إيقاف التنفيذ يدويًا (في Playground بزر الإيقاف إن ظهر، أو بإعادة تحميل الصفحة)."
    ],
    "challenge": {
      "prompt": "اكتب حلقة while تطبع الأرقام من 10 إلى 1 تنازليًا.",
      "starter_code": "count = 10\nwhile count >= 1:\n    print(count)\n    count -= 1"
    }
  }$j$::jsonb, 8, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 6, 'الحلقة اللانهائية والتحكم بها',
  'تعرّف على مخاطر الحلقة اللانهائية وكيف تتجنبها عمدًا أو تتحكم بها.',
  '["فهم أسباب حدوث حلقة لا نهائية", "استخدام while True مع break بشكل متحكَّم به"]'::jsonb,
  $j${
    "explanation": "الحلقة اللانهائية (Infinite Loop) تحدث عندما يبقى شرط while صحيحًا للأبد، فتستمر الحلقة بلا توقف حتى تُجمّد البرنامج أو يتدخل المستخدم لإيقافه يدويًا. أحيانًا نستخدم while True عمدًا (شرط يكون True دائمًا) عندما نريد حلقة تستمر حتى يحدث حدث معين بداخلها، وحينها نستخدم break (سنتعمق فيها في الفصل القادم) للخروج من الحلقة يدويًا عند تحقق شرط معين بداخلها.",
    "code_examples": [
      {"code": "count = 0\nwhile True:\n    count += 1\n    print(count)\n    if count == 3:\n        break", "explanation": "while True تعني \"استمر للأبد\" ما لم يحدث شيء يوقفها. هنا نستخدم break للخروج يدويًا بمجرد أن يصل count إلى 3، فتطبع الحلقة 1، 2، 3 فقط ثم تتوقف."}
    ],
    "common_mistakes": [
      "استخدام while True دون وجود break مناسب بداخلها، مما يسبب تجمّد البرنامج فعليًا.",
      "وضع شرط الخروج (break) في مكان خاطئ بحيث لا يُفحص أبدًا أو يُفحص متأخرًا جدًا."
    ],
    "tips": [
      "استخدم while True + break فقط عندما يكون منطقيًا أكثر من شرط تقليدي، مثل انتظار إدخال صحيح من المستخدم.",
      "دائمًا فكّر: كيف ستنتهي هذه الحلقة بالضبط؟ إذا لم تستطع الإجابة بوضوح، راجع منطقك قبل التشغيل."
    ],
    "challenge": {
      "prompt": "استخدم while True لطلب رقم من المستخدم حتى يُدخل الرقم 0 بالضبط، ثم توقف.",
      "starter_code": "while True:\n    num = int(input(\"أدخل رقمًا (0 للخروج): \"))\n    if num == 0:\n        print(\"تم الإنهاء\")\n        break\n    print(\"أدخلت:\", num)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 7, 'حلقة while مع input',
  'دمج حلقة while مع input() لبناء برامج تفاعلية حقيقية.',
  '["بناء حلقة تتكرر بناءً على إدخال المستخدم", "التحقق من صحة الإدخال داخل حلقة"]'::jsonb,
  $j${
    "explanation": "أحد أكثر استخدامات while شيوعًا هو التكرار حتى يُدخل المستخدم قيمة صحيحة أو مقبولة. هذا النمط يُسمى Input Validation Loop (حلقة التحقق من صحة الإدخال): تستمر الحلقة بطلب الإدخال من المستخدم طالما القيمة المُدخلة غير مقبولة، وتتوقف بمجرد أن يُدخل قيمة صالحة.",
    "code_examples": [
      {"code": "age = int(input(\"كم عمرك؟ \"))\nwhile age < 0:\n    print(\"العمر لا يمكن أن يكون سالبًا!\")\n    age = int(input(\"أدخل عمرك مرة أخرى: \"))\n\nprint(\"عمرك المُدخل:\", age)", "explanation": "الحلقة تتحقق من أن العمر ليس سالبًا. طالما القيمة المُدخلة سالبة (شرط الحلقة True)، تستمر بطلب إدخال جديد، وتتوقف فقط عندما يُدخل المستخدم قيمة غير سالبة."}
    ],
    "common_mistakes": [
      "نسيان تحديث المتغير بقراءة input() جديد داخل الحلقة، مما يجعلها تتكرر بنفس القيمة الخاطئة للأبد.",
      "عدم تغطية كل الحالات غير الصالحة الممكنة في الشرط، فيمر إدخال غير منطقي دون رفض."
    ],
    "tips": [
      "هذا النمط (التحقق من صحة الإدخال بحلقة) شائع جدًا وأساسي في أي برنامج تفاعلي حقيقي.",
      "فكّر مسبقًا في كل الحالات غير المقبولة التي تريد رفضها قبل كتابة شرط الحلقة."
    ],
    "challenge": {
      "prompt": "اكتب حلقة تطلب من المستخدم رقمًا بين 1 و10 فقط، وتستمر بالطلب حتى يُدخل رقمًا ضمن هذا النطاق.",
      "starter_code": "num = int(input(\"أدخل رقمًا بين 1 و10: \"))\nwhile num < 1 or num > 10:\n    print(\"رقم غير صالح!\")\n    num = int(input(\"حاول مرة أخرى: \"))\nprint(\"رائع! أدخلت:\", num)"
    }
  }$j$::jsonb, 9, 10
from ch;

with ch as (select id from public.chapters where chapter_number = 9)
insert into public.lessons (chapter_id, lesson_number, title, summary, objectives, content, duration_minutes, xp_reward)
select ch.id, 8, 'مشروع مصغّر: لعبة تخمين رقم',
  'ابنِ أول لعبة بسيطة تجمع while وif وinput معًا.',
  '["دمج while مع if في مشروع لعبة كامل", "بناء منطق لعبة تفاعلية بسيطة من الصفر"]'::jsonb,
  $j${
    "explanation": "لنبنِ لعبة تخمين رقم بسيطة: البرنامج \"يفكر\" في رقم سري ثابت، ويطلب من المستخدم تخمينه، ويستمر بإعطائه تلميحات (أكبر/أصغر) حتى يخمن الرقم الصحيح. هذا مشروع كلاسيكي رائع لتطبيق while مع if معًا في برنامج تفاعلي ممتع وكامل.",
    "code_examples": [
      {"code": "secret_number = 7\nguess = int(input(\"خمّن رقمًا بين 1 و10: \"))\n\nwhile guess != secret_number:\n    if guess < secret_number:\n        print(\"أكبر من ذلك!\")\n    else:\n        print(\"أصغر من ذلك!\")\n    guess = int(input(\"حاول مرة أخرى: \"))\n\nprint(\"صحيح! لقد خمّنت الرقم 🎉\")", "explanation": "الحلقة تستمر طالما التخمين الحالي لا يساوي الرقم السري. في كل دورة، نعطي تلميحًا (أكبر أو أصغر) بناءً على if/else، ثم نطلب تخمينًا جديدًا. بمجرد أن يتطابق التخمين مع الرقم السري، يصبح شرط الحلقة False فتتوقف وتُطبع رسالة النجاح."}
    ],
    "common_mistakes": [
      "نسيان قراءة تخمين جديد داخل الحلقة، مما يجعلها تكرر نفس التلميح للأبد بنفس القيمة الأولى.",
      "عدم اختبار اللعبة بعدة تخمينات مختلفة (أكبر، أصغر، صحيح مباشرة) للتأكد من أن كل الحالات تعمل بشكل صحيح."
    ],
    "tips": [
      "هذا النمط -تكرار حتى تحقق شرط النجاح مع تلميحات في الطريق- أساس كثير من الألعاب النصية البسيطة.",
      "جرّب لاحقًا إضافة عدّاد لعدد المحاولات التي استغرقها المستخدم للفوز، باستخدام متغير إضافي."
    ],
    "challenge": {
      "prompt": "طوّر لعبة التخمين لتضيف عدّاد محاولات، وتطبع عدد المحاولات التي استغرقها اللاعب عند الفوز.",
      "starter_code": "secret_number = 7\nattempts = 0\nguess = int(input(\"خمّن رقمًا بين 1 و10: \"))\nattempts += 1\n\nwhile guess != secret_number:\n    if guess < secret_number:\n        print(\"أكبر من ذلك!\")\n    else:\n        print(\"أصغر من ذلك!\")\n    guess = int(input(\"حاول مرة أخرى: \"))\n    attempts += 1\n\nprint(f\"صحيح! فزت بعد {attempts} محاولة 🎉\")"
    }
  }$j$::jsonb, 11, 15
from ch;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'متى تتوقف حلقة while عن التكرار؟', 'multiple_choice',
  '["عندما يصبح شرطها False", "بعد 10 مرات دائمًا", "لا تتوقف أبدًا", "عند أول سطر داخلها"]'::jsonb,
  'عندما يصبح شرطها False', 'حلقة while تستمر في التكرار طالما شرطها True، وتتوقف فورًا بمجرد أن يصبح الشرط False.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 5;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'ما سبب حدوث حلقة لا نهائية (Infinite Loop) غالبًا؟', 'multiple_choice',
  '["نسيان تحديث المتغير المستخدم في الشرط", "استخدام for بدلًا من while", "كتابة print داخل الحلقة", "استخدام أقواس زائدة"]'::jsonb,
  'نسيان تحديث المتغير المستخدم في الشرط', 'إذا لم يتغيّر المتغير الذي يعتمد عليه الشرط، سيبقى الشرط True للأبد وتستمر الحلقة بلا توقف.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 6;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'حلقة while مفيدة جدًا للتحقق من صحة إدخال المستخدم حتى يُدخل قيمة مقبولة.', 'true_false',
  '["صح", "خطأ"]'::jsonb,
  'صح', 'هذا نمط شائع جدًا يُسمى Input Validation Loop، تستمر الحلقة بطلب إدخال جديد حتى تكون القيمة مقبولة.', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 7;

insert into public.quizzes (lesson_id, question, question_type, options, correct_answer, explanation, order_index)
select l.id, 'في لعبة تخمين رقم باستخدام while، متى تتوقف الحلقة؟', 'multiple_choice',
  '["عندما يتساوى التخمين مع الرقم السري", "بعد 5 محاولات دائمًا", "عند أول تخمين خاطئ", "لا تتوقف إطلاقًا"]'::jsonb,
  'عندما يتساوى التخمين مع الرقم السري', 'شرط الحلقة هو guess != secret_number، فتتوقف بمجرد أن يصبح التخمين مساويًا للرقم السري (الشرط يصبح False).', 1
from public.lessons l join public.chapters c on c.id = l.chapter_id
where c.chapter_number = 9 and l.lesson_number = 8;
