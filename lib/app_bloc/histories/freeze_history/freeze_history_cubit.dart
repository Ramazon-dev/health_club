import 'package:health_club/data/network/model/history/freeze_history_response.dart';

import '../../../data/network/provider/main_provider.dart';
import '../../app_bloc.dart';

part 'freeze_history_state.dart';

class FreezeHistoryCubit extends Cubit<FreezeHistoryState> {
  final MainProvider _mainProvider;

  FreezeHistoryCubit(this._mainProvider) : super(FreezeHistoryInitial()) {
    fetchFreezeHistory();
  }

  Future<void> fetchFreezeHistory() async {
    emit(FreezeHistoryLoading());
    final res = await _mainProvider.getFreezeHistory();
    final data = res.data;
    if (data != null) {
      emit(FreezeHistoryLoaded(data));
    } else {
      emit(FreezeHistoryError(res.message));
    }
  }

  Future<void> freezeSubscription(int days, String startDate) async {
    emit(FreezeHistoryLoading());
    final res = await _mainProvider.freezeSubscription(days, startDate);
    final data = res.data;
    if (data != null) {
      await fetchFreezeHistory();
    } else {
      emit(FreezeHistoryError(res.message));
    }

  }
}
