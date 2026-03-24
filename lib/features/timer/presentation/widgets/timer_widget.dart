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

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide * 0.9;
        final strokeWidth = size * 0.04;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Fondo del círculo
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface.withValues(alpha: 0.2),
              ),
            ),
            // Progreso del timer
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: widget.progress,
                strokeWidth: strokeWidth,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            ),
            // Texto del tiempo
            Text(
              widget.time,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: size * 0.2,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
          ],
        );
      },
    );
  }
}
