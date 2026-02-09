import 'dart:io';
import 'package:health_club/data/network/provider/main_provider.dart';
import '../../../data/network/model/nutrition_diary_response.dart';
import '../../app_bloc.dart';

part 'nutrition_day_state.dart';

class NutritionDayCubit extends Cubit<NutritionDayState> {
  final MainProvider _mainProvider;

  NutritionDayCubit(this._mainProvider) : super(NutritionDayInitial()) {
    fetchNutrition();
  }

  Future<void> fetchNutrition() async {
    emit(NutritionDayLoading());
    final res = await _mainProvider.getNutritionDay();
    final data = res.data;
    if (data != null) {
      emit(NutritionDayLoaded(data));
    } else {
      emit(NutritionDayError(res.message));
    }
  }

  Future<void> upload({required File file, required String type, required String title, required String text}) async {
    emit(NutritionDayLoading());
    final res = await _mainProvider.uploadNutrition(image: file, type: type, title: title, text: text);
    final data = res.data;
    if (data != null) {
      fetchNutrition();
    } else {
      emit(NutritionDayError(res.message));
    }
  }
}
