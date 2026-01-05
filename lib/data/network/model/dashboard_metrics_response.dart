class DashboardMetricsResponse {
  DashboardMetricsResponse({required this.water, required this.sleep, required this.steps});

  final SleepResponse? water;
  final SleepResponse? sleep;
  final SleepResponse? steps;

  factory DashboardMetricsResponse.fromJson(Map<String, dynamic> json) {
    return DashboardMetricsResponse(
      water: json["water"] == null ? null : SleepResponse.fromJson(json["water"]),
      sleep: json["sleep"] == null ? null : SleepResponse.fromJson(json["sleep"]),
      steps: json["steps"] == null ? null : SleepResponse.fromJson(json["steps"]),
    );
  }
}

class SleepResponse {
  SleepResponse({
    required this.current,
    required this.norm,
    required this.unit,
    required this.status,
    required this.statusText,
    required this.period,
  });

  final num? current;
  final num? norm;
  final String? unit;
  final String? status;
  final String? statusText;
  final String? period;

  factory SleepResponse.fromJson(Map<String, dynamic> json) {
    return SleepResponse(
      current: json["current"],
      norm: json["norm"],
      unit: json["unit"],
      status: json["status"],
      statusText: json["status_text"],
      period: json["period"],
    );
  }
}
