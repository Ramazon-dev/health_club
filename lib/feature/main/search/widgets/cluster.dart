import 'dart:typed_data';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';


/// Класс для отрисовки кластеров на карте
class ClusterIconPainter {
  const ClusterIconPainter(this.clusterSize);


  /// Количество маркеров в кластере
  final int clusterSize;


  /// Метод, который формирует фигуру кластера
  /// и преобразует ее в байтовый формат
  Future<Uint8List> getClusterIconBytes() async {
    const size = Size(65, 65);
    final recorder = PictureRecorder();


    // отрисовка маркера
    _paintTextCountPlacemarks(
      text: clusterSize.toString(),
      size: size,
      canvas: _paintCirclePlacemark(
        size: size,
        recorder: recorder,
      ),
    );


    // преобразование в байтовый формат
    final image = await recorder.endRecording().toImage(
      size.width.toInt(),
      size.height.toInt(),
    );
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);


    return pngBytes!.buffer.asUint8List();
  }
}


/// Метод, который отрисовывает фигуру кластера (фон и обводка)
Canvas _paintCirclePlacemark({
  required Size size,
  required PictureRecorder recorder,
}) {
  final canvas = Canvas(recorder);


  final radius = size.height / 2.15;


  // внутренний круг - закрашенная часть маркера
  final fillPaint = Paint()
    ..color = ThemeColors.base100
    ..style = PaintingStyle.fill;


  // внешний круг - обводка маркера
  final strokePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8;


  final circleOffset = Offset(size.height / 2, size.width / 2);


  canvas
    ..drawCircle(circleOffset, radius, fillPaint)
    ..drawCircle(circleOffset, radius, strokePaint);
  return canvas;
}


/// Метод, который отрисовывает текст,
/// отображающий количество маркеров в кластере
void _paintTextCountPlacemarks({
  required String text,
  required Size size,
  required Canvas canvas,
}) {
  // внешний вид текста, отображающего количество маркеров в кластере
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        color: ThemeColors.baseBlack,
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: size.width);


  // смещение текста
  // необходимо для размещения текста по центру кластера
  final textOffset = Offset(
    (size.width - textPainter.width) / 2,
    (size.height - textPainter.height) / 2,
  );
  textPainter.paint(canvas, textOffset);
}
