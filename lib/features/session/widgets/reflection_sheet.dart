import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Bottom sheet for post-session emoji reflection.
class ReflectionSheet extends StatelessWidget {
  final VoidCallback onPositive;
  final VoidCallback onNegative;

  const ReflectionSheet({
    super.key,
    required this.onPositive,
    required this.onNegative,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onPositive,
    required VoidCallback onNegative,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ReflectionSheet(
        onPositive: onPositive,
        onNegative: onNegative,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'HOW WAS YOUR SESSION?',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _EmojiButton(
                emoji: '😊',
                label: 'Great',
                onTap: onPositive,
              ),
              _EmojiButton(
                emoji: '🙁',
                label: 'Tough',
                onTap: onNegative,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _EmojiButton extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _EmojiButton({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
