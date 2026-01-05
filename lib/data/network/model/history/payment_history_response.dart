class PaymentHistoryResponse {
  PaymentHistoryResponse({
    required this.date,
    required this.items,
  });

  final String? date;
  final List<PaymentHistoryDate> items;

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json){
    return PaymentHistoryResponse(
      date: json["date"],
      items: json["items"] == null ? [] : List<PaymentHistoryDate>.from(json["items"]!.map((x) => PaymentHistoryDate.fromJson(x))),
    );
  }

}

class PaymentHistoryDate {
  PaymentHistoryDate({
    required this.id,
    required this.title,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.time,
  });

  final int? id;
  final String? title;
  final int? amount;
  final String? currency;
  final String? paymentMethod;
  final String? time;

  factory PaymentHistoryDate.fromJson(Map<String, dynamic> json){
    return PaymentHistoryDate(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      currency: json["currency"],
      paymentMethod: json["payment_method"],
      time: json["time"],
    );
  }

}
