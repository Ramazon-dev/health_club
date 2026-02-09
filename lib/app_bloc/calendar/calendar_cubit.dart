import 'package:health_club/data/network/provider/main_provider.dart';

import '../../data/network/model/calendar_response.dart';
import '../app_bloc.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final MainProvider _mainProvider;

  CalendarCubit(this._mainProvider) : super(CalendarInitial()) {
    fetchCalendar();
  }

  // CalendarResponse? calendarResponse;
  List<PastResponse>? past;
  List<PastResponse>? upcoming;

  Future<void> fetchCalendar() async {
    emit(CalendarLoading());
    final res = await _mainProvider.getCalendar();
    final data = res.data;
    if (data != null) {
      // calendarResponse = data;
      past = data.past;
      upcoming = data.upcoming;
      emit(CalendarLoaded(past: data.past, upcoming: data.upcoming));
    } else {
      emit(CalendarError(res.message));
    }
  }

  void onDateChanged(DateTime date) {
    final pastData = past;
    final upcomingData = upcoming;
    print('object onDateChanged $pastData and $upcomingData');
    if (pastData != null && upcomingData != null) {
      emit(CalendarLoaded(past: pastData, upcoming: upcomingData, selectedDate: date));
    }
    //   emit(
    //     CalendarLoaded(
    //       past: pastData.where((element) => element.id == data.id).toList(),
    //       upcoming: upcomingData.where((element) => element.id == data.id).toList(),
    //     ),
    //   );
    // }
  }

  void onAllPressed() {
    final pastData = past;
    final upcomingData = upcoming;
    if (pastData != null && upcomingData != null) {
      emit(CalendarLoaded(past: pastData, upcoming: upcomingData, selectedDate: null));
    }
    // emit(CalendarLoading());
    // final pastData = past;
    // final upcomingData = upcoming;
    // if (pastData != null && upcomingData != null) {
    //   emit(CalendarLoaded(past: pastData, upcoming: upcomingData));
    // }
  }
}
