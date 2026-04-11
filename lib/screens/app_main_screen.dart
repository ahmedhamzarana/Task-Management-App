import 'package:flutter/material.dart';
import 'package:task_management_app/screens/home_screen.dart';
import 'package:task_management_app/screens/profile_screen.dart';
import 'package:task_management_app/screens/task_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AddTaskScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        height: 65,
        elevation: 2,
        backgroundColor: Colors.white.withAlpha(230),
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(
              Icons.assignment_rounded,
              color: AppColors.primary,
            ),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
