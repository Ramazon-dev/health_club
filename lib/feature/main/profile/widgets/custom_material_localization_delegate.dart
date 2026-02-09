import 'package:flutter/material.dart';

class CustomMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return _CustomMaterialLocalizations();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class _CustomMaterialLocalizations extends DefaultMaterialLocalizations {
  @override
  String get saveButtonLabel => 'Подтвердить';
}
