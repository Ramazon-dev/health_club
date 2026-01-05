class BodyCompositionHistoryResponse {
  BodyCompositionHistoryResponse({required this.date, required this.bodyCompositions});

  final String? date;
  final List<BodyCompositionItemResponse> bodyCompositions;

  factory BodyCompositionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BodyCompositionHistoryResponse(
      date: json["date"],
      bodyCompositions: json["items"] == null
          ? []
          : List<BodyCompositionItemResponse>.from(json["items"]!.map((x) => BodyCompositionItemResponse.fromJson(x))),
    );
  }
}

class BodyCompositionItemResponse {
  BodyCompositionItemResponse({
    required this.id,
    required this.weight,
    required this.fatPercent,
    required this.muscleMass,
    required this.visceralFat,
    required this.metabolicAge,
    required this.fileUrl,
  });

  final int? id;
  final String? weight;
  final String? fatPercent;
  final String? muscleMass;
  final String? visceralFat;
  final String? metabolicAge;
  final dynamic fileUrl;

  factory BodyCompositionItemResponse.fromJson(Map<String, dynamic> json) {
    return BodyCompositionItemResponse(
      id: json["id"],
      weight: json["weight"],
      fatPercent: json["fat_percent"],
      muscleMass: json["muscle_mass"],
      visceralFat: json["visceral_fat"],
      metabolicAge: json["metabolic_age"],
      fileUrl: json["file_url"],
    );
  }
}
