import 'package:flutter/material.dart';
import 'package:task_management_app/screens/home_screen.dart';
import 'package:task_management_app/screens/task_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const AddTaskScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: NavigationBarTheme(
        // NavigationBar ko customize karne ke liye Theme use karna behtar hai
        data: NavigationBarThemeData(
          indicatorColor: AppColors.danger, // Selection capsule color
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              );
            }
            return TextStyle(fontSize: 12, color: Colors.white.withAlpha(150));
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(size: 28, color: Colors.white);
            }
            return IconThemeData(size: 24, color: Colors.white.withAlpha(150));
          }),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: AppColors.primary,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.task_outlined),
              selectedIcon: Icon(Icons.task),
              label: "Tasks",
            ),
          ],
        ),
      ),
    );
  }
}
