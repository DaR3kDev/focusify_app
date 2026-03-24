import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;

  const TitleSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título principal
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 6),
        // Subtítulo
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          // Descripción / texto adicional
          Text(
            description!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ],
    );
  }
}
