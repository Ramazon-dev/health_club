import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class MultiRingProgress extends StatelessWidget {
  final double progress; // 0.0–1.0
  final double annual;
  final double monthly;
  final double weekly;
  final double nextRank;

  const MultiRingProgress({
    super.key,
    required this.progress,
    required this.annual,
    required this.monthly,
    required this.weekly,
    required this.nextRank,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: _MultiRingPainter(progress,
        annual,
        monthly,
        weekly,
        nextRank,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 70.h),
          child: Text(
            // '',
            '${(progress * 100).toInt()}%',
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500, color: ThemeColors.base950),
          ),
        ),
      ),
    );
  }
}

class _MultiRingPainter extends CustomPainter {
  final double progress;
  final double annual;
  final double monthly;
  final double weekly;
  final double nextRank;

  _MultiRingPainter(this.progress, this.annual, this.monthly, this.weekly, this.nextRank);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset(0, 40));
    final maxRadius = size.width / 3;

    final rings = [
      // внешний зелёный
      _Ring(radius: maxRadius - 6, width: 10, color: const Color(0xFF00C853),progress: annual),
      // жёлтый
      _Ring(radius: maxRadius - 24, width: 10, color: const Color(0xFFFFD740), progress: monthly),
      // синий
      _Ring(radius: maxRadius - 42, width: 10, color: const Color(0xFF2962FF), progress: weekly),
      // внутренний оранжевый
      _Ring(radius: maxRadius - 60, width: 10, color: const Color(0xFFFF8A65), progress: nextRank),
    ];

    // каждый круг рисуем отдельно
    for (final ring in rings) {
      final rect = Rect.fromCircle(center: center, radius: ring.radius);

      final backgroundPaint = Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.width
        ..strokeCap = StrokeCap.round;

      final foregroundPaint = Paint()
        ..color = ring.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = ring.width
        ..strokeCap = StrokeCap.round;

      // серый фон
      canvas.drawArc(rect, -pi / 2, 2 * pi, false, backgroundPaint);

      // видимая часть прогресса
      canvas.drawArc(rect, -pi / 2, 2 * pi * ring.progress, false, foregroundPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Ring {
  final double radius;
  final double width;
  final double progress;
  final Color color;

  _Ring({required this.radius, required this.width, required this.color, required this.progress});
}
