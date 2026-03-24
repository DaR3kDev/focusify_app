import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/application/controllers/settings_controller.dart';
import 'package:focusify_app/features/timer/domain/pomodoro_settings.dart';

final NotifierProvider<SettingsController, PomodoroSettings> settingsProvider =
    NotifierProvider<SettingsController, PomodoroSettings>(
      SettingsController.new,
    );
