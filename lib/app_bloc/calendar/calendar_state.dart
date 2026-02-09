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
  final List<PastResponse> past;
  final List<PastResponse> upcoming;
  final DateTime? selectedDate;
  // final CalendarResponse calendarResponse;
  const CalendarLoaded({required this.past, required this.upcoming, this.selectedDate});
}

final class CalendarError extends CalendarState {
  final String? message;
  const CalendarError(this.message);
}
