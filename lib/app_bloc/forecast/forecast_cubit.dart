import 'package:health_club/data/network/model/forecast_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final MainProvider _mainProvider;

  ForecastCubit(this._mainProvider) : super(ForecastInitial()) {
    fetchForecast();
  }

  Future<void> fetchForecast() async {
    emit(ForecastLoading());
    final res = await _mainProvider.getForecast();
    final data = res.data;
    if (data != null) {
      emit(ForecastLoaded(data));
    } else {
      emit(ForecastError(res.message));
    }
  }
}
