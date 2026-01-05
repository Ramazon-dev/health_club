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
  });

  final int? id;
  final String? type;
  final String? title;
  final String? address;
  final String? lat;
  final String? long;
  final double? rating;
  final int? reviewsCount;
  final String? workHours;
  final String? imageUrl;
  final bool? isOpen;
  final String? category;

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
      workHours: json["work_hours"],
      imageUrl: json["image_url"],
      isOpen: json["is_open"],
      category: json["category"],
    );
  }
}
