-- ============================================================
-- Eleven — Migration 0008: Problem Solving seed (first batch)
-- 3 Easy + 3 Hard, fully specified. Remaining problems (up to 15+15)
-- follow the exact same shape and can be added the same way.
-- ============================================================

insert into public.problems
  (problem_number, title, description, difficulty, input_description, output_description,
   example_input, example_output, hint, starter_code, solution, test_cases, xp)
values
(1, 'مرحبًا باسمك',
 'اكتب برنامجًا يقرأ اسم المستخدم من input() ثم يطبع جملة ترحيبية بصيغة: Hello, <name>!',
 'easy', 'سطر نصي واحد يمثل الاسم.', 'سطر واحد بصيغة Hello, <name>!',
 'Ahmed', 'Hello, Ahmed!',
 'استخدم input() لقراءة الاسم، ثم ادمجه داخل جملة باستخدام + أو f-string.',
 'name = input()\n',
 'name = input()\nprint(f"Hello, {name}!")',
 '[{"input": "Ahmed", "expected_output": "Hello, Ahmed!"}, {"input": "Sara", "expected_output": "Hello, Sara!"}]'::jsonb,
 15),

(2, 'مجموع رقمين',
 'اقرأ رقمين صحيحين كل واحد في سطر منفصل، واطبع مجموعهما.',
 'easy', 'سطران، كل سطر يحتوي على عدد صحيح.', 'عدد صحيح واحد يمثل المجموع.',
 '3\n5', '8',
 'تذكّر أن input() تُرجع دائمًا نصًا، لذا يجب تحويله لعدد صحيح باستخدام int() قبل الجمع.',
 'a = int(input())\nb = int(input())\n',
 'a = int(input())\nb = int(input())\nprint(a + b)',
 '[{"input": "3\n5", "expected_output": "8"}, {"input": "10\n20", "expected_output": "30"}]'::jsonb,
 15),

(3, 'زوجي أم فردي',
 'اقرأ عددًا صحيحًا واطبع Even إذا كان زوجيًا أو Odd إذا كان فرديًا.',
 'easy', 'عدد صحيح واحد.', 'الكلمة Even أو Odd.',
 '7', 'Odd',
 'استخدم عامل باقي القسمة % مع 2؛ إن كان الباقي صفرًا فالعدد زوجي.',
 'n = int(input())\n',
 'n = int(input())\nprint("Even" if n % 2 == 0 else "Odd")',
 '[{"input": "7", "expected_output": "Odd"}, {"input": "10", "expected_output": "Even"}, {"input": "0", "expected_output": "Even"}]'::jsonb,
 20),

(4, 'أكبر رقم في قائمة',
 'اقرأ سطرًا من الأرقام مفصولة بمسافة، واطبع أكبر رقم فيها، بدون استخدام الدالة الجاهزة max().',
 'hard', 'سطر واحد من الأعداد الصحيحة مفصولة بمسافات.', 'عدد صحيح واحد يمثل الأكبر.',
 '4 9 2 7 1', '9',
 'حوّل السطر إلى قائمة أعداد باستخدام split() وmap()، ثم مرّ عليها بحلقة for وقارن كل عنصر بأكبر قيمة رأيتها حتى الآن.',
 'numbers = list(map(int, input().split()))\n',
 'numbers = list(map(int, input().split()))\nbiggest = numbers[0]\nfor n in numbers:\n    if n > biggest:\n        biggest = n\nprint(biggest)',
 '[{"input": "4 9 2 7 1", "expected_output": "9"}, {"input": "5 5 5", "expected_output": "5"}, {"input": "-3 -1 -9", "expected_output": "-1"}]'::jsonb,
 35),

(5, 'عدد أولي؟',
 'اقرأ عددًا صحيحًا واطبع Prime إذا كان أوليًا، أو Not Prime إن لم يكن كذلك.',
 'hard', 'عدد صحيح واحد أكبر من أو يساوي 1.', 'الكلمة Prime أو Not Prime.',
 '7', 'Prime',
 'العدد الأولي لا يقبل القسمة إلا على 1 وعلى نفسه. جرّب القسمة عليه بكل الأعداد من 2 حتى جذره التربيعي تقريبًا.',
 'n = int(input())\n',
 'n = int(input())\nif n < 2:\n    print("Not Prime")\nelse:\n    is_prime = True\n    for i in range(2, int(n ** 0.5) + 1):\n        if n % i == 0:\n            is_prime = False\n            break\n    print("Prime" if is_prime else "Not Prime")',
 '[{"input": "7", "expected_output": "Prime"}, {"input": "10", "expected_output": "Not Prime"}, {"input": "1", "expected_output": "Not Prime"}, {"input": "2", "expected_output": "Prime"}]'::jsonb,
 40),

(6, 'عكس الكلمات في جملة',
 'اقرأ جملة نصية، واطبعها بعد عكس ترتيب كلماتها (وليس عكس كل حرف).',
 'hard', 'سطر نصي يمثل جملة من عدة كلمات.', 'نفس الجملة بترتيب كلمات معكوس.',
 'Python is fun', 'fun is Python',
 'استخدم split() لتقسيم الجملة إلى كلمات، ثم اعكس ترتيب القائمة الناتجة، ثم ادمجها من جديد باستخدام join().',
 'sentence = input()\n',
 'sentence = input()\nwords = sentence.split()\nreversed_words = words[::-1]\nprint(" ".join(reversed_words))',
 '[{"input": "Python is fun", "expected_output": "fun is Python"}, {"input": "hello world", "expected_output": "world hello"}]'::jsonb,
 40)
on conflict (problem_number) do nothing;
