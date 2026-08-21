-- ============================================================
-- Eleven — Migration 0021: Problem Solving seed (batch 3)
-- ============================================================

insert into public.problems
  (problem_number, title, description, difficulty, input_description, output_description,
   example_input, example_output, hint, starter_code, solution, test_cases, xp)
values
(11, 'مجموع قائمة أرقام',
 'اقرأ سطرًا من الأرقام مفصولة بمسافة، واطبع مجموعها الكلي.',
 'easy', 'سطر واحد من الأعداد الصحيحة مفصولة بمسافات.', 'عدد صحيح واحد يمثل المجموع.',
 '1 2 3 4 5', '15',
 'استخدم split() لتحويل السطر لقائمة نصوص، ثم map(int, ...) لتحويلها لأرقام، ثم sum() لجمعها.',
 'numbers = list(map(int, input().split()))\n',
 'numbers = list(map(int, input().split()))\nprint(sum(numbers))',
 '[{"input": "1 2 3 4 5", "expected_output": "15"}, {"input": "10 20", "expected_output": "30"}]'::jsonb,
 15),

(12, 'أطول كلمة في جملة',
 'اقرأ جملة، واطبع أطول كلمة فيها. إذا تساوت أكثر من كلمة في الطول، اطبع أول واحدة ظهرت.',
 'easy', 'سطر نصي يمثل جملة من عدة كلمات.', 'الكلمة الأطول.',
 'I love Python programming', 'programming',
 'قسّم الجملة لكلمات بـsplit()، ثم مرّ عليها بحلقة for وتتبّع أطول كلمة رأيتها حتى الآن.',
 'sentence = input()\n',
 'sentence = input()\nwords = sentence.split()\nlongest = words[0]\nfor w in words:\n    if len(w) > len(longest):\n        longest = w\nprint(longest)',
 '[{"input": "I love Python programming", "expected_output": "programming"}, {"input": "cat dog elephant", "expected_output": "elephant"}]'::jsonb,
 20),

(13, 'إزالة التكرارات من قائمة',
 'اقرأ سطرًا من الأرقام مفصولة بمسافة، واطبع القيم الفريدة فقط (بدون تكرار) بنفس ترتيب ظهورها الأول.',
 'hard', 'سطر واحد من الأعداد الصحيحة مفصولة بمسافات.', 'الأرقام الفريدة مفصولة بمسافة، بترتيب ظهورها الأول.',
 '1 2 2 3 1 4', '1 2 3 4',
 'أنشئ قائمة نتيجة فارغة، ومرّ على الأرقام؛ إن لم يكن الرقم موجودًا في قائمة النتيجة أضفه إليها.',
 'numbers = list(map(int, input().split()))\n',
 'numbers = list(map(int, input().split()))\nunique = []\nfor n in numbers:\n    if n not in unique:\n        unique.append(n)\nprint(" ".join(map(str, unique)))',
 '[{"input": "1 2 2 3 1 4", "expected_output": "1 2 3 4"}, {"input": "5 5 5", "expected_output": "5"}]'::jsonb,
 35),

(14, 'فيبوناتشي حتى العدد N',
 'اقرأ عددًا صحيحًا n، واطبع أول n عددًا من متتالية فيبوناتشي (تبدأ بـ0، 1) مفصولة بمسافة.',
 'hard', 'عدد صحيح n أكبر من أو يساوي 1.', 'أول n عددًا من متتالية فيبوناتشي مفصولة بمسافة.',
 '6', '0 1 1 2 3 5',
 'ابدأ بقائمة تحتوي [0, 1]، ثم أضف كل عدد جديد كمجموع آخر عددين حتى تصل لطول n، مع الانتباه لحالة n=1.',
 'n = int(input())\n',
 'n = int(input())\nfib = [0, 1]\nwhile len(fib) < n:\n    fib.append(fib[-1] + fib[-2])\nresult = fib[:n]\nprint(" ".join(map(str, result)))',
 '[{"input": "6", "expected_output": "0 1 1 2 3 5"}, {"input": "1", "expected_output": "0"}, {"input": "2", "expected_output": "0 1"}]'::jsonb,
 40)
on conflict (problem_number) do nothing;
