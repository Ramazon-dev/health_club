import 'package:health_club/data/network/model/daily_metrics_response.dart';

import '../../../data/network/provider/main_provider.dart';
import '../../app_bloc.dart';

part 'daily_metrics_state.dart';

class DailyMetricsCubit extends Cubit<DailyMetricsState> {
  final MainProvider _mainProvider;

  DailyMetricsCubit(this._mainProvider) : super(DailyMetricsInitial()) {
    fetchDailyMetrics();
  }

  Future<void> fetchDailyMetrics() async {
    emit(DailyMetricsLoading());
    final res = await _mainProvider.getDailyMetrics();
    final data = res.data;
    if (data != null) {
      emit(DailyMetricsLoaded(data));
    } else {
      emit(DailyMetricsError(res.message));
    }
  }
}
