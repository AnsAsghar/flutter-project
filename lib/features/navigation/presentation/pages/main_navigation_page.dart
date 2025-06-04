import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/platform_service.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../plant_identification/presentation/pages/home_page.dart';
import '../../../history/presentation/pages/history_page.dart';
import '../../../progress/presentation/pages/progress_page.dart';
import '../../../insights/presentation/pages/insights_page.dart';
import '../../../routine/presentation/pages/routine_page.dart';
import '../../../diary/presentation/pages/diary_page.dart';
import '../../../ai_coach/presentation/pages/ai_coach_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const ProgressPage(),
    const InsightsPage(),
    const RoutinePage(),
    const DiaryPage(),
    const AICoachPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.trending_up),
      label: 'Progress',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.insights),
      label: 'Insights',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Routine'),
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diary'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.psychology),
      label: 'AI Coach',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    // Use platform-specific navigation
    return PlatformService.getPlatformNavigation(
      children: _pages,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: _bottomNavItems,
    );
  }
}
