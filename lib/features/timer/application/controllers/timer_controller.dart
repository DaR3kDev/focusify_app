import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/domain/pomodoro_settings.dart';
import 'package:focusify_app/features/timer/domain/timer_state.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';

class TimerController extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    ref.listen<PomodoroSettings>(settingsProvider, (previous, next) {
      _updateStateForSettingsChange(next);
    });

    ref.onDispose(_stopTimer);

    return _createInitialState();
  }

  // ========================
  // MÉTODOS PÚBLICOS
  // ========================

  void start() {
    if (!state.isRunning) _startTimer();
  }

  void pause() {
    _stopTimer();
    _setRunning(false);
  }

  void reset() {
    _stopTimer();
    final initialState = _createInitialState();
    state = initialState.copyWith(sessionCount: state.sessionCount);
  }

  void skipSession() {
    _stopTimer();
    state = state.copyWith(
      isRunning: false,
      sessionCount: state.sessionCount + 1,
      remainingSeconds: state.totalSeconds,
    );
  }

  // ========================
  // MÉTODOS INTERNOS
  // ========================

  /// Crea el estado inicial del temporizador
  TimerState _createInitialState() {
    final settings = ref.watch(settingsProvider);
    final safeFocus = settings.focusMinutes > 0 ? settings.focusMinutes : 25;
    final totalSeconds = safeFocus * 60;

    return TimerState(
      totalSeconds: totalSeconds,
      remainingSeconds: totalSeconds,
      isRunning: false,
    );
  }

  /// Inicia el temporizador
  void _startTimer() {
    _setRunning(true);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds <= 0) {
        _handleSessionEnd();
        return;
      }
      _decrementSecond();
    });
  }

  /// Detiene el temporizador
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Actualiza el estado cuando cambia la configuración
  void _updateStateForSettingsChange(PomodoroSettings newSettings) {
    if (state.isRunning) return;

    final oldTotal = state.totalSeconds;
    final newTotal = newSettings.focusMinutes * 60;

    final progress = 1 - (state.remainingSeconds / oldTotal);
    final newRemaining = (newTotal * (1 - progress)).round();

    state = state.copyWith(
      totalSeconds: newTotal,
      remainingSeconds: newRemaining,
    );
  }

  /// Maneja la finalización de una sesión
  void _handleSessionEnd() {
    _stopTimer();

    final settings = ref.read(settingsProvider);
    final isLongBreak =
        (state.sessionCount + 1) % settings.cyclesBeforeLongBreak == 0;

    final nextSeconds = isLongBreak
        ? settings.longBreakMinutes * 60
        : settings.shortBreakMinutes * 60;

    state = state.copyWith(
      isRunning: true,
      sessionCount: state.sessionCount + 1,
      totalSeconds: nextSeconds,
      remainingSeconds: nextSeconds,
    );

    _startTimer();
  }

  /// Decrementa un segundo del temporizador
  void _decrementSecond() {
    state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
  }

  /// Cambia el estado de ejecución
  void _setRunning(bool isRunning) {
    state = state.copyWith(isRunning: isRunning);
  }
}
