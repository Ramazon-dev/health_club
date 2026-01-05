part of 'calendar_cubit.dart';

sealed class CalendarState {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

final class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

final class CalendarLoaded extends CalendarState {
  final CalendarResponse calendarResponse;
  const CalendarLoaded(this.calendarResponse);
}

final class CalendarError extends CalendarState {
  final String? message;
  const CalendarError(this.message);
}
