import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/core/theme/theme_provider.dart';
import '../widgets/slider_card.dart';
import '../widgets/switch_card.dart';
import '../widgets/theme_card.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  double focus = 25;
  double shortBreak = 5;
  double longBreak = 15;

  bool autoStart = false;
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final themeMode = ref.watch(themeProvider);
    final themeController = ref.read(themeProvider.notifier);

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
              _SectionTitle(title: "CONFIGURACIÓN DEL TEMPORIZADOR", theme: t),
              SliderCard(
                title: "Duración del enfoque",
                value: focus,
                unit: "MIN",
                min: 5,
                max: 60,
                onChanged: (v) => setState(() => focus = v),
              ),
              SliderCard(
                title: "Descanso corto",
                value: shortBreak,
                unit: "MIN",
                min: 1,
                max: 15,
                onChanged: (v) => setState(() => shortBreak = v),
              ),
              SliderCard(
                title: "Descanso largo",
                value: longBreak,
                unit: "MIN",
                min: 5,
                max: 45,
                onChanged: (v) => setState(() => longBreak = v),
              ),
              const SizedBox(height: 20),
              _SectionTitle(title: "AUTOMATION & FEEDBACK", theme: t),
              SwitchCard(
                title: "Inicio automático de la siguiente sesión",
                subtitle:
                    "Inicia automáticamente el enfoque o el descanso después de que el temporizador expire",
                value: autoStart,
                onChanged: (v) => setState(() => autoStart = v),
              ),
              SwitchCard(
                title: "Sonido de notificación",
                subtitle:
                    "Reproduce un sonido suave cuando el temporizador finalice",
                value: notification,
                onChanged: (v) => setState(() => notification = v),
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
