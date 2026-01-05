part of 'daily_metrics_cubit.dart';

sealed class DailyMetricsState {
  const DailyMetricsState();
}

final class DailyMetricsInitial extends DailyMetricsState {
  const DailyMetricsInitial();
}

final class DailyMetricsLoading extends DailyMetricsState {
  const DailyMetricsLoading();
}

final class DailyMetricsLoaded extends DailyMetricsState {
  final DailyMetricsResponse dailyMetrics;
  const DailyMetricsLoaded(this.dailyMetrics);
}

final class DailyMetricsError extends DailyMetricsState {
  final String? message;
  const DailyMetricsError(this.message);
}
