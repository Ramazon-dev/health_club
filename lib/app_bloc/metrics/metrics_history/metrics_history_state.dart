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
  final List<MetricHistoryResponse> metricsHistory;
  const MetricsHistoryLoaded(this.metricsHistory);
}

final class MetricsHistoryError extends MetricsHistoryState {
  final String? message;
  const MetricsHistoryError(this.message);
}
