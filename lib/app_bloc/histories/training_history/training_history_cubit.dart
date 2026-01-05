import 'package:health_club/data/network/provider/main_provider.dart';

import '../../../data/network/model/history/training_history_response.dart';
import '../../app_bloc.dart';

part 'training_history_state.dart';

class TrainingHistoryCubit extends Cubit<TrainingHistoryState> {
  final MainProvider _mainProvider;

  TrainingHistoryCubit(this._mainProvider) : super(TrainingHistoryInitial()) {
    fetchTraining();
  }

  Future<void> fetchTraining() async {
    emit(TrainingHistoryLoading());
    final res = await _mainProvider.getTrainingHistory();
    final data = res.data;
    if (data != null) {
      emit(TrainingHistoryLoaded(data));
    } else {
      emit(TrainingHistoryError(res.message));
    }
  }
}
