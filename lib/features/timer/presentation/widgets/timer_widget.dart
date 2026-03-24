import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.progress, required this.time});

  final double progress;
  final String time;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: widget.progress,
            strokeWidth: 10,
            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation(primary),
          ),
        ),
        Text(
          widget.time,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 48,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
