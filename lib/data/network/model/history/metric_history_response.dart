import 'package:health_club/domain/core/core.dart';

class MetricHistoryResponse {
  MetricHistoryResponse({required this.date, required this.value});

  final DateTime? date;
  final num? value;

  factory MetricHistoryResponse.fromJson(Map<String, dynamic> json) {
    return MetricHistoryResponse(date: (json["date"]).toString().parse(), value: json["value"]);
  }
}
