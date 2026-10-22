import 'models.dart';

/// بيانات تجريبية بس - هتتستبدل ببيانات حقيقية من Firebase بعدين.
/// النقطة المهمة: كل الشاشات بتقرأ من هنا، فلما نوصل Firebase
/// هنغيّر مصدر البيانات بس من غير ما نلمس تصميم الشاشات.

final List<Person> familyMembers = [
  Person(
    id: 'zeinab',
    name: 'زينب محمد السيّد',
    relation: 'الجدة',
    initial: 'ز',
    years: '١٩٣٨ – ٢٠١٩',
    bio: 'اشتهرت بصوتها الهادئ وحكاياتها قبل النوم، وبإصرارها إن كل حفيد يتعلم ولو حرف واحد جديد كل يوم.',
  ),
  Person(
    id: 'ibrahim',
    name: 'إبراهيم السيّد',
    relation: 'الجد',
    initial: 'إ',
    years: '١٩٣٥ – ٢٠١٥',
    bio: 'كان يعرف اسم كل شجرة في الحقل، وكان بياخدنا نتمشى بعد صلاة الفجر.',
  ),
  Person(
    id: 'karim',
    name: 'كريم إبراهيم',
    relation: 'الأب',
    initial: 'ك',
    years: 'حيّ',
    bio: 'بيحكي عن أبوه كل ما يزرع حاجة جديدة في الشرفة.',
  ),
  Person(
    id: 'hoda',
    name: 'هدى إبراهيم',
    relation: 'العمة',
    initial: 'ه',
    years: 'حيّة',
    bio: 'أقرب الناس لقلب زينب، وبتفتكرها في كل حاجة بتعملها.',
  ),
];

final List<StoryItem> stories = [
  StoryItem(
    personId: 'zeinab',
    label: 'ما أشهر صفة كانت فيها؟',
    content: 'صبرها. مهما كان اليوم تعبان، كانت تقعد تسمعنا لحد ما نخلص كلامنا كله.',
    authorName: 'منى',
    type: StoryType.text,
  ),
  StoryItem(
    personId: 'zeinab',
    label: 'تسجيل صوتي — ١:٤٢ دقيقة',
    content: 'قصة أول يوم مدرسة لجدتي',
    authorName: 'منى',
    type: StoryType.audio,
  ),
  StoryItem(
    personId: 'zeinab',
    label: 'ما موقف لا تنساه معها؟',
    content: 'يوم ما كنت خايف أمتحن، قعدت معايا لحد الفجر تذاكرلي بصوتها من غير ما تنعس.',
    authorName: 'كريم',
    type: StoryType.text,
  ),
  StoryItem(
    personId: 'ibrahim',
    label: 'ماذا كان يحب؟',
    content: 'كان بيحب الفجر والزرع، وكان يقول إن الأرض بترد الجميل لمين ما يهملها.',
    authorName: 'كريم',
    type: StoryType.text,
  ),
];

class CharityOrg {
  final String name;
  final String description;
  final String meta;
  final String emoji;

  const CharityOrg({
    required this.name,
    required this.description,
    required this.meta,
    required this.emoji,
  });
}

const List<CharityOrg> charities = [
  CharityOrg(
    name: 'مستشفى سرطان الأطفال 57357',
    description: 'علاج مجاني لأطفال مصابين بالسرطان',
    meta: 'الخط الساخن: 19057 — الموقع الرسمي: 57357.org',
    emoji: '🏥',
  ),
  CharityOrg(
    name: 'بنك الطعام المصري',
    description: 'توصيل وجبات للأسر الأولى بالرعاية',
    meta: 'تبرع عام أو صدقة جارية باسم شخص',
    emoji: '🍞',
  ),
  CharityOrg(
    name: 'مؤسسة مجدي يعقوب لجراحة القلب',
    description: 'جراحات قلب مجانية للأطفال والكبار',
    meta: 'تبرع عام أو باسم شخص عزيز',
    emoji: '❤️',
  ),
  CharityOrg(
    name: 'مصر الخير',
    description: 'زكاة وصدقات في مجالات متعددة',
    meta: 'تبرع عام أو صدقة جارية باسم شخص',
    emoji: '🕌',
  ),
];
