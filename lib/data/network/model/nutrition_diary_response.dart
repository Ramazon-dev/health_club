class NutritionDiaryResponse {
  NutritionDiaryResponse({
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  final String? date;
  final BreakfastResponse? breakfast;
  final BreakfastResponse? lunch;
  final BreakfastResponse? dinner;

  factory NutritionDiaryResponse.fromJson(Map<String, dynamic> json){
    return NutritionDiaryResponse(
      date: json["date"],
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
    required this.status,
    required this.analysis,
  });

  final bool? hasPhoto;
  final String? imageUrl;
  final String? status;
  final AnalysisResponse? analysis;

  factory BreakfastResponse.fromJson(Map<String, dynamic> json){
    return BreakfastResponse(
      hasPhoto: json["has_photo"],
      imageUrl: json["image_url"],
      status: json["status"],
      analysis: json["analysis"] == null ? null : AnalysisResponse.fromJson(json["analysis"]),
    );
  }

}

class AnalysisResponse {
  AnalysisResponse({
    required this.isFood,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.verdict,
    required this.status,
  });

  final bool? isFood;
  final String? name;
  final int? calories;
  final int? protein;
  final int? fat;
  final int? carbs;
  final String? verdict;
  final String? status;

  factory AnalysisResponse.fromJson(Map<String, dynamic> json){
    return AnalysisResponse(
      isFood: json["is_food"],
      name: json["name"],
      calories: json["calories"],
      protein: json["protein"],
      fat: json["fat"],
      carbs: json["carbs"],
      verdict: json["verdict"],
      status: json["status"],
    );
  }

}
