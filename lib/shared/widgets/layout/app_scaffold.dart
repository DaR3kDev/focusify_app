import 'package:flutter/material.dart';
import 'package:focusify_app/shared/widgets/navigation-bar/bottom_nav_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.pages});

  final List<Widget> pages;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;
  final PageController _controller = PageController();

  void onTabChange(int index) {
    setState(() {
      currentIndex = index;
    });
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
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabChange,
      ),
    );
  }
}
