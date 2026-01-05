import 'package:health_club/data/network/provider/main_provider.dart';

import '../../../data/network/model/history/body_composition_response.dart';
import '../../app_bloc.dart';

part 'body_composition_history_state.dart';

class BodyCompositionHistoryCubit extends Cubit<BodyCompositionHistoryState> {
  final MainProvider _mainProvider;

  BodyCompositionHistoryCubit(this._mainProvider) : super(BodyCompositionHistoryInitial()) {
    fetchBodyComposition();
  }

  Future<void> fetchBodyComposition() async {
    emit(BodyCompositionHistoryLoading());
    final res = await _mainProvider.getBodyCompositionHistory();
    final data = res.data;
    if (data != null) {
      emit(BodyCompositionHistoryLoaded(data));
    } else {
      emit(BodyCompositionHistoryError(res.message));
    }
  }
}
