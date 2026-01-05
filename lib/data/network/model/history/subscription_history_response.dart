class SubscriptionHistoryResponse {
  SubscriptionHistoryResponse({required this.date, required this.subscriptionHistory});

  final String? date;
  final List<SubscriptionHistoryItem> subscriptionHistory;

  factory SubscriptionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionHistoryResponse(
      date: json["date"],
      subscriptionHistory: json["items"] == null
          ? []
          : List<SubscriptionHistoryItem>.from(json["items"]!.map((x) => SubscriptionHistoryItem.fromJson(x))),
    );
  }
}

class SubscriptionHistoryItem {
  SubscriptionHistoryItem({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.currency,
    required this.status,
    required this.statusColor,
    required this.fileUrl,
  });

  final int? id;
  final String? title;
  final String? startDate;
  final dynamic endDate;
  final int? price;
  final String? currency;
  final String? status;
  final String? statusColor;
  final String? fileUrl;

  factory SubscriptionHistoryItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionHistoryItem(
      id: json["id"],
      title: json["title"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      price: json["price"],
      currency: json["currency"],
      status: json["status"],
      statusColor: json["status_color"],
      fileUrl: json["file_url"],
    );
  }
}
