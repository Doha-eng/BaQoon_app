import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'theme/text_styles.dart';
import 'screens/home_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/charity_screen.dart';

void main() {
  runApp(const BaqoonApp());
}

class BaqoonApp extends StatelessWidget {
  const BaqoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'باقون',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        // ملاحظة: عشان الـ Cupertino/Material widgets تترجم تلقائيًا لازم نضيف
        // flutter_localizations في pubspec.yaml. مش ضروري في هذه المرحلة
        // لأن كل النصوص عندنا مكتوبة يدويًا بالعربي.
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.forest),
        useMaterial3: true,
      ),
      builder: (context, child) {
        // بيفرض اتجاه RTL على التطبيق كله
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const RootNav(),
    );
  }
}

class RootNav extends StatefulWidget {
  const RootNav({super.key});

  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    NotificationsScreen(),
    CharityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: AppColors.card,
        indicatorColor: AppColors.forestTint,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.park_outlined),
            selectedIcon: Icon(Icons.park, color: AppColors.forest),
            label: 'العائلة',
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications, color: AppColors.forest),
            label: 'التذكيرات',
          ),
          NavigationDestination(
            icon: const Icon(Icons.volunteer_activism_outlined),
            selectedIcon: Icon(Icons.volunteer_activism, color: AppColors.forest),
            label: 'صدقة جارية',
          ),
        ],
      ),
    );
  }
}
