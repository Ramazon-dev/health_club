part of 'nutrition_history_cubit.dart';

sealed class NutritionHistoryState {
  const NutritionHistoryState();
}

final class NutritionHistoryInitial extends NutritionHistoryState {
  const NutritionHistoryInitial();
}

final class NutritionHistoryLoading extends NutritionHistoryState {
  const NutritionHistoryLoading();
}

final class NutritionHistoryLoaded extends NutritionHistoryState {
  final List<NutritionDiaryResponse> nutritionHistory;
  const NutritionHistoryLoaded(this.nutritionHistory);
}

final class NutritionHistoryError extends NutritionHistoryState {
  final String? message;
  const NutritionHistoryError(this.message);
}
