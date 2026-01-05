class FreezeHistoryResponse {
  FreezeHistoryResponse({required this.id, required this.startDate, required this.endDate});

  final int? id;
  final String? startDate;
  final String? endDate;

  factory FreezeHistoryResponse.fromJson(Map<String, dynamic> json) {
    return FreezeHistoryResponse(id: json["id"], startDate: json["start_date"], endDate: json["end_date"]);
  }
}
