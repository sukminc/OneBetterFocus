import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CircularProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String timeLabel;
  final double size;

  const CircularProgress({
    super.key,
    required this.progress,
    required this.timeLabel,
    this.size = 260,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ArcPainter(progress: progress),
          ),
          Text(
            timeLabel,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 3.0;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppTheme.progressTrack
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = AppTheme.accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.progress != progress;
}
