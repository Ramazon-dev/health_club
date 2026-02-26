import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

mixin MarkersHelper {
  final Dio _dio = Dio();

  // кеш по url (чтобы не качать одно и то же 100 раз)
  final Map<String, Uint8List> markerBytesCache = {};

  Future<Uint8List?> markerBytesFromUrl(String? url, {int size = 50}) async {
    if (url == null || url.trim().isEmpty) return null;

    final key = url.trim();
    final cached = markerBytesCache[key];
    if (cached != null) return cached;

    try {
      final res = await _dio.get<List<int>>(
        key,
        options: Options(responseType: ResponseType.bytes, receiveTimeout: const Duration(seconds: 8)),
      );

      final bytes = Uint8List.fromList(res.data ?? const []);
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;

      // 1) crop в квадрат по центру
      final minSide = math.min(decoded.width, decoded.height);
      final x = ((decoded.width - minSide) / 2).round();
      final y = ((decoded.height - minSide) / 2).round();
      final square = img.copyCrop(decoded, x: x, y: y, width: minSide, height: minSide);

      // 2) resize в 50x50
      final resized = img.copyResize(square, width: size, height: size);

      // 3) circle mask (прозрачный фон снаружи)
      final out = img.Image(width: size, height: size);
      final r = size / 2;

      for (int yy = 0; yy < size; yy++) {
        for (int xx = 0; xx < size; xx++) {
          final dx = xx + 0.5 - r;
          final dy = yy + 0.5 - r;
          if (dx * dx + dy * dy <= r * r) {
            out.setPixel(xx, yy, resized.getPixel(xx, yy));
          } else {
            out.setPixelRgba(xx, yy, 0, 0, 0, 0); // прозрачность
          }
        }
      }

      final png = Uint8List.fromList(img.encodePng(out));
      markerBytesCache[key] = png;
      return png;
    } catch (_) {
      return null;
    }
  }

  final Map<String, Uint8List> _markerBytesCache = {};

  Future<Uint8List?> markerCircleBytesFromUrl(String? url, {int size = 50}) async {
    if (url == null || url.trim().isEmpty) return null;

    final key = '$url?resize=50'.trim();
    final cached = _markerBytesCache[key];
    if (cached != null) return cached;

    try {
      print('object map view markerCircleBytesFromUrl url is $key');
      final res = await _dio.get<List<int>>(
        key,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 8),
          sendTimeout: const Duration(seconds: 8),
        ),
      );

      final bytes = Uint8List.fromList(res.data ?? const []);
      final src = img.decodeImage(bytes);
      if (src == null) return null;

      // 1) center crop в квадрат
      final minSide = math.min(src.width, src.height);
      final x = ((src.width - minSide) / 2).round();
      final y = ((src.height - minSide) / 2).round();
      final square = img.copyCrop(src, x: x, y: y, width: minSide, height: minSide);

      // 2) resize до нужного размера
      final resized = img.copyResize(square, width: size, height: size);

      // 3) делаем результат с RGBA (ВАЖНО: numChannels: 4)
      final out = img.Image(width: size, height: size, numChannels: 4);

      final r = size / 2.0;
      final r2 = r * r;

      for (int yy = 0; yy < size; yy++) {
        for (int xx = 0; xx < size; xx++) {
          final dx = (xx + 0.5) - r;
          final dy = (yy + 0.5) - r;
          final inside = (dx * dx + dy * dy) <= r2;

          if (inside) {
            out.setPixel(xx, yy, resized.getPixel(xx, yy));
          } else {
            // прозрачный пиксель снаружи круга
            out.setPixelRgba(xx, yy, 0, 0, 0, 0);
          }
        }
      }

      final png = Uint8List.fromList(img.encodePng(out));
      _markerBytesCache[key] = png;
      return png;
    } catch (_) {
      return null;
    }
  }
}
