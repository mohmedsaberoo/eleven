-- ============================================================
-- Eleven — Migration 0012: Problem Solving seed (batch 2)
-- ============================================================

insert into public.problems
  (problem_number, title, description, difficulty, input_description, output_description,
   example_input, example_output, hint, starter_code, solution, test_cases, xp)
values
(7, 'محول درجة الحرارة',
 'اقرأ درجة حرارة بمقياس سيليزيوس (Celsius) واطبعها محوّلة إلى فهرنهايت (Fahrenheit) باستخدام المعادلة: F = C * 9/5 + 32',
 'easy', 'عدد (صحيح أو عشري) يمثل درجة الحرارة بالسيليزيوس.', 'عدد عشري يمثل الدرجة بالفهرنهايت.',
 '0', '32.0',
 'طبّق المعادلة مباشرة بعد تحويل الإدخال إلى float.',
 'celsius = float(input())\n',
 'celsius = float(input())\nfahrenheit = celsius * 9 / 5 + 32\nprint(fahrenheit)',
 '[{"input": "0", "expected_output": "32.0"}, {"input": "100", "expected_output": "212.0"}, {"input": "37", "expected_output": "98.6"}]'::jsonb,
 15),

(8, 'محيط ومساحة مستطيل',
 'اقرأ الطول والعرض (كل واحد في سطر)، ثم اطبع المساحة والمحيط، كل واحدة في سطر منفصل.',
 'easy', 'سطران: الطول ثم العرض (أعداد عشرية).', 'سطران: المساحة ثم المحيط.',
 '4\n5', '20.0\n18.0',
 'المساحة = الطول × العرض. المحيط = 2 × (الطول + العرض).',
 'length = float(input())\nwidth = float(input())\n',
 'length = float(input())\nwidth = float(input())\nprint(length * width)\nprint(2 * (length + width))',
 '[{"input": "4\n5", "expected_output": "20.0\n18.0"}, {"input": "10\n2", "expected_output": "20.0\n24.0"}]'::jsonb,
 15),

(9, 'عدّ الحروف المتحركة',
 'اقرأ كلمة نصية باللغة الإنجليزية، واطبع عدد الحروف المتحركة (a, e, i, o, u) فيها.',
 'easy', 'سطر نصي واحد بأحرف إنجليزية صغيرة.', 'عدد صحيح يمثل عدد الحروف المتحركة.',
 'python', '1',
 'مرّ على كل حرف في الكلمة باستخدام حلقة for وتحقق إن كان ضمن مجموعة الحروف المتحركة.',
 'word = input()\n',
 'word = input()\nvowels = "aeiou"\ncount = 0\nfor ch in word:\n    if ch in vowels:\n        count += 1\nprint(count)',
 '[{"input": "python", "expected_output": "1"}, {"input": "hello", "expected_output": "2"}, {"input": "aeiou", "expected_output": "5"}]'::jsonb,
 20),

(10, 'أكبر قاسم مشترك (GCD)',
 'اقرأ عددين صحيحين موجبين واطبع القاسم المشترك الأكبر بينهما (Greatest Common Divisor) بدون استخدام أي مكتبة جاهزة.',
 'hard', 'سطران: عددان صحيحان موجبان.', 'عدد صحيح واحد يمثل القاسم المشترك الأكبر.',
 '12\n18', '6',
 'استخدم خوارزمية إقليدس (Euclidean Algorithm): كرر استبدال (a, b) بـ (b, a % b) حتى يصبح b صفرًا.',
 'a = int(input())\nb = int(input())\n',
 'a = int(input())\nb = int(input())\nwhile b != 0:\n    a, b = b, a % b\nprint(a)',
 '[{"input": "12\n18", "expected_output": "6"}, {"input": "17\n5", "expected_output": "1"}, {"input": "100\n75", "expected_output": "25"}]'::jsonb,
 40)
on conflict (problem_number) do nothing;
