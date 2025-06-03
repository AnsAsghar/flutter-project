import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
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
    // For 7 tabs, we need to use a custom implementation
    // since BottomNavigationBar has a limit of 5 items for fixed type
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_bottomNavItems.length, (index) {
              final isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      (_bottomNavItems[index].icon as Icon).icon,
                      color: isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondaryColor,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _bottomNavItems[index].label ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondaryColor,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
