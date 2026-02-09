class CalendarResponse {
  CalendarResponse({required this.upcoming, required this.past});

  final List<PastResponse> upcoming;
  final List<PastResponse> past;

  factory CalendarResponse.fromJson(Map<String, dynamic> json) {
    return CalendarResponse(
      upcoming: json["upcoming"] == null
          ? []
          : List<PastResponse>.from(json["upcoming"]!.map((x) => PastResponse.fromJson(x))),
      past: json["past"] == null ? [] : List<PastResponse>.from(json["past"]!.map((x) => PastResponse.fromJson(x))),
    );
  }

  CalendarResponse copyWith({List<PastResponse>? upcoming, List<PastResponse>? past}) {
    return CalendarResponse(upcoming: upcoming ?? this.upcoming, past: past ?? this.past);
  }
}

class PastResponse {
  PastResponse({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.datetimeStart,
    required this.location,
    required this.status,
    required this.canCancel,
    required this.canReschedule,
  });

  final int? id;
  final String? type;
  final String? title;
  final String? subtitle;
  final DateTime? date;
  final String? timeStart;
  final String? timeEnd;
  final DateTime? datetimeStart;
  final String? location;
  final String? status;
  final bool? canCancel;
  final bool? canReschedule;

  factory PastResponse.fromJson(Map<String, dynamic> json) {
    return PastResponse(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      subtitle: json["subtitle"],
      date: DateTime.tryParse(json["date"] ?? ""),
      timeStart: json["time_start"],
      timeEnd: json["time_end"],
      datetimeStart: DateTime.tryParse(json["datetime_start"] ?? ""),
      location: json["location"],
      status: json["status"],
      canCancel: json["can_cancel"],
      canReschedule: json["can_reschedule"],
    );
  }
}
