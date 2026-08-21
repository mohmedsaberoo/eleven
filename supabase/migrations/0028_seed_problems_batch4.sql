-- ============================================================
-- Eleven — Migration 0028: Problem Solving seed (batch 4)
-- ============================================================

insert into public.problems
  (problem_number, title, description, difficulty, input_description, output_description,
   example_input, example_output, hint, starter_code, solution, test_cases, xp)
values
(15, 'عد الأرقام الزوجية',
 'اقرأ سطرًا من الأرقام مفصولة بمسافة، واطبع عدد الأرقام الزوجية فيها.',
 'easy', 'سطر من الأعداد الصحيحة مفصولة بمسافات.', 'عدد صحيح يمثل عدد القيم الزوجية.',
 '1 2 3 4 5 6', '3',
 'استخدم نمط العدّاد: مرّ على الأرقام وزد عدّادًا كل مرة يكون الرقم زوجيًا (باقي القسمة على 2 يساوي صفر).',
 'numbers = list(map(int, input().split()))\n',
 'numbers = list(map(int, input().split()))\ncount = 0\nfor n in numbers:\n    if n % 2 == 0:\n        count += 1\nprint(count)',
 '[{"input": "1 2 3 4 5 6", "expected_output": "3"}, {"input": "1 3 5", "expected_output": "0"}]'::jsonb,
 15),

(16, 'تحقق من الحروف المتشابهة (Anagram)',
 'اقرأ كلمتين، واطبع Yes إذا كانت إحداهما تحتوي نفس حروف الأخرى بترتيب مختلف (Anagram)، وإلا No.',
 'hard', 'سطران، كل واحد يحتوي كلمة.', 'Yes أو No.',
 'listen\nsilent', 'Yes',
 'رتّب حروف كل كلمة باستخدام sorted() وقارن النتيجتين؛ إن تطابقتا فهما Anagram.',
 'word1 = input()\nword2 = input()\n',
 'word1 = input()\nword2 = input()\nif sorted(word1) == sorted(word2):\n    print("Yes")\nelse:\n    print("No")',
 '[{"input": "listen\nsilent", "expected_output": "Yes"}, {"input": "hello\nworld", "expected_output": "No"}]'::jsonb,
 35),

(17, 'أصغر وأكبر رقمين في القائمة',
 'اقرأ سطرًا من الأرقام، واطبع أصغر رقمين وأكبر رقمين فيها (مرتبة تصاعديًا) بدون استخدام sort مباشرة على القائمة الأصلية بأي طريقة تريدها.',
 'hard', 'سطر من الأعداد الصحيحة (5 أرقام على الأقل).', 'أربعة أرقام: أصغر رقمين ثم أكبر رقمين، كل واحد في سطر.',
 '5 1 9 3 7', '1\n3\n7\n9',
 'استخدم القائمة المرتبة sorted(numbers) للحصول على نسخة مرتبة دون تعديل الأصلية، ثم استخرج أول عنصرين وآخر عنصرين.',
 'numbers = list(map(int, input().split()))\n',
 'numbers = list(map(int, input().split()))\nsorted_nums = sorted(numbers)\nprint(sorted_nums[0])\nprint(sorted_nums[1])\nprint(sorted_nums[-2])\nprint(sorted_nums[-1])',
 '[{"input": "5 1 9 3 7", "expected_output": "1\n3\n7\n9"}, {"input": "10 20 30 40 50", "expected_output": "10\n20\n40\n50"}]'::jsonb,
 40)
on conflict (problem_number) do nothing;
