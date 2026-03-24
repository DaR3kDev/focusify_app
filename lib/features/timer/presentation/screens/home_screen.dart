import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/application/providers/timer_provider.dart'; // ✅ FIX
import 'package:focusify_app/shared/widgets/buttons/circle_button.dart';
import 'package:focusify_app/features/timer/presentation/widgets/timer_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final timerState = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "FOCUS",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
