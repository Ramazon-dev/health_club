class ClubsResponse {
  ClubsResponse({required this.step, required this.clubs});

  final int? step;
  final List<ClubResponse> clubs;

  factory ClubsResponse.fromJson(Map<String, dynamic> json) {
    return ClubsResponse(
      step: json["step"],
      clubs: json["places"] == null
          ? []
          : List<ClubResponse>.from(json["places"]!.map((x) => ClubResponse.fromJson(x))),
    );
  }
}

class ClubResponse {
  ClubResponse({required this.id, required this.title, required this.address, required this.selected});

  final int? id;
  final String? title;
  final String? address;
  final bool? selected;

  factory ClubResponse.fromJson(Map<String, dynamic> json) {
    return ClubResponse(id: json["id"], title: json["title"], address: json["address"], selected: json["selected"]);
  }
}
