import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../data/models.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/family_tree_painter.dart';
import 'person_screen.dart';
import 'add_story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('شجرة آل السيّد', style: AppText.display(size: 22, color: AppColors.forest)),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.forestTint,
                    child: Text('س', style: AppText.title(color: AppColors.forest)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: CustomPaint(painter: FamilyTreePainter()),
                  ),
                  const SizedBox(height: 6),
                  Text('اضغطي على أي فرد بالأسفل للانتقال لصفحته', style: AppText.soft()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('أفراد العائلة', style: AppText.title()),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: familyMembers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) {
                  final person = familyMembers[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PersonScreen(person: person)),
                    ),
                    child: SizedBox(
                      width: 74,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.goldTint,
                            child: Text(person.initial, style: AppText.display(size: 20, color: AppColors.gold)),
                          ),
                          const SizedBox(height: 6),
                          Text(person.name.split(' ').first, style: AppText.title(size: 12), textAlign: TextAlign.center),
                          Text(person.relation, style: AppText.soft(size: 10.5), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('ذكريات أُضيفت حديثًا', style: AppText.title()),
            ),
            const SizedBox(height: 6),
            ...stories.take(2).map((s) => _MemoryTile(story: s)),
            _AtharCard(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.forest,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddStoryScreen(person: familyMembers.first)),
                      ),
                      child: Text('أضف حكاية', style: AppText.title(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.line),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {},
                      child: Text('أضف فردًا', style: AppText.title(color: AppColors.forest)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  final StoryItem story;
  const _MemoryTile({required this.story});

  String get _icon {
    switch (story.type) {
      case StoryType.audio:
        return '🎙️';
      case StoryType.photo:
        return '📷';
      case StoryType.text:
        return '✍️';
    }
  }

  @override
  Widget build(BuildContext context) {
    final person = familyMembers.firstWhere((p) => p.id == story.personId);
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: AppColors.rustTint, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(_icon, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(story.content, style: AppText.body(size: 12.5)),
                const SizedBox(height: 3),
                Text('من: ${story.authorName} — عن ${person.relation}', style: AppText.soft(size: 10.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AtharCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.goldTint,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أثر اليوم', style: AppText.title(size: 11, color: AppColors.gold)),
          const SizedBox(height: 6),
          Text('"يا بنتي، اللي بيتعلم يفضل واقف حتى لو العمر كله وقوف." — كانت تقولها الجدة زينب كل صباح جمعة.',
              style: AppText.body(size: 13)),
          const SizedBox(height: 8),
          Text('أُضيفت هذه الذكرى منذ عامين', style: AppText.soft(size: 11)),
        ],
      ),
    );
  }
}
