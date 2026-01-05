class DailyMetricsResponse {
  DailyMetricsResponse({required this.waterMl, required this.sleepHours, required this.steps});

  final num? waterMl;
  final num? sleepHours;
  final num? steps;

  factory DailyMetricsResponse.fromJson(Map<String, dynamic> json) {
    return DailyMetricsResponse(waterMl: json["water_ml"], sleepHours: json["sleep_hours"], steps: json["steps"]);
  }
}
