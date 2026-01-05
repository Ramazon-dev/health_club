import 'package:health_club/data/network/provider/main_provider.dart';

import '../../data/network/model/calendar_response.dart';
import '../app_bloc.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final MainProvider _mainProvider;

  CalendarCubit(this._mainProvider) : super(CalendarInitial()) {
    fetchCalendar();
  }

  Future<void> fetchCalendar() async {
    emit(CalendarLoading());
    final res = await _mainProvider.getCalendar();
    final data = res.data;
    if (data != null) {
      emit(CalendarLoaded(data));
    } else {
      emit(CalendarError(res.message));
    }
  }
}
