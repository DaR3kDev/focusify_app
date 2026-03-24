class TimerState {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final int sessionCount;

  const TimerState({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    this.sessionCount = 0,
  });

  // Progreso (0 → 1)
  double get progress {
    if (totalSeconds == 0) return 0;
    return 1 - (remainingSeconds / totalSeconds);
  }

  /// Tiempo formateado (1mm:ss)
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    int? sessionCount,
  }) {
    return TimerState(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      sessionCount: sessionCount ?? this.sessionCount,
    );
  }
}
