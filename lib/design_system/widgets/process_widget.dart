import 'dart:math';
import 'package:flutter/material.dart';

class ProgressGauge extends StatelessWidget {
  final double progress; // 0.0–1.0
  final int sections;

  const ProgressGauge({
    super.key,
    required this.progress,
    this.sections = 6,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 140),
      painter: _GaugePainter(
        progress: progress.clamp(0, 1),
        sections: sections,
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final int sections;

  _GaugePainter({
    required this.progress,
    required this.sections,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.95);
    final radius = size.width * 0.38;

    const segmentWidth = 42.0;
    const segmentHeight = 26.0;

    final total = progress * sections;
    final fullSegments = total.floor();
    final hasPartial = total - fullSegments > 0.01;

    // дуга снизу: от ~210° до ~330°
    const startAngle = pi + pi / 6;      // 210°
    const endAngle = 2 * pi - pi / 6;    // 330°
    final totalAngle = endAngle - startAngle;
    final step = sections > 1
        ? totalAngle / (sections - 1)
        : 0;

    for (int i = 0; i < sections; i++) {
      final angle = startAngle + step * i;

      // центр сегмента по окружности
      final segCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      Paint paint;
      if (i < fullSegments) {
        paint = Paint()..color = const Color(0xFF0BA39A);
      } else if (i == fullSegments && hasPartial) {
        final rectForShader = Rect.fromCircle(
          center: center,
          radius: radius + segmentHeight,
        );
        paint = Paint()
          ..shader = const LinearGradient(
            colors: [
              Color(0xFF0BA39A),
              Color(0xFFEAF7F6),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(rectForShader);
      } else {
        paint = Paint()..color = Colors.grey.shade300;
      }

      paint
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;

      // ставим систему координат в центр сегмента и
      // крутим так, чтобы капсула шла по касательной к дуге
      canvas.save();
      canvas.translate(segCenter.dx, segCenter.dy);
      canvas.rotate(angle + pi / 2);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: segmentWidth,
        height: segmentHeight,
      );
      final rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(segmentHeight / 2),
      );
      canvas.drawRRect(rrect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.sections != sections;
  }
}
