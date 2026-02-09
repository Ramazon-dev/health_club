import '../../../data/network/model/dashboard_metrics_response.dart';
import '../../../data/network/provider/main_provider.dart';
import '../../app_bloc.dart';

part 'dashboard_metrics_state.dart';

class DashboardMetricsCubit extends Cubit<DashboardMetricsState> {
  final MainProvider _mainProvider;

  DashboardMetricsCubit(this._mainProvider) : super(DashboardMetricsInitial()) {
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    emit(DashboardMetricsLoading());
    final res = await _mainProvider.getDashboardMetrics();
    final data = res.data;
    if (data != null) {
      emit(DashboardMetricsLoaded(data));
    } else {
      emit(DashboardMetricsError(res.message));
    }
  }

  Future<void> updateMetrics({
    int? waterML,
    double? sleepHours,
    String? sleepStart,
    String? sleepEnd,
    int? steps,
  }) async {
    if (waterML != null || sleepHours != null || sleepStart != null || sleepEnd != null || steps != null) {
      emit(DashboardMetricsLoading());
      final res = await _mainProvider.updateMetrics(
        water: waterML,
        sleepHours: sleepHours,
        sleepStart: sleepStart,
        sleepEnd: sleepEnd,
        steps: steps,
      );
      if (res.data != null) {
        fetchDashboard();
      } else {
        emit(DashboardMetricsError(res.message));
      }
    }
  }
}
