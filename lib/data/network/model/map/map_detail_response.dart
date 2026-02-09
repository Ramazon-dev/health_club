import 'package:collection/collection.dart';

class MapDetailResponse {
  MapDetailResponse({required this.success, required this.data});

  final bool? success;
  final MapDetailDataResponse? data;

  factory MapDetailResponse.fromJson(Map<String, dynamic> json) {
    return MapDetailResponse(
      success: json["success"],
      data: json["data"] == null ? null : MapDetailDataResponse.fromJson(json["data"]),
    );
  }
}

class MapDetailDataResponse {
  MapDetailDataResponse({
    required this.id,
    required this.type,
    required this.title,
    required this.address,
    required this.lat,
    required this.long,
    required this.distance,
    required this.avatar,
    required this.imageUrl,
    required this.isOpen,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.contacts,
    required this.workHours,
    required this.gallery,
    required this.trainers,
    required this.services,
    required this.reviews,
    required this.otherBranches,
  });

  final int? id;
  final String? type;
  final String? title;
  final String? address;
  final String? lat;
  final String? long;
  final double? distance;
  final String? avatar;
  final String? imageUrl;
  final bool? isOpen;
  final double? rating;
  final int? reviewsCount;
  final String? description;
  final ContactsResponse? contacts;
  final List<WorkingHourResponse> workHours;
  final List<String> gallery;
  final List<TrainerResponse> trainers;
  final List<ServiceResponse> services;
  final List<ReviewResponse> reviews;
  final List<OtherBranchResponse> otherBranches;

  factory MapDetailDataResponse.fromJson(Map<String, dynamic> json) {
    return MapDetailDataResponse(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      address: json["address"],
      lat: json["lat"],
      long: json["long"],
      distance: json["distance"],
      avatar: json["avatar"],
      imageUrl: json["image_url"],
      isOpen: json["is_open"],
      rating: json["rating"],
      reviewsCount: json["reviews_count"],
      description: json["description"],
      contacts: json["contacts"] == null ? null : ContactsResponse.fromJson(json["contacts"]),
      workHours: json["work_hours"] == null
          ? []
          : List<WorkingHourResponse>.from(json["work_hours"]!.map((x) => WorkingHourResponse.fromJson(x))),
      gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
      trainers: json["trainers"] == null
          ? []
          : List<TrainerResponse>.from(json["trainers"]!.map((x) => TrainerResponse.fromJson(x))),
      services: json["services"] == null
          ? []
          : List<ServiceResponse>.from(json["services"]!.map((x) => ServiceResponse.fromJson(x))),
      reviews: json["reviews"] == null
          ? []
          : List<ReviewResponse>.from(json["reviews"]!.map((x) => ServiceResponse.fromJson(x))),
      otherBranches: json["other_branches"] == null
          ? []
          : List<OtherBranchResponse>.from(json["other_branches"]!.map((x) => OtherBranchResponse.fromJson(x))),
    );
  }

  MapDetailDataResponse copyWith({double? distance, List<OtherBranchResponse>? otherBranches}) {
    return MapDetailDataResponse(
      id: id,
      type: type,
      title: title,
      address: address,
      lat: lat,
      long: long,
      distance: distance ?? this.distance,
      avatar: avatar,
      imageUrl: imageUrl,
      isOpen: isOpen,
      rating: rating,
      reviewsCount: reviewsCount,
      description: description,
      contacts: contacts,
      workHours: workHours,
      gallery: gallery,
      trainers: trainers,
      services: services,
      reviews: reviews,
      otherBranches: otherBranches ?? this.otherBranches,
    );
  }
}

class ContactsResponse {
  ContactsResponse({required this.phone, required this.instagram, required this.web});

  final String? phone;
  final String? instagram;
  final String? web;

  factory ContactsResponse.fromJson(Map<String, dynamic> json) {
    return ContactsResponse(phone: json["phone"], instagram: json["instagram"], web: json["web"]);
  }
}

class ServiceResponse {
  ServiceResponse({required this.id, required this.title});

  final int? id;
  final String? title;

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(id: json["id"], title: json["title"]);
  }
}

class TrainerResponse {
  TrainerResponse({required this.id, required this.name, required this.avatar, required this.position});

  final int? id;
  final String? name;
  final String? avatar;
  final String? position;

  factory TrainerResponse.fromJson(Map<String, dynamic> json) {
    return TrainerResponse(id: json["id"], name: json["name"], avatar: json["avatar"], position: json["position"]);
  }
}

class WorkingHourResponse {
  WorkingHourResponse({required this.day, required this.time});

  final WorkHourEnum? day;
  final String? time;

  factory WorkingHourResponse.fromJson(Map<String, dynamic> json) {
    return WorkingHourResponse(day: getDay(json["day"]), time: json["time"]);
  }

  static WorkHourEnum? getDay(String day) {
    return WorkHourEnum.values.firstWhereOrNull((element) => element.name == day);
  }
}

enum WorkHourEnum {
  monday('Понедельник'),
  tuesday('Вторник'),
  wednesday('Среда'),
  thursday('Четверг'),
  friday('Пятница'),
  saturday('Суббота'),
  sunday('Воскресенье');

  final String name;

  const WorkHourEnum(this.name);
}

class OtherBranchResponse {
  OtherBranchResponse({
    required this.id,
    required this.type,
    required this.partnerType,
    required this.title,
    required this.address,
    required this.lat,
    required this.long,
    required this.distance,
    required this.avatar,
    required this.rating,
    required this.reviewsCount,
    required this.isOpen,
  });

  final int? id;
  final String? type;
  final String? partnerType;
  final String? title;
  final String? address;
  final String? lat;
  final String? long;
  final double? distance;
  final String? avatar;
  final double? rating;
  final int? reviewsCount;
  final bool? isOpen;

  factory OtherBranchResponse.fromJson(Map<String, dynamic> json) {
    return OtherBranchResponse(
      id: json["id"],
      type: json["type"],
      partnerType: json["partner_type"],
      title: json["title"],
      address: json["address"],
      lat: json["lat"],
      long: json["long"],
      distance: json["distance"],
      avatar: json["avatar"],
      rating: json["rating"],
      reviewsCount: json["reviews_count"],
      isOpen: json["is_open"],
    );
  }

  OtherBranchResponse copyWith({double? distance}) {
    return OtherBranchResponse(
      id: id,
      type: type,
      partnerType: partnerType,
      title: title,
      address: address,
      lat: lat,
      long: long,
      distance: distance ?? this.distance,
      avatar: avatar,
      rating: rating,
      reviewsCount: reviewsCount,
      isOpen: isOpen,
    );
  }
}

class ReviewResponse {
  ReviewResponse({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final int? id;
  final String? userName;
  final num? rating;
  final String? comment;
  final String? date;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      id: json["id"],
      userName: json["user_name"],
      rating: json["rating"],
      comment: json["comment"],
      date: json["date"],
    );
  }
}
