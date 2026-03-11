import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimerPhase { idle, work, shortBreak, longBreak }

enum TimerStatus { idle, running, paused, complete }

class TimerState {
  final TimerPhase phase;
  final TimerStatus status;
  final int totalSeconds;
  final int remainingSeconds;
  final String goal;

  const TimerState({
    this.phase = TimerPhase.idle,
    this.status = TimerStatus.idle,
    this.totalSeconds = 25 * 60,
    this.remainingSeconds = 25 * 60,
    this.goal = '',
  });

  double get progress =>
      totalSeconds > 0 ? 1 - (remainingSeconds / totalSeconds) : 0;

  bool get isComplete => status == TimerStatus.complete;
  bool get isRunning => status == TimerStatus.running;
  bool get isPaused => status == TimerStatus.paused;
  bool get isIdle => status == TimerStatus.idle;

  TimerState copyWith({
    TimerPhase? phase,
    TimerStatus? status,
    int? totalSeconds,
    int? remainingSeconds,
    String? goal,
  }) =>
      TimerState(
        phase: phase ?? this.phase,
        status: status ?? this.status,
        totalSeconds: totalSeconds ?? this.totalSeconds,
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
        goal: goal ?? this.goal,
      );
}

class TimerNotifier extends Notifier<TimerState> {
  // Debug mode: 5s work / 3s break for rapid testing
  static const _workDuration = kDebugMode ? 5 : 25 * 60;
  static const _shortBreakDuration = kDebugMode ? 3 : 5 * 60;

  Timer? _ticker;

  @override
  TimerState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const TimerState();
  }

  void setGoal(String goal) {
    state = state.copyWith(goal: goal);
  }

  void start() {
    if (state.status == TimerStatus.running) return;

    if (state.status == TimerStatus.idle) {
      state = state.copyWith(
        phase: TimerPhase.work,
        status: TimerStatus.running,
        totalSeconds: _workDuration,
        remainingSeconds: _workDuration,
      );
    } else if (state.status == TimerStatus.paused) {
      state = state.copyWith(status: TimerStatus.running);
    }

    _startTicker();
  }

  void pause() {
    if (state.status != TimerStatus.running) return;
    _ticker?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  void reset() {
    _ticker?.cancel();
    state = TimerState(goal: state.goal);
  }

  void startBreak() {
    _ticker?.cancel();
    state = state.copyWith(
      phase: TimerPhase.shortBreak,
      status: TimerStatus.running,
      totalSeconds: _shortBreakDuration,
      remainingSeconds: _shortBreakDuration,
    );
    _startTicker();
  }

  void skipBreak() {
    _ticker?.cancel();
    state = TimerState(goal: state.goal);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (state.remainingSeconds <= 1) {
      _ticker?.cancel();
      state = state.copyWith(
        remainingSeconds: 0,
        status: TimerStatus.complete,
      );
      return;
    }
    state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
  }

}

final timerProvider = NotifierProvider<TimerNotifier, TimerState>(
  TimerNotifier.new,
);
