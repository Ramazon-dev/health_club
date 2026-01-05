import 'dart:io';

import 'package:dio/dio.dart';

class ProfileRequest {
  final String name;
  final String surname;
  final String phone;
  final String? email;
  final String? birthday;
  final File? file;

  ProfileRequest({
    required this.name,
    required this.surname,
    required this.phone,
    this.email,
    this.birthday,
    this.file,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['surname'] = surname;
    map['phone'] = phone;
    if (email != null) map['email'] = email;
    if (birthday != null) map['birthday'] = birthday;
    // if (file != null) map['avatar'] = file;
    return map;
  }
}
