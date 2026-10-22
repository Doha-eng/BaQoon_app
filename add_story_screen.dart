import 'package:flutter/material.dart';
import '../data/models.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AddStoryScreen extends StatefulWidget {
  final Person person;
  const AddStoryScreen({super.key, required this.person});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  int _method = 2; // 0: صوتي، 1: صورة، 2: كتابة (افتراضي زي الموكاب)
  final _controller = TextEditingController();

  final _questions = const [
    'ما أشهر صفة كانت فيها؟',
    'ما موقف لا تنسينه معها؟',
    'ماذا كانت تحب؟',
    'ما النصيحة التي كانت تكررها؟',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        foregroundColor: AppColors.ink,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          children: [
            Text('أضف حكاية عن ${widget.person.name}', style: AppText.display(size: 19)),
            const SizedBox(height: 18),
            Row(
              children: [
                _MethodButton(icon: '🎙️', label: 'تسجيل صوتي', selected: _method == 0, onTap: () => setState(() => _method = 0)),
                const SizedBox(width: 8),
                _MethodButton(icon: '📷', label: 'صورة قديمة', selected: _method == 1, onTap: () => setState(() => _method = 1)),
                const SizedBox(width: 8),
                _MethodButton(icon: '✍️', label: 'كتابة موقف', selected: _method == 2, onTap: () => setState(() => _method = 2)),
              ],
            ),
            const SizedBox(height: 20),
            Text('أو اختاري سؤالًا يساعدك تبدئي', style: AppText.soft(size: 12)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _questions
                  .map((q) => GestureDetector(
                        onTap: () => setState(() => _controller.text = '$q\n'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.line),
                          ),
                          child: Text(q, style: AppText.soft(size: 11.5, color: AppColors.ink)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 5,
              style: AppText.body(size: 12.5),
              decoration: InputDecoration(
                hintText: 'اكتبي هنا... أو اختاري سؤالًا من فوق',
                hintStyle: AppText.soft(),
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.line),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.forest,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  // TODO: هنا هيتحط كود حفظ الحكاية في Firestore
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ الحكاية 🌿')),
                  );
                  Navigator.pop(context);
                },
                child: Text('احفظ الحكاية', style: AppText.title(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodButton extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _MethodButton({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.forestTint : AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? AppColors.forest : AppColors.line),
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 19)),
              const SizedBox(height: 6),
              Text(label, style: AppText.title(size: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
