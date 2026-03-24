import 'package:flutter/material.dart';
import 'package:focusify_app/features/timer/presentation/screens/home_screen.dart';
import 'package:focusify_app/features/settings/presentation/screens/setting_screen.dart';
import 'package:focusify_app/shared/widgets/navigation-bar/bottom_nav_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;
  final PageController _controller = PageController();

  final List<Widget> pages = const [
    HomeScreen(),
    SettingScreen(),
    // Agrega aquí más pantallas sin tocar el router
  ];

  void onTabChange(int index) {
    setState(() => currentIndex = index);
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabChange,
      ),
    );
  }
}
