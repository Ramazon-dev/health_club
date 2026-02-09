class ForecastResponse {
  ForecastResponse({
    required this.start,
    required this.target,
    required this.current,
    required this.forecast,
  });

  final CurrentResponse? start;
  final TargetResponse? target;
  final CurrentResponse? current;
  final TargetResponse? forecast;

  factory ForecastResponse.fromJson(Map<String, dynamic> json){
    return ForecastResponse(
      start: json["start"] == null ? null : CurrentResponse.fromJson(json["start"]),
      target: json["target"] == null ? null : TargetResponse.fromJson(json["target"]),
      current: json["current"] == null ? null : CurrentResponse.fromJson(json["current"]),
      forecast: json["forecast"] == null ? null : TargetResponse.fromJson(json["forecast"]),
    );
  }

}

class CurrentResponse {
  CurrentResponse({
    required this.date,
    required this.weightKg,
    required this.fatPercent,
    required this.muscleMassKg,
  });

  final DateTime? date;
  final num? weightKg;
  final num? fatPercent;
  final num? muscleMassKg;

  factory CurrentResponse.fromJson(Map<String, dynamic> json){
    return CurrentResponse(
      date: DateTime.tryParse(json["date"] ?? ""),
      weightKg: json["weight_kg"],
      fatPercent: json["fat_percent"],
      muscleMassKg: json["muscle_mass_kg"],
    );
  }

}

class TargetResponse {
  TargetResponse({
    required this.targetBodyFatPercent,
    required this.targetMuscleMassKg,
    required this.targetTotalWeightKg,
    required this.contractRefundThresholdKg,
  });

  final num? targetBodyFatPercent;
  final num? targetMuscleMassKg;
  final num? targetTotalWeightKg;
  final num? contractRefundThresholdKg;

  factory TargetResponse.fromJson(Map<String, dynamic> json){
    return TargetResponse(
      targetBodyFatPercent: json["target_body_fat_percent"],
      targetMuscleMassKg: json["target_muscle_mass_kg"],
      targetTotalWeightKg: json["target_total_weight_kg"],
      contractRefundThresholdKg: json["contract_refund_threshold_kg"],
    );
  }

}
