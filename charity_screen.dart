import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CharityScreen extends StatelessWidget {
  const CharityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              child: Text('صدقة جارية', style: AppText.display(size: 22, color: AppColors.forest)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.forestTint,
                border: Border.all(color: AppColors.forest),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'باقون بيوصّلك بالجهات الرسمية بس — مفيش تحويل فلوس جوه التطبيق، وكل تبرع بيتم من موقع أو قناة الجهة نفسها.',
                style: AppText.soft(size: 11.5, color: AppColors.ink),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('تصدقي باسم زينب', style: AppText.title()),
            ),
            const SizedBox(height: 10),
            ...charities.map((c) => Container(
                  margin: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.line),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: AppColors.rustTint, borderRadius: BorderRadius.circular(11)),
                            alignment: Alignment.center,
                            child: Text(c.emoji, style: const TextStyle(fontSize: 17)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.name, style: AppText.title(size: 12.5)),
                                const SizedBox(height: 2),
                                Text(c.description, style: AppText.soft(size: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(c.meta, style: AppText.soft(size: 10.5)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.forest,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                          ),
                          onPressed: () {
                            // TODO: url_launcher هيفتح موقع الجهة الرسمي فعليًا
                          },
                          child: Text('تصدقي عبر الموقع الرسمي', style: AppText.title(size: 11.5, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'الأسماء هنا أمثلة — لازم نتأكد من كل بيانات وروابط كل جهة من مصدرها الرسمي قبل الإطلاق.',
                textAlign: TextAlign.center,
                style: AppText.soft(size: 10.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
