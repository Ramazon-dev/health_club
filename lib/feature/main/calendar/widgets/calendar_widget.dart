import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:collection/collection.dart';
import '../../../../data/network/model/calendar_response.dart';

class CalendarWidget extends StatefulWidget {
  final List<PastResponse> upcoming;
  final List<PastResponse> past;

  const CalendarWidget({super.key, required this.upcoming, required this.past});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final ValueNotifier<DateTime> focusedDayNotifier = ValueNotifier(DateTime.now());
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withValues(alpha: 0.06),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ValueListenableBuilder(
        valueListenable: focusedDayNotifier,
        builder: (context, focusedDay, child) => TableCalendar(
          focusedDay: focusedDay,
          locale: 'ru_RU',
          selectedDayPredicate: (day) => isSameDay(day, focusedDay),
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, day) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(day.monthAndYear()),
                // if (!focusedDay.isSameDay(DateTime.now()))
                ButtonWithScale(
                  onPressed: () {
                    context.read<CalendarCubit>().onAllPressed();
                    focusedDayNotifier.value = DateTime.now();
                  },
                  // height: 30.h,
                  verticalPadding: 4.h,
                  horizontalPadding: 20.r,
                  text: 'Все',
                ),
              ],
            ),
            markerBuilder: (context, day, events) {
              final fromPast = widget.past.firstWhereOrNull((element) {
                if (element.date == null) return false;
                return day.isSameDay(element.date!);
              });
              final fromUpcoming = widget.upcoming.firstWhereOrNull((element) {
                if (element.date == null) return false;
                return day.isSameDay(element.date!);
              });
              // if (fromPast == null && fromUpcoming == null) return null;
              if (fromUpcoming != null) {
                return CircleAvatar(radius: 5.r, backgroundColor: Colors.yellow);
              } else if (fromPast != null) {
                return CircleAvatar(radius: 5.r, backgroundColor: Colors.green);
              } else {
                return null;
              }
            },
          ),
          firstDay: now.subtract(Duration(days: 365)),
          lastDay: now.add(Duration(days: 365)),
          headerStyle: HeaderStyle(formatButtonVisible: false),

          onDaySelected: (selectedDay, focusedDay) {
            focusedDayNotifier.value = selectedDay;
            context.read<CalendarCubit>().onDateChanged(selectedDay);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
        ),
      ),
    );
  }
}
