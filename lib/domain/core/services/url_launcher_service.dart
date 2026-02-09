import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLauncherService {
  // static Future<void> openInAnyMap(double lat, double lng) async {
  //   final availableMaps = await MapLauncher.installedMaps;
  //
  //   if (availableMaps.isNotEmpty) {
  //     // Покажет список карт, установленных у пользователя
  //     await availableMaps.first.showMarker(
  //       coords: Coords(lat, lng),
  //       title: "Место",
  //     );
  //   }
  // }

  static Future<void> openInExternalMap({required double lat, required double long, String? address}) async {
    Uri uri;
    if (Platform.isIOS) {
      uri = Uri.parse( "https://maps.apple.com/?ll=$lat,$long&q=${address ?? ''}");
    } else {
      uri = Uri.parse("geo:$lat,$long?q=$lat,$long(${Uri.encodeComponent(address ?? '')})");
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Something is went wrong');
    }
  }

  static Future<void> openMapWithAddress({required String address}) async {
    final uri = Platform.isAndroid
        ? Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': address})
        : Uri.https('maps.apple.com', '/', {'q': address});
    final bool canOpen = await canLaunchUrl(uri);
    if (canOpen) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> openCalendar(BuildContext context, DateTime date) async {
    Uri url;

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final timestamp = (date.millisecondsSinceEpoch / 1000).round() - 978307200;
      url = Uri.parse('calshow:$timestamp');
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      final timestamp = date.millisecondsSinceEpoch;
      url = Uri.parse('content://com.android.calendar/time/$timestamp');
    } else {
      throw 'Unsupported platform';
    }

    final bool canOpen = await canLaunchUrl(url);
    if (canOpen) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> sentUserByLink(String link) async {
    final url = Uri.parse(link);
    final launch = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!launch) {
      throw Exception('launch cant be sent');
    }
  }

  static Future<void> sentPhone(String phone) async {
    final url = Uri.parse('tel:$phone');
    final launch = await launchUrl(url);
    if (!launch) {
      throw Exception('phone can not be sent');
    }
  }
}
