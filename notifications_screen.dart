import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _deathAnniversary = true;
  bool _friday = true;
  bool _eids = true;
  bool _missingStories = false;

  final Map<String, bool> _perPerson = {
    'زينب — الجدة': true,
    'إبراهيم — الجد': true,
  };

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
              child: Text('التذكيرات', style: AppText.display(size: 22, color: AppColors.forest)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(color: AppColors.forestTint, borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: const Text('🌿'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('باقون', style: AppText.title(size: 12, color: AppColors.forest)),
                        const SizedBox(height: 2),
                        Text('النهاردة ذكرى وفاة جدتك زينب — تحبي تقريلها الفاتحة أو تفتكري موقف معاها؟', style: AppText.body(size: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('مواعيد التذكير', style: AppText.title()),
            ),
            const SizedBox(height: 8),
            _ReminderRow(
              color: AppColors.gold,
              title: 'ذكرى الوفاة السنوية',
              subtitle: 'تنبيه واحد في نفس اليوم كل سنة',
              value: _deathAnniversary,
              onChanged: (v) => setState(() => _deathAnniversary = v),
            ),
            _ReminderRow(
              color: AppColors.forest,
              title: 'كل يوم جمعة',
              subtitle: 'تذكير أسبوعي بالدعاء لكل العائلة',
              value: _friday,
              onChanged: (v) => setState(() => _friday = v),
            ),
            _ReminderRow(
              color: AppColors.rust,
              title: 'الأعياد والمناسبات',
              subtitle: 'عيد الفطر، عيد الأضحى، وأول محرم',
              value: _eids,
              onChanged: (v) => setState(() => _eids = v),
            ),
            _ReminderRow(
              color: AppColors.inkSoft,
              title: 'تذكير بالحكايات الناقصة',
              subtitle: 'لو حد في العائلة لسه مالوش صفحة أثر',
              value: _missingStories,
              onChanged: (v) => setState(() => _missingStories = v),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('تنبيهات خاصة بأفراد', style: AppText.title()),
            ),
            ..._perPerson.keys.map((name) => Padding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 15, backgroundColor: AppColors.goldTint, child: Text(name[0], style: AppText.display(size: 12, color: AppColors.gold))),
                      const SizedBox(width: 10),
                      Expanded(child: Text(name, style: AppText.body(size: 12))),
                      Switch(
                        value: _perPerson[name]!,
                        activeColor: AppColors.forest,
                        onChanged: (v) => setState(() => _perPerson[name] = v),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.forest,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ الإعدادات')),
                    );
                  },
                  child: Text('حفظ الإعدادات', style: AppText.title(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ReminderRow({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.title(size: 12.5)),
                Text(subtitle, style: AppText.soft(size: 10.5)),
              ],
            ),
          ),
          Switch(value: value, activeColor: AppColors.forest, onChanged: onChanged),
        ],
      ),
    );
  }
}
