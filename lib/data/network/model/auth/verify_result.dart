class VerifyResponse {
  VerifyResponse({required this.token, required this.wizard, required this.step});

  final String? token;
  final bool? wizard;
  final int? step;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResponse(token: json["token"], wizard: json["wizard"], step: json["step"]);
  }
}
