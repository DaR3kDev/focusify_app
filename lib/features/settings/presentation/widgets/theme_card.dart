import 'package:flutter/material.dart';
import 'package:focusify_app/core/theme/theme_controller.dart';

class ThemeCard extends StatefulWidget {
  const ThemeCard({
    required this.type,
    required this.themeMode,
    required this.controller,
    super.key,
  });

  final String type;
  final ThemeMode themeMode;
  final ThemeController controller;

  @override
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final isSelected =
        (widget.themeMode == ThemeMode.dark && widget.type == "dark") ||
        (widget.themeMode == ThemeMode.light && widget.type == "light");

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (widget.type == "dark") {
            widget.controller.setDark();
          } else {
            widget.controller.setLight();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          height: 90,
          decoration: BoxDecoration(
            color: t.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? t.colorScheme.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: t.textTheme.bodyMedium!.copyWith(
                color: isSelected
                    ? t.colorScheme.primary
                    : t.textTheme.bodySmall?.color,
              ),
              child: Text(widget.type.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
