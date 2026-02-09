class LoginResponse {
  LoginResponse({required this.success, required this.isNew, this.hasPassword, this.token});

  final String? success;
  final bool? isNew;
  final bool? hasPassword;
  final String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json["success"].toString(),
      isNew: json["is_new"],
      hasPassword: json["has_password"],
      token: json["token"],
    );
  }
}
