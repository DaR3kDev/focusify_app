import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/application/providers/timer_provider.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';
import 'package:focusify_app/shared/widgets/buttons/circle_button.dart';
import 'package:focusify_app/features/timer/presentation/widgets/timer_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // THEMES
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    // TIMER STATE
    final timerState = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);

    // SETTINGS
    final settings = ref.watch(settingsProvider);

    String sessionType() {
      if (timerState.remainingSeconds == timerState.totalSeconds &&
          timerState.sessionCount == 0) {
        return "FOCUS";
      }

      final isLongBreak =
          (timerState.sessionCount % settings.cyclesBeforeLongBreak == 0) &&
          timerState.sessionCount != 0;

      if (isLongBreak) return "DESCANSO LARGO";

      return timerState.sessionCount.isOdd ? "DESCANSO CORTO" : "FOCUS";
    }

    int currentCycle() {
      int cycle = (timerState.sessionCount ~/ 2) + 1;

      if (cycle > settings.cyclesBeforeLongBreak) {
        cycle = settings.cyclesBeforeLongBreak;
      }

      return cycle;
    }

    final currentSession = sessionType();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text(
              sessionType(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            if (currentSession == "FOCUS")
              Text(
                'Ciclo: ${currentCycle()} / ${settings.cyclesBeforeLongBreak}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

            const SizedBox(height: 20),

            Expanded(
              child: Center(
                child: TimerWidget(
                  progress: timerState.progress,
                  time: timerState.formattedTime,
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                if (timerState.isRunning) {
                  timerController.pause();
                } else {
                  timerController.start();
                }
              },
              child: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  timerState.isRunning ? "Pausar" : "Iniciar",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleButton(
                  icon: Icons.refresh_rounded,
                  label: "Reset",
                  onTap: () {
                    timerController.reset();
                  },
                ),
                const SizedBox(width: 20),
                CircleButton(
                  icon: Icons.settings_rounded,
                  label: "Config",
                  onTap: () {
                    context.push('/settings');
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
