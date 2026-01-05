
import 'package:health_club/data/network/provider/main_provider.dart';

import '../../app_bloc.dart';

part 'nutrition_analyze_state.dart';

class NutritionAnalyzeCubit extends Cubit<NutritionAnalyzeState> {
  final MainProvider _mainProvider;
  NutritionAnalyzeCubit(this._mainProvider) : super(NutritionAnalyzeInitial());

  Future<void> analyze() async {
    emit(NutritionAnalyzeLoading());
    final res = await _mainProvider.getNutritionAnalyze();
    final data = res.data;
    if (data != null) {
      emit(NutritionAnalyzeLoaded());
    } else {
      emit(NutritionAnalyzeError(res.message));
    }

  }
}
