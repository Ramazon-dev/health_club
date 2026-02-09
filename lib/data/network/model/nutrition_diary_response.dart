import 'package:health_club/domain/core/extensions/date_format.dart';

class NutritionDiaryResponse {
  NutritionDiaryResponse({required this.date, required this.breakfast, required this.lunch, required this.dinner});

  final DateTime? date;
  final BreakfastResponse? breakfast;
  final BreakfastResponse? lunch;
  final BreakfastResponse? dinner;

  factory NutritionDiaryResponse.fromJson(Map<String, dynamic> json) {
    return NutritionDiaryResponse(
      date: (json["date"]).toString().parse(),
      breakfast: json["breakfast"] == null ? null : BreakfastResponse.fromJson(json["breakfast"]),
      lunch: json["lunch"] == null ? null : BreakfastResponse.fromJson(json["lunch"]),
      dinner: json["dinner"] == null ? null : BreakfastResponse.fromJson(json["dinner"]),
    );
  }
}

class BreakfastResponse {
  BreakfastResponse({
    required this.hasPhoto,
    required this.imageUrl,
    required this.images,
    required this.status,
    required this.analysis,
  });

  final bool? hasPhoto;
  final String? imageUrl;
  final List<String>? images;
  final String? status;
  final AnalysisResponse? analysis;

  factory BreakfastResponse.fromJson(Map<String, dynamic> json) {
    return BreakfastResponse(
      hasPhoto: json["has_photo"],
      imageUrl: json["image_url"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      status: json["status"],
      analysis: json["analysis"] == null ? null : AnalysisResponse.fromJson(json["analysis"]),
    );
  }
}

class AnalysisResponse {
  AnalysisResponse({required this.mealsResponse});

  final List<MealsResponse> mealsResponse;

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AnalysisResponse(
      mealsResponse: json["meals"] == null
          ? []
          : List<MealsResponse>.from(json["meals"]!.map((x) => MealsResponse.fromJson(x))),
    );
  }
}

class MealsResponse {
  final bool? isFood;
  final String? name;
  final int? calories;
  final int? protein;
  final int? fat;
  final int? carbs;
  final int? rating;
  final String? verdict;
  final String? status;
  final String? recommendation;
  final String? photoUrl;
  final String? error;

  MealsResponse({
    required this.isFood,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.verdict,
    required this.status,
    required this.rating,
    required this.recommendation,
    required this.photoUrl,
    required this.error,
  });

  factory MealsResponse.fromJson(Map<String, dynamic> json) {
    return MealsResponse(
      isFood: json["is_food"],
      name: json["name"],
      calories: json["calories"],
      protein: json["protein"],
      fat: json["fat"],
      carbs: json["carbs"],
      verdict: json["verdict"],
      status: json["status"],
      recommendation: json["recommendation"],
      photoUrl: json["photo_url"],
      rating: json["rating"],
      error: json["error"],
    );
  }
}
