import 'dart:math' as math;
import 'package:flutter/material.dart';

class HalfCircleProgressBar extends StatelessWidget {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final Widget icon;

  const HalfCircleProgressBar({
    super.key,
    required this.progress,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 6.0,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double checkedProgress = progress > 1 ? 1 : progress;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(136, 68),
          painter: _HalfCirclePainter(
            progress: checkedProgress,
            progressColor: progressColor,
            backgroundColor: backgroundColor,
            strokeWidth: strokeWidth,
          ),
        ),
        Positioned(bottom: 0, child: icon),
      ],
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  _HalfCirclePainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ... ваш существующий код отрисовки арки без изменений ...
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height);

    // Background Arc
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, math.pi, false, backgroundPaint);

    // Progress Arc
    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final double sweepAngle = math.pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _HalfCirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
