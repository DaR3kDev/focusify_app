import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<IconData> _icons = [
    Icons.hourglass_bottom_rounded,
    Icons.task_alt_rounded,
    Icons.show_chart_rounded,
    Icons.tune_rounded,
  ];

  static const List<String> _labels = ["Focus", "Tasks", "Stats", "Settings"];

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Altura adaptable para pantallas pequeñas
    final screenHeight = MediaQuery.of(context).size.height;
    final barHeight = screenHeight < 700 ? 60.0 : 70.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            BottomNavBar._icons.length,
            _buildTabItem(context, barHeight),
          ),
        ),
      ),
    );
  }

  Widget Function(int) _buildTabItem(BuildContext context, double barHeight) =>
      (int index) {
        final isSelected = widget.currentIndex == index;
        final theme = Theme.of(context);
        final primary = theme.colorScheme.primary;

        final padding = isSelected
            ? (barHeight < 70 ? 6.0 : 10.0)
            : (barHeight < 70 ? 2.0 : 6.0);

        return GestureDetector(
          onTap: () => widget.onTap(index),
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  BottomNavBar._icons[index],
                  size: isSelected ? 28 : 24,
                  color: isSelected
                      ? primary
                      : theme.iconTheme.color?.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: isSelected
                    ? Padding(
                        key: ValueKey(BottomNavBar._labels[index]),
                        padding: const EdgeInsets.only(top: 2),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            BottomNavBar._labels[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primary,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      };
}
