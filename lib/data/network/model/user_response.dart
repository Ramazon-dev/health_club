class UserMeResponse {
  UserMeResponse({
    required this.places,
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.inPlace,
    // required this.level,
    required this.levelVisit,
    required this.isLoyality,
    required this.subscription,
    required this.reservations,
    required this.plus,
    required this.debitorDate,
  });

  final List<String> places;
  final int? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? gender;
  final int? inPlace;
  // final Level? level;
  final int? levelVisit;
  final int? isLoyality;
  final UserSubscription? subscription;
  final List<dynamic> reservations;
  final int? plus;
  final DebitorDate? debitorDate;

  factory UserMeResponse.fromJson(Map<String, dynamic> json) {
    return UserMeResponse(
      places: json["places"] == null ? [] : List<String>.from(json["places"]!.map((x) => x)),
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      gender: json["gender"],
      inPlace: json["in_place"],
      // level: json["level"] == null ? null : Level.fromJson(json["level"]),
      levelVisit: json["level_visit"],
      isLoyality: json["is_loyality"],
      subscription: json["subscription"] == null ? null : UserSubscription.fromJson(json["subscription"]),
      reservations: json["reservations"] == null ? [] : List<dynamic>.from(json["reservations"]!.map((x) => x)),
      plus: json["plus"],
      debitorDate: json["debitor_date"] == null ? null : DebitorDate.fromJson(json["debitor_date"]),
    );
  }
}

class DebitorDate {
  DebitorDate({required this.date, required this.status});

  final dynamic date;
  final int? status;

  factory DebitorDate.fromJson(Map<String, dynamic> json) {
    return DebitorDate(date: json["date"], status: json["status"]);
  }
}

class Level {
  Level({required this.title, required this.total});

  final String? title;
  final int? total;

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(title: json["title"], total: json["total"]);
  }
}

class UserSubscription {
  UserSubscription({
    required this.id,
    required this.membershipId,
    required this.name,
    required this.daysLeft,
    required this.daysFreeze,
    required this.status,
    required this.startAt,
    required this.membership,
    required this.freezes,
    required this.freeze,
    required this.plusDays,
  });

  final int? id;
  final int? membershipId;
  final String? name;
  final int? daysLeft;
  final int? daysFreeze;
  final int? status;
  final DateTime? startAt;
  final Membership? membership;
  final List<dynamic> freezes;
  final dynamic freeze;
  final int? plusDays;

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      id: json["id"],
      membershipId: json["membership_id"],
      name: json["name"],
      daysLeft: json["daysLeft"],
      daysFreeze: json["daysFreeze"],
      status: json["status"],
      startAt: DateTime.tryParse(json["start_at"] ?? ""),
      membership: json["membership"] == null ? null : Membership.fromJson(json["membership"]),
      freezes: json["freezes"] == null ? [] : List<dynamic>.from(json["freezes"]!.map((x) => x)),
      freeze: json["freeze"],
      plusDays: json["plus_days"],
    );
  }
}

class Membership {
  Membership({required this.id, required this.title, required this.byVisit});

  final int? id;
  final String? title;
  final int? byVisit;

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(id: json["id"], title: json["title"], byVisit: json["by_visit"]);
  }
}
