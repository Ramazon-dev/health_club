import 'package:health_club/data/network/model/user_country_enum.dart';
import 'package:hive_ce/hive.dart';

class LocalStorage {
  final Box _rawBox;

  LocalStorage(this._rawBox);

  String getBaseUrl() {
    return _rawBox.get('baseUrl', defaultValue: AppCountryEnum.uz.baseUrl);
  }

  String getCountry() {
    return _rawBox.get('country', defaultValue: AppCountryEnum.uz.name);
  }

  void setBaseUrl(String baseUrl) {
    _rawBox.put('baseUrl', baseUrl);
  }

  void setCountry(String country) {
    _rawBox.put('country', country);
  }
}
