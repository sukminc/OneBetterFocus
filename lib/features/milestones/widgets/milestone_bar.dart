import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MilestoneBar extends StatelessWidget {
  final int totalSessions;
  final int currentStreak;

  const MilestoneBar({
    super.key,
    required this.totalSessions,
    required this.currentStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Stat(label: 'SESSIONS', value: totalSessions.toString()),
        Container(
          width: 1,
          height: 28,
          color: AppTheme.progressTrack,
          margin: const EdgeInsets.symmetric(horizontal: 28),
        ),
        _Stat(
          label: 'STREAK',
          value: currentStreak > 0 ? '🔥 $currentStreak' : '0',
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
