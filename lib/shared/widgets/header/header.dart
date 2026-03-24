import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.title, this.actions, this.icon});

  final String title;
  final List<Widget>? actions;
  final IconData? icon;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: colorScheme.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                widget.title.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          if (widget.actions != null) Row(children: widget.actions!),
        ],
      ),
    );
  }
}
