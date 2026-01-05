part of 'nutrition_analyze_cubit.dart';

sealed class NutritionAnalyzeState {
  const NutritionAnalyzeState();
}

final class NutritionAnalyzeInitial extends NutritionAnalyzeState {
  const NutritionAnalyzeInitial();
}

final class NutritionAnalyzeLoading extends NutritionAnalyzeState {
  const NutritionAnalyzeLoading();
}

final class NutritionAnalyzeLoaded extends NutritionAnalyzeState {
  const NutritionAnalyzeLoaded();
}

final class NutritionAnalyzeError extends NutritionAnalyzeState {
  final String? message;
  const NutritionAnalyzeError(this.message);
}
