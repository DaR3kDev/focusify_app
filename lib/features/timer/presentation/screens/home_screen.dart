import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/application/controllers/timer_controller.dart';
import 'package:focusify_app/features/timer/application/providers/timer_provider.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';
import 'package:focusify_app/features/timer/domain/pomodoro_settings.dart';
import 'package:focusify_app/features/timer/domain/timer_state.dart';
import 'package:focusify_app/shared/widgets/buttons/circle_button.dart';
import 'package:focusify_app/features/timer/presentation/widgets/timer_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final timerState = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);
    final settings = ref.watch(settingsProvider);

    final sessionLabel = _getSessionLabel(timerState, settings);
    final currentCycle = _getCurrentCycle(timerState, settings);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildSessionText(sessionLabel),
            if (sessionLabel == "FOCUS")
              _buildCycleText(currentCycle, settings),
            const SizedBox(height: 20),
            _buildTimer(timerState),
            const SizedBox(height: 20),
            _buildStartPauseButton(timerState, timerController, primaryColor),
            const SizedBox(height: 20),
            _buildActionButtons(context, timerController),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getSessionLabel(TimerState state, PomodoroSettings settings) {
    if (state.sessionCount == 0) return "FOCUS";

    final isLongBreak =
        state.sessionCount % (settings.cyclesBeforeLongBreak * 2) == 0;

    if (isLongBreak && state.sessionCount != 0) return "DESCANSO LARGO";

    return state.sessionCount.isOdd ? "DESCANSO CORTO" : "FOCUS";
  }

  int _getCurrentCycle(TimerState state, PomodoroSettings settings) {
    int cycle = (state.sessionCount ~/ 2) + 1;
    return cycle > settings.cyclesBeforeLongBreak
        ? settings.cyclesBeforeLongBreak
        : cycle;
  }

  Widget _buildSessionText(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCycleText(int currentCycle, PomodoroSettings settings) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Ciclo: $currentCycle / ${settings.cyclesBeforeLongBreak}',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildTimer(TimerState state) {
    return Expanded(
      child: Center(
        child: TimerWidget(progress: state.progress, time: state.formattedTime),
      ),
    );
  }

  Widget _buildStartPauseButton(
    TimerState state,
    TimerController controller,
    Color primary,
  ) {
    return GestureDetector(
      onTap: () {
        if (state.isRunning) {
          controller.pause();
        } else {
          controller.start();
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
          state.isRunning ? "Pausar" : "Iniciar",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, TimerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          icon: Icons.refresh_rounded,
          label: "Reiniciar",
          onTap: controller.reset,
        ),
        const SizedBox(width: 20),
        CircleButton(
          icon: Icons.settings_rounded,
          label: "Configuración",
          onTap: () => context.push('/settings'),
        ),
      ],
    );
  }
}
