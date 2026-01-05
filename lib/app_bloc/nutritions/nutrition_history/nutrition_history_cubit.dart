import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import '../../../data/network/provider/main_provider.dart';
import '../../app_bloc.dart';

part 'nutrition_history_state.dart';

class NutritionHistoryCubit extends Cubit<NutritionHistoryState> {
  final MainProvider _mainProvider;

  NutritionHistoryCubit(this._mainProvider) : super(NutritionHistoryInitial()) {
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    emit(NutritionHistoryLoading());
    final res = await _mainProvider.getNutritionHistory();
    final data = res.data;
    if (data != null) {
      emit(NutritionHistoryLoaded(data));
    } else {
      emit(NutritionHistoryError(res.message));
    }
  }
}
