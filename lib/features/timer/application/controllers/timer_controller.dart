import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/domain/timer_state.dart';
import 'package:focusify_app/features/timer/application/providers/settings_provider.dart';

class TimerController extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(_stopTimer);
    return _createInitialState();
  }

  ///----------------------
  /// TIMER CONTROL METHODS
  ///----------------------

  void start() {
    if (state.isRunning) return;
    _startTimer();
  }

  void pause() {
    _stopTimer();
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    _stopTimer();

    final initial = _createInitialState();

    state = initial.copyWith(sessionCount: state.sessionCount);
  }

  void skipSession() {
    _stopTimer();

    state = state.copyWith(
      isRunning: false,
      sessionCount: state.sessionCount + 1,
      remainingSeconds: state.totalSeconds,
    );
  }

  /// ----------------------
  /// INTERNAL LOGIC
  /// ----------------------

  TimerState _createInitialState() {
    final settings = ref.watch(settingsProvider);

    final minutes = settings.focusMinutes;
    final safeMinutes = minutes > 0 ? minutes : 25;

    final seconds = safeMinutes * 60;

    return TimerState(
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
    );
  }

  void _startTimer() {
    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds <= 0) {
        _onFinish();
        return;
      }

      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    });
  }

  void _onFinish() {
    _stopTimer();

    state = state.copyWith(
      isRunning: false,
      sessionCount: state.sessionCount + 1,
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
