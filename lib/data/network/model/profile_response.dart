import 'package:health_club/domain/core/core.dart';

class ProfileResponse {
  ProfileResponse({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.avatar,
    required this.goal,
    required this.subscription,
    required this.monthProgress,
  });

  final String? name;
  final String? surname;
  final String? email;
  final String? phone;
  final String? birthday;
  final String? avatar;
  final String? goal;
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
      goal: json["goal"],
      subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
      monthProgress: json["month_progress"] == null ? null : MonthProgress.fromJson(json["month_progress"]),
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
  Subscription({required this.startedAt, required this.daysLeft, required this.endedAt});

  final DateTime? startedAt;
  final int? daysLeft;
  final DateTime? endedAt;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      startedAt: (json["started_at"] ?? "").toString().tryParse(),
      daysLeft: json["daysLeft"],
      endedAt: (json["ended_at"] ?? "").toString().tryParse(),
    );
  }
}
