import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/presentation/screens/profile/profile_home.dart';
import 'package:pomodoro/presentation/screens/projects/projects_home.dart';
import 'package:pomodoro/presentation/screens/stats/stats_home.dart';
import 'package:pomodoro/presentation/screens/tasks/quick_task_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    ProjectsHomeScreen(),
    StatsHomeScreen(),
    QuickTaskHomeScreen(),
    ProfileHomeScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
    required bool selected,
    required Function(int) onTap,
  }) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelSmall!.copyWith(inherit: true);

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: selected
                ? AppColors.primary400
                : (theme.brightness == Brightness.light
                    ? AppColors.n1000
                    : AppColors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: textStyle.copyWith(
              color: selected
                  ? AppColors.primary400
                  : (theme.brightness == Brightness.light
                      ? AppColors.n1000
                      : AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 90, // Custom height
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.white
              : AppColors.n900,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(16),
          //   topRight: Radius.circular(16),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              index: 0,
              label: 'Projects',
              icon: FontAwesomeIcons.clipboardList,
              selected: _selectedIndex == 0,
              onTap: _onItemTapped,
            ),
            _buildNavItem(
              context,
              index: 1,
              label: 'Stats',
              icon: FontAwesomeIcons.chartPie,
              selected: _selectedIndex == 1,
              onTap: _onItemTapped,
            ),
            _buildNavItem(
              context,
              index: 2,
              label: 'Quick Session',
              icon: FontAwesomeIcons.circlePlay,
              selected: _selectedIndex == 2,
              onTap: _onItemTapped,
            ),
            _buildNavItem(
              context,
              index: 3,
              label: 'Profile',
              icon: FontAwesomeIcons.user,
              selected: _selectedIndex == 3,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
