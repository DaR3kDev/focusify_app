import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/domain/pomodoro_settings.dart';

class SettingsController extends Notifier<PomodoroSettings> {
  @override
  PomodoroSettings build() {
    return const PomodoroSettings(
      focusMinutes: 25,
      shortBreakMinutes: 5,
      longBreakMinutes: 15,
      cyclesBeforeLongBreak: 4,
    );
  }

  /// ----------------------
  /// UPDATE METHODS
  /// ----------------------

  void updateFocus(int minutes) {
    if (!_isValidFocus(minutes)) return;

    state = state.copyWith(focusMinutes: minutes);
  }

  void updateShortBreak(int minutes) {
    state = state.copyWith(shortBreakMinutes: minutes);
  }

  void updateLongBreak(int minutes) {
    state = state.copyWith(longBreakMinutes: minutes);
  }

  void updateCycles(int cycles) {
    state = state.copyWith(cyclesBeforeLongBreak: cycles);
  }

  /// ----------------------
  /// VALIDATIONS
  /// ----------------------

  bool _isValidFocus(int minutes) {
    return minutes >= 5 && minutes <= 60;
  }
}
