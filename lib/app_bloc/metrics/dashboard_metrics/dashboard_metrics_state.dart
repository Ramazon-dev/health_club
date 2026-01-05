part of 'dashboard_metrics_cubit.dart';

sealed class DashboardMetricsState {
  const DashboardMetricsState();
}

final class DashboardMetricsInitial extends DashboardMetricsState {
  const DashboardMetricsInitial();
}

final class DashboardMetricsLoading extends DashboardMetricsState {
  const DashboardMetricsLoading();
}

final class DashboardMetricsLoaded extends DashboardMetricsState {
  final DashboardMetricsResponse dashboardMetrics;
  const DashboardMetricsLoaded(this.dashboardMetrics);
}

final class DashboardMetricsError extends DashboardMetricsState {
  final String? message;
  const DashboardMetricsError(this.message);
}
