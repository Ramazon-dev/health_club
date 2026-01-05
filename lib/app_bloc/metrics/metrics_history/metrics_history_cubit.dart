
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
    emit(MetricsHistoryLoading());
    final res = await _mainProvider.getMetricsHistory();
    final data = res.data;
    if (data != null) {
      emit(MetricsHistoryLoaded(data));
    } else {
      emit(MetricsHistoryError(res.message));
    }
  }

}
