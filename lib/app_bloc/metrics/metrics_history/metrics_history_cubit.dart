import '../../../data/network/model/history/metric_history_response.dart';
import '../../../data/network/provider/main_provider.dart';
import '../../app_bloc.dart';

part 'metrics_history_state.dart';

class MetricsHistoryCubit extends Cubit<MetricsHistoryState> {
  final MainProvider _mainProvider;

  MetricsHistoryCubit(this._mainProvider) : super(MetricsHistoryInitial()) {
    fetchMetricsHistory();
  }

  Future<void> fetchMetricsHistory() async {
    List<MetricHistoryResponse> water = [];
    List<MetricHistoryResponse> sleep = [];
    List<MetricHistoryResponse> steps = [];
    emit(MetricsHistoryLoading());
    final waterRes = await _mainProvider.getMetricsHistory('water');
    if (waterRes.data != null) water = waterRes.data ?? [];
    final sleepRes = await _mainProvider.getMetricsHistory('sleep');
    if (sleepRes.data != null) sleep = sleepRes.data ?? [];
    final stepsRes = await _mainProvider.getMetricsHistory('steps');
    if (stepsRes.data != null) steps = stepsRes.data ?? [];
    emit(MetricsHistoryLoaded(water: water, steps: steps, sleep: sleep));
    // emit(MetricsHistoryError(res.message));
  }
}
