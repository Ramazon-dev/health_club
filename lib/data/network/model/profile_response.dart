import 'package:health_club/domain/core/core.dart';

class ProfileResponse {
  ProfileResponse({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.avatar,
    required this.goals,
    required this.subscription,
    required this.monthProgress,
  });

  final String? name;
  final String? surname;
  final String? email;
  final String? phone;
  final String? birthday;
  final String? avatar;
  final GoalsResponse? goals;
  final Subscription? subscription;
  final MonthProgress? monthProgress;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      phone: json["phone"],
      birthday: json["birthday"],
      avatar: json["avatar"],
      goals: json["goals"] == null ? null : GoalsResponse.fromJson(json["goals"]),
      subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
      monthProgress: json["month_progress"] == null ? null : MonthProgress.fromJson(json["month_progress"]),
    );
  }
}

class GoalsResponse {
  final List<String> selected;
  final String? customText;

  GoalsResponse({required this.selected, required this.customText});

  factory GoalsResponse.fromJson(Map<String, dynamic> json) {
    return GoalsResponse(
      selected: json["selected"] == null ? [] : List<String>.from(json["selected"]!.map((x) => x)),
      customText: json["custom_text"],
    );
  }
}

class MonthProgress {
  MonthProgress({required this.current, required this.target, required this.percent});

  final int? current;
  final int? target;
  final int? percent;

  factory MonthProgress.fromJson(Map<String, dynamic> json) {
    return MonthProgress(current: json["current"], target: json["target"], percent: json["percent"]);
  }
}

class Subscription {
  Subscription({
    required this.startedAt,
    required this.daysLeft,
    required this.endedAt,
    required this.name,
    this.freezeDaysLeft,
    this.freezeDaysTotal,
    this.isFrozen,
  });

  final DateTime? startedAt;
  final int? daysLeft;
  final int? freezeDaysLeft;
  final int? freezeDaysTotal;
  final DateTime? endedAt;
  final String? name;
  final bool? isFrozen;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      startedAt: (json["started_at"] ?? "").toString().parseFromDate(),
      daysLeft: json["daysLeft"],
      freezeDaysLeft: json["freeze_days_left"],
      freezeDaysTotal: json["freeze_days_total"],
      name: json["name"],
      isFrozen: json["is_frozen"],
      endedAt: (json["ended_at"] ?? "").toString().parseFromDate(),
    );
  }
}
