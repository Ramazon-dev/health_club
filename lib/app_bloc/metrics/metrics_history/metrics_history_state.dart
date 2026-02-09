part of 'metrics_history_cubit.dart';

sealed class MetricsHistoryState {
  const MetricsHistoryState();
}

final class MetricsHistoryInitial extends MetricsHistoryState {
  const MetricsHistoryInitial();
}

final class MetricsHistoryLoading extends MetricsHistoryState {
  const MetricsHistoryLoading();
}

final class MetricsHistoryLoaded extends MetricsHistoryState {
  final List<MetricHistoryResponse> water;
  final List<MetricHistoryResponse> sleep;
  final List<MetricHistoryResponse> steps;
  const MetricsHistoryLoaded({required this.water, required this.sleep, required this.steps});
}

final class MetricsHistoryError extends MetricsHistoryState {
  final String? message;
  const MetricsHistoryError(this.message);
}
