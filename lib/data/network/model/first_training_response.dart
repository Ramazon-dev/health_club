class FirstTrainingResponse {
  FirstTrainingResponse({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientPhone,
    required this.placeId,
    required this.placeTitle,
    required this.placeAddress,
    required this.date,
    required this.time,
    required this.datetime,
    required this.createdAt,
  });

  final int? id;
  final int? clientId;
  final String? clientName;
  final String? clientPhone;
  final int? placeId;
  final String? placeTitle;
  final String? placeAddress;
  final String? date;
  final String? time;
  final DateTime? datetime;
  final DateTime? createdAt;

  factory FirstTrainingResponse.fromJson(Map<String, dynamic> json) {
    return FirstTrainingResponse(
      id: json["id"],
      clientId: json["client_id"],
      clientName: json["client_name"],
      clientPhone: json["client_phone"],
      placeId: json["place_id"],
      placeTitle: json["place_title"],
      placeAddress: json["place_address"],
      date: json["date"] ?? "",
      time: json["time"],
      datetime: DateTime.tryParse(json["datetime"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}
