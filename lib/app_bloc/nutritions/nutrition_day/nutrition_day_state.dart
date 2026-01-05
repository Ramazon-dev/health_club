part of 'nutrition_day_cubit.dart';

sealed class NutritionDayState {
  const NutritionDayState();
}

final class NutritionDayInitial extends NutritionDayState {
  const NutritionDayInitial();
}

final class NutritionDayLoading extends NutritionDayState {
  const NutritionDayLoading();
}

final class NutritionDayLoaded extends NutritionDayState {
  final NutritionDiaryResponse nutrition;
  const NutritionDayLoaded(this.nutrition);
}

final class NutritionDayError extends NutritionDayState {
  final String? message;
  const NutritionDayError(this.message);
}
