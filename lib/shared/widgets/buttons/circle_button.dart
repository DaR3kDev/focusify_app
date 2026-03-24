import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  const CircleButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            widget.label.toUpperCase(),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
