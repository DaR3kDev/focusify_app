import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/domain/pomodoro_settings.dart';

class SettingsController extends Notifier<PomodoroSettings> {
  @override
  PomodoroSettings build() {
    // Estado inicial con valores por defecto
    return const PomodoroSettings(
      focusMinutes: 25,
      shortBreakMinutes: 5,
      longBreakMinutes: 15,
      cyclesBeforeLongBreak: 4,
    );
  }

  // ========================
  // MÉTODOS PÚBLICOS
  // ========================

  /// Actualiza la duración de la sesión de enfoque
  void updateFocus(int minutes) {
    if (_isValidFocus(minutes)) {
      _updateState(state.copyWith(focusMinutes: minutes));
    }
  }

  /// Actualiza la duración del descanso corto
  void updateShortBreak(int minutes) {
    _updateState(state.copyWith(shortBreakMinutes: minutes));
  }

  /// Actualiza la duración del descanso largo
  void updateLongBreak(int minutes) {
    _updateState(state.copyWith(longBreakMinutes: minutes));
  }

  /// Actualiza la cantidad de ciclos antes de un descanso largo
  void updateCycles(int cycles) {
    if (cycles > 0) {
      _updateState(state.copyWith(cyclesBeforeLongBreak: cycles));
    }
  }

  // ========================
  // MÉTODOS INTERNOS
  // ========================

  /// Valida que el enfoque esté dentro de un rango razonable
  bool _isValidFocus(int minutes) => minutes >= 5 && minutes <= 60;

  /// Método centralizado para actualizar el estado
  void _updateState(PomodoroSettings newState) {
    state = newState;
  }
}
