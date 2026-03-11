import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../milestones/providers/milestone_provider.dart';
import '../../milestones/widgets/milestone_bar.dart';
import '../../session/widgets/reflection_sheet.dart';
import '../providers/timer_provider.dart';
import 'circular_progress.dart';

class FocusScreen extends ConsumerStatefulWidget {
  const FocusScreen({super.key});

  @override
  ConsumerState<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends ConsumerState<FocusScreen> {
  final _goalController = TextEditingController();
  late final ConfettiController _confetti;
  bool _reflectionShown = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _goalController.dispose();
    _confetti.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _handleCompletion(BuildContext context) {
    _confetti.play();
    _reflectionShown = false;
    ref.read(milestoneProvider.notifier).recordSession();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!context.mounted || _reflectionShown) return;
      _reflectionShown = true;
      ReflectionSheet.show(
        context,
        onPositive: () {
          Navigator.pop(context);
          ref.read(timerProvider.notifier).startBreak();
        },
        onNegative: () {
          Navigator.pop(context);
          ref.read(timerProvider.notifier).startBreak();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerProvider);
    final milestones = ref.watch(milestoneProvider);

    ref.listen(timerProvider, (prev, next) {
      if (prev?.status != TimerStatus.complete &&
          next.status == TimerStatus.complete &&
          next.phase == TimerPhase.work) {
        _handleCompletion(context);
      }
      if (prev?.status != TimerStatus.complete &&
          next.status == TimerStatus.complete &&
          next.phase == TimerPhase.shortBreak) {
        ref.read(timerProvider.notifier).reset();
      }
    });

    final isDimmed = timer.isRunning;
    final isBreak = timer.phase == TimerPhase.shortBreak;

    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: isDimmed ? 0.35 : 1.0,
        child: SafeArea(
          child: Stack(
            children: [
              // Confetti burst
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 40,
                  gravity: 0.3,
                  colors: const [
                    AppTheme.accent,
                    AppTheme.success,
                    Colors.white,
                    AppTheme.accentDim,
                  ],
                ),
              ),

              Column(
                children: [
                  const SizedBox(height: 48),

                  // App title
                  Text(
                    isBreak ? 'BREAK' : 'FOCUS',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 48),

                  // Circular timer
                  CircularProgress(
                    progress: timer.progress,
                    timeLabel: _formatTime(timer.remainingSeconds),
                  ),
                  const SizedBox(height: 48),

                  // Goal input (only visible when idle)
                  if (timer.isIdle) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        controller: _goalController,
                        style: const TextStyle(color: AppTheme.textPrimary),
                        decoration: const InputDecoration(
                          hintText: "What's your focus for this session?",
                        ),
                        onChanged: (v) =>
                            ref.read(timerProvider.notifier).setGoal(v),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Goal display during session
                  if (!timer.isIdle && timer.goal.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Text(
                        timer.goal,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action buttons
                  _ActionButtons(timer: timer),

                  const Spacer(),

                  // Milestones
                  if (timer.isIdle) ...[
                    MilestoneBar(
                      totalSessions: milestones.totalSessions,
                      currentStreak: milestones.currentStreak,
                    ),
                    const SizedBox(height: 40),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  final TimerState timer;

  const _ActionButtons({required this.timer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(timerProvider.notifier);

    if (timer.isIdle) {
      return _PrimaryButton(
        label: 'START',
        onTap: notifier.start,
      );
    }

    if (timer.isRunning) {
      return _PrimaryButton(
        label: 'PAUSE',
        onTap: notifier.pause,
      );
    }

    if (timer.isPaused) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PrimaryButton(label: 'RESUME', onTap: notifier.start),
          const SizedBox(width: 16),
          _SecondaryButton(label: 'RESET', onTap: notifier.reset),
        ],
      );
    }

    if (timer.phase == TimerPhase.shortBreak && timer.isComplete) {
      return _PrimaryButton(label: 'DONE', onTap: notifier.reset);
    }

    return const SizedBox.shrink();
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.accent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppTheme.background,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SecondaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.accentDim),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppTheme.accentDim,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
