import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../design_system/design_system.dart';

final Dio _dio = Dio();
final Map<String, PlacemarkIconStyle> _iconCache = {};

Future<PlacemarkIconStyle> cachedMarker(String? url) async {
  if (url == null || url.isEmpty) {
    return PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
  }

  if (_iconCache.containsKey(url)) {
    return _iconCache[url]!;
  }

  final icon = await markerFromUrl(imageUrl: url);
  _iconCache[url] = icon;
  return icon;
}

Future<PlacemarkIconStyle> markerFromUrl({required String? imageUrl, int size = 80}) async {
  try {
    /// 1️⃣ Проверка URL
    if (imageUrl == null || imageUrl.trim().isEmpty) {
      return PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
    }

    /// 2️⃣ Скачиваем картинку
    final response = await _dio.get<List<int>>(
      imageUrl,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    if (response.data == null || response.data!.isEmpty) {
      return PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
    }

    final bytes = Uint8List.fromList(response.data!);

    print('object dio bytes ${bytes.lengthInBytes / (1024 * 1024)}');

    /// 3️⃣ Декод + ресайз
    final codec = await ui.instantiateImageCodec(bytes, targetWidth: size, targetHeight: size);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    /// 4️⃣ Circle crop
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final radius = size / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    paint.blendMode = BlendMode.srcIn;
    canvas.drawImage(image, Offset.zero, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size, size);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    final ss = PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()));
    print('object dio place mark is ${ss.isVisible}');
    return ss;
  } catch (e) {
    print('object dio catch exception $e');
    /// 5️⃣ Любая ошибка → fallback
    return PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
  }
}
