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
    final theme = Theme.of(context);
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
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: theme.textTheme.bodyMedium!.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodySmall?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
              child: Text(widget.type.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
