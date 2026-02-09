import 'map_detail_response.dart';

class MapPointResponse {
  MapPointResponse({
    required this.id,
    required this.type,
    required this.title,
    required this.address,
    required this.lat,
    required this.long,
    required this.rating,
    required this.reviewsCount,
    required this.workHours,
    required this.imageUrl,
    required this.isOpen,
    required this.category,
    required this.distance,
  });

  final int? id;
  final String? type;
  final String? title;
  final String? address;
  final String? lat;
  final String? long;
  final double? rating;
  final int? reviewsCount;
  final List<WorkingHourResponse> workHours;
  final String? imageUrl;
  final bool? isOpen;
  final String? category;
  final double? distance;

  factory MapPointResponse.fromJson(Map<String, dynamic> json) {
    return MapPointResponse(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      address: json["address"],
      lat: json["lat"],
      long: json["long"],
      rating: json["rating"],
      reviewsCount: json["reviews_count"],
      workHours: json["work_hours"] == null
          ? []
          : (json["work_hours"] is Map<String, dynamic>)
          ? List<WorkingHourResponse>.from(json["work_hours"]!.map((x) => WorkingHourResponse.fromJson(x)))
          : [],
      imageUrl: json["image_url"],
      isOpen: json["is_open"],
      category: json["category"],
      distance: json["distance"],
    );
  }

  MapPointResponse copyWith({double? distance}) {
    return MapPointResponse(
      id: id,
      type: type,
      title: title,
      address: address,
      lat: lat,
      long: long,
      rating: rating,
      reviewsCount: reviewsCount,
      workHours: workHours,
      imageUrl: imageUrl,
      isOpen: isOpen,
      category: category,
      distance: distance ?? this.distance,
    );
  }
}

class WorkHours {
  final String? start;
  final String? end;

  WorkHours({this.start, this.end});

  factory WorkHours.fromJson(Map<String, dynamic> json) {
    return WorkHours(start: json['start'] as String?, end: json['end'] as String?);
  }
}

class WorkHoursMapResponse {
  final Map<String, WorkHours> workHours;

  WorkHoursMapResponse({required this.workHours});

  factory WorkHoursMapResponse.fromJson(Map<String, dynamic> json) {
    var workHoursMap = json['work_hours'] as Map<String, dynamic>;
    Map<String, WorkHours> schedule = {};

    workHoursMap.forEach((day, hours) {
      if (hours != null && (hours is Map<String, dynamic> && hours.isNotEmpty)) {
        schedule[day] = WorkHours.fromJson(hours);
      } else {
        schedule[day] = WorkHours(start: '', end: '');
      }
    });

    return WorkHoursMapResponse(workHours: schedule);
  }
}
