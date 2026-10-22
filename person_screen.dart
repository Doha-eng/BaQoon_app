import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'add_story_screen.dart';

class PersonScreen extends StatefulWidget {
  final Person person;
  const PersonScreen({super.key, required this.person});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);

  // حالة أزرار "شجرة النور والدعاء" - محليّة دلوقتي، هتتخزن في Firestore بعدين
  final Map<String, bool> _light = {
    'دعوت لها اليوم': false,
    'قرأت لها': false,
    'تصدقت عنها خارج التطبيق': false,
    'أضفت ذكرى طيبة': false,
  };

  @override
  Widget build(BuildContext context) {
    final personStories = stories.where((s) => s.personId == widget.person.id).toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        foregroundColor: AppColors.ink,
        title: Text('صفحة أثر', style: AppText.title()),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: AppColors.goldTint,
                    child: Text(widget.person.initial, style: AppText.display(size: 30, color: AppColors.gold)),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.person.name, style: AppText.display(size: 22)),
                  const SizedBox(height: 2),
                  Text('${widget.person.relation} — ${widget.person.years}', style: AppText.soft()),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(widget.person.bio, textAlign: TextAlign.center, style: AppText.body()),
                  ),
                ],
              ),
            ),
            _LightBox(states: _light, onToggle: (k) => setState(() => _light[k] = !_light[k]!)),
            const SizedBox(height: 6),
            TabBar(
              controller: _tab,
              labelColor: AppColors.forest,
              unselectedLabelColor: AppColors.inkSoft,
              indicatorColor: AppColors.forest,
              labelStyle: AppText.title(size: 12),
              tabs: const [Tab(text: 'الحكايات'), Tab(text: 'الصور'), Tab(text: 'التسجيلات')],
            ),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tab,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    children: personStories.map((s) => _StoryCard(story: s)).toList(),
                  ),
                  GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    children: List.generate(
                      6,
                      (_) => DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.rustTint, AppColors.goldTint],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    children: [
                      _AudioRow(title: 'حكاية أول يوم مدرسة', meta: 'بصوت منى — ١:٤٢'),
                      _AudioRow(title: 'دعاء اعتادت تقوله', meta: 'بصوت كريم — ٠:٥٨'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.forest,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddStoryScreen(person: widget.person)),
                  ),
                  child: Text('أضف ذكرى عنها', style: AppText.title(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LightBox extends StatelessWidget {
  final Map<String, bool> states;
  final void Function(String) onToggle;
  const _LightBox({required this.states, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🕯️ شجرة النور والدعاء', style: AppText.title(size: 12.5)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: states.keys.map((k) {
              final on = states[k]!;
              return GestureDetector(
                onTap: () => onToggle(k),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    color: on ? AppColors.forest : AppColors.bg,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: on ? AppColors.forest : AppColors.line),
                  ),
                  child: Text(k, style: AppText.soft(size: 11.5, color: on ? Colors.white : AppColors.ink)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text('تمت إضافة ١٢ دعوة و٣ ذكريات طيبة هذا الأسبوع', style: AppText.soft(size: 10.5)),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final StoryItem story;
  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(story.label, style: AppText.soft(size: 11)),
          const SizedBox(height: 6),
          Text(story.content, style: AppText.body(size: 12.5)),
        ],
      ),
    );
  }
}

class _AudioRow extends StatelessWidget {
  final String title;
  final String meta;
  const _AudioRow({required this.title, required this.meta});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 15, backgroundColor: AppColors.forest, child: const Icon(Icons.play_arrow, size: 16, color: Colors.white)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.title(size: 12)),
              Text(meta, style: AppText.soft(size: 10.5)),
            ],
          ),
        ],
      ),
    );
  }
}
