import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/core/theme/theme_provider.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';
import '../widgets/slider_card.dart';
import '../widgets/switch_card.dart';
import '../widgets/theme_card.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context);

    // Lectura del tema
    final themeMode = ref.watch(themeProvider);
    final themeController = ref.read(themeProvider.notifier);

    // Lectura de configuraciones del temporizador
    final settings = ref.watch(settingsProvider);

    // Estados locales para switches
    bool autoStart = false;
    bool notification = true;

    return Scaffold(
      backgroundColor: t.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              _Header(theme: t),
              const SizedBox(height: 30),
              _TitleSection(theme: t),
              const SizedBox(height: 25),

              // Temporizador
              _SectionTitle(title: "CONFIGURACIÓN DEL TEMPORIZADOR", theme: t),
              SliderCard(
                title: "Duración del enfoque",
                value: settings.focusMinutes.toDouble(),
                unit: "MIN",
                min: 5,
                max: 60,
                onChanged: (v) =>
                    ref.read(settingsProvider.notifier).updateFocus(v.round()),
              ),
              SliderCard(
                title: "Descanso corto",
                value: settings.shortBreakMinutes.toDouble(),
                unit: "MIN",
                min: 1,
                max: 15,
                onChanged: (v) => ref
                    .read(settingsProvider.notifier)
                    .updateShortBreak(v.round()),
              ),
              SliderCard(
                title: "Descanso largo",
                value: settings.longBreakMinutes.toDouble(),
                unit: "MIN",
                min: 5,
                max: 45,
                onChanged: (v) => ref
                    .read(settingsProvider.notifier)
                    .updateLongBreak(v.round()),
              ),
              SliderCard(
                title: "Ciclos antes de descanso largo",
                value: settings.cyclesBeforeLongBreak.toDouble(),
                unit: "CICLOS",
                min: 1,
                max: 10,
                onChanged: (v) =>
                    ref.read(settingsProvider.notifier).updateCycles(v.round()),
              ),

              const SizedBox(height: 20),
              _SectionTitle(title: "AUTOMATION & FEEDBACK", theme: t),
              SwitchCard(
                title: "Inicio automático de la siguiente sesión",
                subtitle:
                    "Inicia automáticamente el enfoque o el descanso después de que el temporizador expire",
                value: autoStart,
                onChanged: (v) => autoStart = v,
              ),
              SwitchCard(
                title: "Sonido de notificación",
                subtitle:
                    "Reproduce un sonido suave cuando el temporizador finalice",
                value: notification,
                onChanged: (v) => notification = v,
              ),

              const SizedBox(height: 20),
              _SectionTitle(title: "AESTHETIC ENVIRONMENT", theme: t),
              Row(
                children: [
                  ThemeCard(
                    type: "dark",
                    themeMode: themeMode,
                    controller: themeController,
                  ),
                  const SizedBox(width: 12),
                  ThemeCard(
                    type: "light",
                    themeMode: themeMode,
                    controller: themeController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "CHRONOMETRIC\nSANCTUARY",
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Configuración",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Crea el ambiente perfecto para sesiones de trabajo en las que puedas concentrarte.",
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.theme});
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 10,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
