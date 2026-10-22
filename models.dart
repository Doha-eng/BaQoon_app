/// شخص في العائلة - حي أو متوفى (الأثر بيبدأ من الحياة)
class Person {
  final String id;
  final String name;
  final String relation;
  final String initial;
  final String years;
  final String bio;

  const Person({
    required this.id,
    required this.name,
    required this.relation,
    required this.initial,
    required this.years,
    required this.bio,
  });
}

/// حكاية أو ذكرى مرتبطة بشخص
class StoryItem {
  final String personId;
  final String label; // السؤال أو نوع المحتوى
  final String content;
  final String authorName;
  final StoryType type;

  const StoryItem({
    required this.personId,
    required this.label,
    required this.content,
    required this.authorName,
    required this.type,
  });
}

enum StoryType { text, audio, photo }
