import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/extensions/date_format.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime selectedMonth = DateTime.now();
  int? selectedDay;
  final Map<String, List<int>> selectedDaysByMonth = {};
  final Map<String, List<int>> autoSelectedDaysByMonth = {};
  DateTime? autoSelectBaseDate;

  List<int> get selectedDays => selectedDaysByMonth[_monthKey(selectedMonth)] ?? [];

  set selectedDays(List<int> days) => selectedDaysByMonth[_monthKey(selectedMonth)] = days;

  List<int> get autoSelectedDays => autoSelectedDaysByMonth[_monthKey(selectedMonth)] ?? [];

  set autoSelectedDays(List<int> days) => autoSelectedDaysByMonth[_monthKey(selectedMonth)] = days;

  List<int> selectedWeekdays = [];
  int weeksCount = 1;

  String _getMonthYearText(DateTime date) {
    return '${date.dateMonth()} ${date.year}';
  }

  List<List<int?>> _generateCalendar(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    List<List<int?>> weeks = [];
    List<int?> currentWeek = [];

    for (int i = 1; i < firstDayWeekday; i++) {
      currentWeek.add(null);
    }
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      currentWeek.add(day);
      if (currentWeek.length == 7) {
        weeks.add(List.from(currentWeek));
        currentWeek.clear();
      }
    }
    while (currentWeek.length < 7) {
      currentWeek.add(null);
    }
    if (currentWeek.isNotEmpty) weeks.add(currentWeek);
    return weeks;
  }

  String _monthKey(DateTime date) => '${date.year}-${date.month}';

  void _updateAutoSelectedDays({int? baseDay}) {
    final List<int> newAutoSelected = [];
    if (selectedWeekdays.isEmpty) {
      autoSelectedDays = [];
      return;
    }
    final lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    DateTime? baseDate;
    if (baseDay != null) {
      baseDate = DateTime(selectedMonth.year, selectedMonth.month, baseDay);
      autoSelectBaseDate = baseDate;
    } else if (autoSelectBaseDate != null) {
      baseDate = autoSelectBaseDate!;
    } else {
      baseDate = DateTime(selectedMonth.year, selectedMonth.month, 1);
    }

    final now = DateTime.now();
    final isCurrentOrFutureMonth =
        selectedMonth.year > now.year || (selectedMonth.year == now.year && selectedMonth.month >= now.month);
    if (!isCurrentOrFutureMonth) {
      autoSelectedDays = [];
      return;
    }

    DateTime startDate = baseDate;
    if (startDate.isBefore(DateTime(selectedMonth.year, selectedMonth.month, 1))) {
      startDate = DateTime(selectedMonth.year, selectedMonth.month, 1);
    }
    if (startDate.isAfter(lastDayOfMonth)) {
      autoSelectedDays = [];
      return;
    }

    for (int week = 0; week < weeksCount; week++) {
      for (int weekday in selectedWeekdays) {
        DateTime weekStart = baseDate.add(Duration(days: week * 7));
        int diff = (weekday + 1) - weekStart.weekday;
        if (diff < 0) diff += 7;
        DateTime candidate = weekStart.add(Duration(days: diff));
        if (candidate.month == selectedMonth.month &&
            candidate.day >= startDate.day &&
            candidate.isAfter(startDate.subtract(const Duration(days: 1))) &&
            candidate.isBefore(lastDayOfMonth.add(const Duration(days: 1)))) {
          if (!newAutoSelected.contains(candidate.day)) {
            newAutoSelected.add(candidate.day);
          }
        }
      }
    }
    newAutoSelected.sort();
    autoSelectedDays = newAutoSelected;
  }

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
      child: _buildCalendarCard(),
    );
  }

  Widget _buildCalendarCard() {
    return Column(
      children: [
        _buildCalendarHeader(),
        SizedBox(height: 20.h),
        _buildWeekDaysRow(),
        Divider(color: ThemeColors.base400, thickness: 0.5),
        SizedBox(height: 16.h),

        ..._generateCalendar(selectedMonth).map(_buildCalendarWeekRow),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    final now = DateTime.now();
    final isFirstMonth = selectedMonth.year == now.year && selectedMonth.month == now.month;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          splashRadius: 24,
          onPressed: isFirstMonth
              ? null
              : () {
                  setState(() {
                    final prevMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
                    if (prevMonth.year < now.year || (prevMonth.year == now.year && prevMonth.month < now.month)) {
                      return;
                    }
                    selectedMonth = prevMonth;
                    selectedDaysByMonth.putIfAbsent(_monthKey(selectedMonth), () => []);
                    autoSelectedDaysByMonth.putIfAbsent(_monthKey(selectedMonth), () => []);
                    _updateAutoSelectedDays();
                  });
                },
          icon: Icon(Icons.chevron_left, color: isFirstMonth ? Color(0xffd4d4d4) : ThemeColors.baseBlack, size: 28),
        ),
        Text(
          _getMonthYearText(selectedMonth),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: ThemeColors.baseBlack,
            letterSpacing: 0.2,
          ),
        ),
        IconButton(
          splashRadius: 24,
          onPressed: () {
            setState(() {
              selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
              selectedDaysByMonth.putIfAbsent(_monthKey(selectedMonth), () => []);
              autoSelectedDaysByMonth.putIfAbsent(_monthKey(selectedMonth), () => []);
              _updateAutoSelectedDays();
            });
          },
          icon: const Icon(Icons.chevron_right, color: ThemeColors.baseBlack, size: 28),
        ),
      ],
    );
  }

  Widget _buildWeekDaysRow() {
    return Row(
      children: DateTime.now().daysOfWeek().map((day) {
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Text(
              day.substring(0,2),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors.baseBlack,
                letterSpacing: 0.1,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarWeekRow(List<int?> week) {
    if (week.any((e) => e == null)) return SizedBox();
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: week.map((day) {
          if (day == null) {
            return Expanded(child: Container(height: 40.h));
          }
          final isToday =
              day == DateTime.now().day &&
              selectedMonth.month == DateTime.now().month &&
              selectedMonth.year == DateTime.now().year;

          final now = DateTime.now();
          final thisDate = DateTime(selectedMonth.year, selectedMonth.month, day);
          final isPast = thisDate.isBefore(DateTime(now.year, now.month, now.day));

          Color? bgColor;
          Color? borderColor;
          Color? textColor;
          if (isToday) {
            bgColor = const Color(0xFF2d9994);
            borderColor = const Color(0xFF7C0AE1);
            textColor = Colors.white;
          } else {
            bgColor = Colors.transparent;
            borderColor = const Color(0xFFE0E0E0);
            textColor = isPast ? const Color(0xFFBDBDBD) : const Color(0xFF242528);
          }

          return Expanded(
            child: GestureDetector(
              onTap: isPast
                  ? null
                  : () {
                      // setState(() {
                      //   if (selectedTemplate == ScheduleTemplate.noTemplate) {
                      //     final days = [...selectedDays];
                      //     if (days.contains(day)) {
                      //       days.remove(day);
                      //     } else {
                      //       days.add(day);
                      //     }
                      //     selectedDays = days;
                      //   } else {
                      //     selectedDay = day;
                      //     autoSelectBaseDate = DateTime(selectedMonth.year, selectedMonth.month, day);
                      //     _updateAutoSelectedDays(baseDay: day);
                      //   }
                      // });
                    },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  // border: Border.all(color: borderColor, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$day',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 14.sp, fontWeight: FontWeight.w400, color: textColor),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
