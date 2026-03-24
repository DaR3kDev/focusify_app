import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/core/theme/theme_provider.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';
import 'package:focusify_app/shared/widgets/header/header.dart';
import 'package:focusify_app/shared/widgets/title_section/title_section.dart';
import '../widgets/slider_card.dart';
import '../widgets/switch_card.dart';
import '../widgets/theme_card.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Lectura del tema
    final themeMode = ref.watch(themeProvider);
    final themeController = ref.read(themeProvider.notifier);

    // Lectura de configuraciones del temporizador
    final settings = ref.watch(settingsProvider);

    // Estados locales para switches
    bool autoStart = false;
    bool notification = true;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Header(title: 'CHRONOMETRIC SANCTUARY', icon: Icons.settings),
              const SizedBox(height: 30),
              TitleSection(
                title: "Configuración",
                subtitle:
                    "Crea el ambiente perfecto para sesiones de trabajo donde puedas concentrarte.",
                description:
                    "Personaliza el temporizador, automatiza tus sesiones y elige el entorno estético que más te inspire.",
              ),
              const SizedBox(height: 30),

              // Temporizador
              _SectionTitle(
                title: "CONFIGURACIÓN DEL TEMPORIZADOR",
                theme: theme,
              ),
              const SizedBox(height: 10),
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

              const SizedBox(height: 25),
              _SectionTitle(title: "AUTOMATIZACIÓN & FEEDBACK", theme: theme),
              const SizedBox(height: 10),
              SwitchCard(
                title: "Inicio automático de la siguiente sesión",
                subtitle:
                    "Inicia automáticamente el enfoque o descanso al finalizar el temporizador",
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

              const SizedBox(height: 25),
              _SectionTitle(title: "ENTORNO ESTÉTICO", theme: theme),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ThemeCard(
                      type: "dark",
                      themeMode: themeMode,
                      controller: themeController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ThemeCard(
                      type: "light",
                      themeMode: themeMode,
                      controller: themeController,
                    ),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.theme});
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 12,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
