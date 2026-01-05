class MetricHistoryResponse {
  MetricHistoryResponse({required this.date, required this.value});

  final String? date;
  final int? value;

  factory MetricHistoryResponse.fromJson(Map<String, dynamic> json) {
    return MetricHistoryResponse(date: json["date"], value: json["value"]);
  }
}
