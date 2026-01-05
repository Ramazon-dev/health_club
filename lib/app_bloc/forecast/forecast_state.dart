part of 'forecast_cubit.dart';

sealed class ForecastState {
  const ForecastState();
}

final class ForecastInitial extends ForecastState {
  const ForecastInitial();
}

final class ForecastLoading extends ForecastState {
  const ForecastLoading();
}

final class ForecastLoaded extends ForecastState {
  final ForecastResponse forecast;
  const ForecastLoaded(this.forecast);
}

final class ForecastError extends ForecastState {
  final String? error;
  const ForecastError(this.error);
}
