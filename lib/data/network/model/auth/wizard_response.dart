class WizardResponse {
  WizardResponse({required this.wizard, required this.step, required this.user});

  final bool? wizard;
  final int? step;
  final UserResponse? user;

  factory WizardResponse.fromJson(Map<String, dynamic> json) {
    return WizardResponse(
      wizard: json["wizard"],
      step: json["step"],
      user: json["data"] == null ? null : UserResponse.fromJson(json["data"]),
    );
  }
}

class UserResponse {
  UserResponse({
    required this.name,
    required this.surname,
    required this.birthday,
    required this.gender,
    required this.height,
    required this.weight,
    required this.address,
    required this.placeId,
    required this.bio,
    required this.training,
  });

  final String? name;
  final String? surname;
  final String? birthday;
  final String? gender;
  final String? height;
  final String? weight;
  final String? address;
  final int? placeId;
  final String? bio;
  final String? training;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      name: json["name"],
      surname: json["surname"],
      birthday: json["birthday"],
      gender: json["gender"],
      height: json["height"],
      weight: json["weight"],
      address: json["address"],
      placeId: json["place_id"],
      bio: json["bio"],
      training: json["training"],
    );
  }
}
