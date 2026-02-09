class SlotResponse {
  SlotResponse({
    required this.id,
    required this.time,
    required this.spots,
    required this.availableSpots,
    required this.title,
    required this.hasClientReservation,
    required this.clientReservationId,
  });

  final int? id;
  final String? time;
  final int? spots;
  final int? availableSpots;
  final String? title;
  final bool? hasClientReservation;
  final int? clientReservationId;

  factory SlotResponse.fromJson(Map<String, dynamic> json) {
    return SlotResponse(
      id: json["id"],
      time: json["time"],
      spots: json["spots"],
      availableSpots: json["available_spots"],
      title: json["title"],
      hasClientReservation: json["has_client_reservation"],
      clientReservationId: json["client_reservation_id"],
    );
  }
}
