import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusify_app/features/timer/application/controllers/timer_controller.dart';
import 'package:focusify_app/features/timer/domain/timer_state.dart';

final NotifierProvider<TimerController, TimerState> timerProvider =
    NotifierProvider<TimerController, TimerState>(TimerController.new);
