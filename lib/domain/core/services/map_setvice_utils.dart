import 'package:geolocator/geolocator.dart';
import '../../../data/network/model/lat_long.dart';

mixin MapServiceUtils {
  static double distanceBetween(LatLng userPoint, LatLng markersPoint) {
    return Geolocator.distanceBetween(userPoint.lat, userPoint.lng, markersPoint.lat, markersPoint.lng);
  }

  static Future<bool?> requestLocationPermission() async {
    LocationPermission permission;
    bool? isUserAllowed = false;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      isUserAllowed = false;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) isUserAllowed = false;
    }
    if (permission == LocationPermission.deniedForever) {
      return isUserAllowed = null;
    } else if (permission == LocationPermission.unableToDetermine) {
      return isUserAllowed = true;
    } else if (permission == LocationPermission.always) {
      return isUserAllowed = true;
    } else if (permission == LocationPermission.whileInUse) {
      return isUserAllowed = true;
    } else {
      return isUserAllowed;
    }
  }

  static Future<LatLng?> getUserPosition() async {
    final bool? isAllowed = await MapServiceUtils.requestLocationPermission();
    if (isAllowed == true) {
      try {
        final Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
        );
        return LatLng(lat: position.latitude, lng: position.longitude);
      } on LocationServiceDisabledException {
        return null;
      }
    } else {
      await Geolocator.openLocationSettings();
      return null;
    }
  }

  static Future<bool> sentUserToAppSetting() async {
    return Geolocator.openAppSettings();
  }
}
