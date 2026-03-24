import 'package:flutter/material.dart';

class SwitchCard extends StatefulWidget {
  const SwitchCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: t.iconTheme.color?.withAlpha(100)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: t.textTheme.bodyMedium),
                Text(
                  widget.subtitle,
                  style: t.textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(value: widget.value, onChanged: widget.onChanged),
        ],
      ),
    );
  }
}
