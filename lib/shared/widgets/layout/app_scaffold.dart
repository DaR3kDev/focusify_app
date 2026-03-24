import 'package:flutter/material.dart';
import 'package:focusify_app/features/timer/presentation/screens/home_screen.dart';
import 'package:focusify_app/features/settings/presentation/screens/setting_screen.dart';
import 'package:focusify_app/features/tasks/presentation/screens/tasks_screens.dart';
import 'package:focusify_app/shared/widgets/navigation-bar/bottom_nav_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;
  late final PageController _pageController;

  static const List<Widget> _pages = [
    HomeScreen(),
    TasksScreen(),
    SettingScreen(),
    // Puedes agregar más pantallas si es necesario
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavBar(currentIndex: _currentIndex, onTap: _onTabChange),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}
