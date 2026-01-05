class LoginResponse {
  LoginResponse({required this.success, required this.isNew});

  final String? success;
  final bool? isNew;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(success: json["success"].toString(), isNew: json["is_new"]);
  }
}
