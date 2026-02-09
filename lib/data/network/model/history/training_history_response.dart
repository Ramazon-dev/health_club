import 'package:health_club/domain/core/core.dart';

class TrainingHistoryResponse {
  TrainingHistoryResponse({required this.date, required this.trainings});

  final DateTime? date;
  final List<TrainingHistoryItemResponse> trainings;

  factory TrainingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TrainingHistoryResponse(
      date: (json["date"]).toString().parse() ?? DateTime.now(),
      trainings: json["items"] == null
          ? []
          : List<TrainingHistoryItemResponse>.from(json["items"]!.map((x) => TrainingHistoryItemResponse.fromJson(x))),
    );
  }
}

class TrainingHistoryItemResponse {
  TrainingHistoryItemResponse({
    required this.id,
    required this.timeRange,
    required this.type,
    required this.club,
    required this.trainer,
  });

  final int? id;
  final String? timeRange;
  final String? type;
  final String? club;
  final String? trainer;

  factory TrainingHistoryItemResponse.fromJson(Map<String, dynamic> json) {
    return TrainingHistoryItemResponse(
      id: json["id"],
      timeRange: json["time_range"],
      type: json["type"],
      club: json["club"],
      trainer: json["trainer"],
    );
  }
}
