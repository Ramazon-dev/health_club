import 'package:activity_ring/activity_ring.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/data/network/model/history/metric_history_response.dart';
import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/main/awards/widgets/dashboard_widget.dart';
import 'package:health_club/feature/main/awards/widgets/food_history_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class AwardsPage extends StatefulWidget {
  const AwardsPage({super.key});

  @override
  State<AwardsPage> createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
  static final now = DateTime.now();
  final totalItems = 30;
  // final totalItems = now.difference(DateTime(now.year, now.month, 0)).inDays;
  late final PageController pageController;
  final ValueNotifier<DateTime> selectedDateNotifier = ValueNotifier(DateTime(now.year, now.month, now.day));
  int pageIndex = 0;
  bool hasChanged = false;

  @override
  void initState() {
    pageController = PageController(initialPage: totalItems - 1);
    pageIndex = totalItems - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.base100,
        surfaceTintColor: ThemeColors.base100,
        foregroundColor: ThemeColors.base100,
        centerTitle: true,
        title: Tooltip(
          message: 'sasasasas',
          child: Text(
            'Дневные показатели',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
      ),
      body: BlocBuilder<NutritionHistoryCubit, NutritionHistoryState>(
        builder: (context, nutritionHistoryState) {
          return BlocBuilder<DashboardMetricsCubit, DashboardMetricsState>(
            builder: (context, dashBoardMetricsState) {
              if (dashBoardMetricsState is DashboardMetricsLoaded) {
                final waterNorm = dashBoardMetricsState.dashboardMetrics.water?.norm;
                final sleepNorm = dashBoardMetricsState.dashboardMetrics.sleep?.norm;
                final stepsNorm = dashBoardMetricsState.dashboardMetrics.steps?.norm;
                return BlocBuilder<MetricsHistoryCubit, MetricsHistoryState>(
                  builder: (context, state) {
                    if (state is MetricsHistoryLoaded && nutritionHistoryState is NutritionHistoryLoaded) {
                      final water = state.water;
                      final sleep = state.sleep;
                      final step = state.steps;
                      final nutrition = nutritionHistoryState.nutritionHistory;
                      final now = DateTime.now();
                      // final month = DateTime(now.year, now.month);
                      final month = now.subtract(Duration(days: 30));
                      final waterInMonth = water
                          .where((element) => element.date?.isAfterOrSame(month) == true)
                          .toList()
                          .reversed;
                      final sleepInMonth = sleep
                          .where((element) => element.date?.isAfterOrSame(month) == true)
                          .toList()
                          .reversed;
                      final stepInMonth = step
                          .where((element) => element.date?.isAfterOrSame(month) == true)
                          .toList()
                          .reversed;
                      final nutritionInMonth = nutrition
                          .where((element) => element.date?.isAfterOrSame(month) == true)
                          .toList()
                          .reversed;
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(15.r),
                        child: ValueListenableBuilder(
                          valueListenable: selectedDateNotifier,
                          builder: (context, selectedDate, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    selectedDate.weekFormat(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: selectedDate.subtract(Duration(days: 1)).isAfter(month)
                                        ? () {
                                            selectedDateNotifier.value = selectedDate.subtract(Duration(days: 1));
                                            hasChanged = true;
                                            setState(() {});
                                            pageController.previousPage(
                                              duration: Duration(milliseconds: 600),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_back_ios),
                                  ),
                                  IconButton(
                                    onPressed: selectedDate.add(Duration(days: 1)).isBefore(now)
                                        ? () {
                                            selectedDateNotifier.value = selectedDate.add(Duration(days: 1));
                                            hasChanged = true;
                                            setState(() {});
                                            pageController.nextPage(
                                              duration: Duration(milliseconds: 600),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        : null,
                                    icon: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                              20.height,
                              TableCalendar(
                                focusedDay: selectedDate,
                                firstDay: month,
                                lastDay: now,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                locale: 'ru_RU',
                                selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                                daysOfWeekVisible: true,
                                daysOfWeekHeight: 30.r,
                                calendarStyle: CalendarStyle(),
                                calendarFormat: CalendarFormat.week,
                                headerStyle: HeaderStyle(titleCentered: true),
                                headerVisible: false,
                                // onDaySelected: (selectedDay, focusedDay) {
                                //   print(
                                //     'object page ${pageController.page} on day selected ${selectedDate.difference(focusedDay).inDays} and focusedDay $focusedDay selectedDate $selectedDate',
                                //   );
                                //   // pageController.animateToPage(
                                //   //   pageController.page?.toInt() ?? 0,
                                //   //   duration: Duration(minutes: 200),
                                //   //   curve: Curves.easeInOut,
                                //   // );
                                //   selectedDateNotifier.value = focusedDay;
                                // },
                                calendarBuilders: CalendarBuilders(
                                  dowBuilder: (context, day) {
                                    final isCurrentDay = day.isSameDay(selectedDate);
                                    final isToday = day.isSameDay(now);
                                    if (!isCurrentDay) {
                                      if (isToday) {
                                        return Center(
                                          child: Container(
                                            height: 30.r,
                                            width: 30.r,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey.shade400,
                                            ),
                                            child: Text(
                                              day.shortDayOfWeek(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Text(
                                            day.shortDayOfWeek(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: Container(
                                        height: 30.r,
                                        width: 30.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: ThemeColors.primaryColor,
                                        ),
                                        child: Text(
                                          day.shortDayOfWeek(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  headerTitleBuilder: (context, day) => Row(
                                    children: [
                                      Text(
                                        day.weekFormat(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.baseBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  defaultBuilder: (context, day, focusedDay) {
                                    return rating(
                                      nutritionInMonth: nutritionInMonth,
                                      day: day,
                                      sleepInMonth: sleepInMonth,
                                      stepInMonth: stepInMonth,
                                      waterInMonth: waterInMonth,
                                      sleepNorm: sleepNorm,
                                      waterNorm: waterNorm,
                                      stepsNorm: stepsNorm,
                                    );
                                  },
                                  selectedBuilder: (context, day, focusedDay) {
                                    return rating(
                                      nutritionInMonth: nutritionInMonth,
                                      day: day,
                                      sleepInMonth: sleepInMonth,
                                      stepInMonth: stepInMonth,
                                      waterInMonth: waterInMonth,
                                      sleepNorm: sleepNorm,
                                      waterNorm: waterNorm,
                                      stepsNorm: stepsNorm,
                                      selectedDay: true,
                                    );
                                  },
                                  todayBuilder: (context, day, focusedDay) {
                                    return rating(
                                      nutritionInMonth: nutritionInMonth,
                                      day: day,
                                      sleepInMonth: sleepInMonth,
                                      stepInMonth: stepInMonth,
                                      waterInMonth: waterInMonth,
                                      sleepNorm: sleepNorm,
                                      waterNorm: waterNorm,
                                      stepsNorm: stepsNorm,
                                    );
                                  },
                                  outsideBuilder: (context, day, focusedDay) {
                                    return rating(
                                      nutritionInMonth: nutritionInMonth,
                                      day: day,
                                      sleepInMonth: sleepInMonth,
                                      stepInMonth: stepInMonth,
                                      waterInMonth: waterInMonth,
                                      sleepNorm: sleepNorm,
                                      waterNorm: waterNorm,
                                      stepsNorm: stepsNorm,
                                    );
                                  },
                                  disabledBuilder: (context, day, focusedDay) => SizedBox(),
                                ),
                              ),
                              20.height,
                              SizedBox(
                                height: 320.h,
                                child: PageView.builder(
                                  controller: pageController,
                                  clipBehavior: Clip.none,
                                  itemCount: totalItems,
                                  reverse: false,
                                  onPageChanged: (value) {
                                    if (hasChanged) return;
                                    if (pageIndex < value) {
                                      selectedDateNotifier.value = selectedDate.add(Duration(days: 1));
                                    } else {
                                      selectedDateNotifier.value = selectedDate.subtract(Duration(days: 1));
                                    }
                                    pageIndex = value;
                                  },
                                  itemBuilder: (context, index) {
                                    // final reversedIndex = totalItems - 1 - index;
                                    // final day = DateTime(now.year, now.month, index + 1);

                                    final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: totalItems - (index + 1)));
                                    final water = waterInMonth.firstWhere(
                                      (element) => element.date?.isSameDay(day) == true,
                                      orElse: () => MetricHistoryResponse(date: day, value: 0),
                                    );
                                    final steps = stepInMonth.firstWhere(
                                      (element) => element.date?.isSameDay(day) == true,
                                      orElse: () => MetricHistoryResponse(date: day, value: 0),
                                    );
                                    final sleep = sleepInMonth.firstWhere(
                                      (element) => element.date?.isSameDay(day) == true,
                                      orElse: () => MetricHistoryResponse(date: day, value: 0),
                                    );
                                    final nutrition = nutritionInMonth.firstWhere(
                                      (element) => element.date?.isSameDay(day) == true,
                                      orElse: () =>
                                          NutritionDiaryResponse(date: day, breakfast: null, lunch: null, dinner: null),
                                    );
                                    int nutritionProgress = 0;
                                    if (nutrition.breakfast?.status != 'empty' && nutrition.breakfast?.status != null) {
                                      nutritionProgress += 1;
                                    }
                                    if (nutrition.dinner?.status != 'empty' && nutrition.dinner?.status != null) {
                                      nutritionProgress += 1;
                                    }
                                    if (nutrition.lunch?.status != 'empty' && nutrition.lunch?.status != null) {
                                      nutritionProgress += 1;
                                    }
                                    return DashboardWidget(
                                      isToday: now.isSameDay(day),
                                      stepsPercent: ((steps.value ?? 0) / (stepsNorm ?? 0)) * 100,
                                      stepsText: '${(steps.value ?? 0)}/${(stepsNorm ?? 5000)}',
                                      sleepPercent: ((sleep.value ?? 0) / (sleepNorm ?? 0)) * 100,
                                      sleepText: '${(sleep.value ?? 0)}/${(sleepNorm ?? 3000)}',
                                      foodPercent: (nutritionProgress / 3) * 100,
                                      foodText: '${(nutritionProgress)}/3',
                                      waterPercent: ((water.value ?? 0) / (waterNorm ?? 0)) * 100,
                                      waterText: '${(water.value ?? 0)}/${(waterNorm ?? 3000)}',
                                      waterCurrent: water.value ?? 0,
                                      stepsCurrent: steps.value ?? 0,
                                    );
                                  },
                                ),
                              ),
                              // 20.height,
                              FoodHistoryWidget(nutrition: nutrition, selectedDay: selectedDate),
                              (kBottomNavigationBarHeight).height,
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              } else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }

  Widget rating({
    required Iterable<NutritionDiaryResponse> nutritionInMonth,
    required DateTime day,
    required Iterable<MetricHistoryResponse> waterInMonth,
    required Iterable<MetricHistoryResponse> stepInMonth,
    required Iterable<MetricHistoryResponse> sleepInMonth,
    num? sleepNorm,
    num? stepsNorm,
    num? waterNorm,
    bool selectedDay = false,
  }) {
    final water = waterInMonth.firstWhere(
      (element) => element.date?.isSameDay(day) == true,
      orElse: () => MetricHistoryResponse(date: day, value: 0),
    );
    final steps = stepInMonth.firstWhere(
      (element) => element.date?.isSameDay(day) == true,
      orElse: () => MetricHistoryResponse(date: day, value: 0),
    );
    final sleep = sleepInMonth.firstWhere(
      (element) => element.date?.isSameDay(day) == true,
      orElse: () => MetricHistoryResponse(date: day, value: 0),
    );

    final nutrition = nutritionInMonth.firstWhere(
      (element) => element.date?.isSameDay(day) == true,
      orElse: () => NutritionDiaryResponse(date: day, breakfast: null, lunch: null, dinner: null),
    );
    int nutritionProgress = 0;
    if (nutrition.breakfast?.status != 'empty' && nutrition.breakfast?.status != null) {
      nutritionProgress += 1;
    }
    if (nutrition.dinner?.status != 'empty' && nutrition.dinner?.status != null) {
      nutritionProgress += 1;
    }
    if (nutrition.lunch?.status != 'empty' && nutrition.lunch?.status != null) {
      nutritionProgress += 1;
    }
    final stepsPercent = ((steps.value ?? 0) / (stepsNorm ?? 0)) * 100;
    final sleepPercent = ((sleep.value ?? 0) / (sleepNorm ?? 0)) * 100;
    final waterPercent = ((water.value ?? 0) / (waterNorm ?? 0)) * 100;
    final double checkStepsPercent = stepsPercent > 100 ? 100 : stepsPercent;
    final double checkSleepPercent = sleepPercent > 100 ? 100 : sleepPercent;
    final double checkWaterPercent = waterPercent > 100 ? 100 : waterPercent;
    return Stack(
      children: [
        Ring(
          percent: checkStepsPercent,
          color: RingColorScheme(ringColor: Color(0xffff2222), backgroundColor: Color(0x1AFF2222)),
          width: 4,
          radius: 5,
          center: Offset(0, -25),
        ),
        Ring(
          percent: checkSleepPercent,
          color: RingColorScheme(ringColor: Color(0xff16DC00), backgroundColor: Color(0x1A16DC00)),
          width: 4,
          radius: 10,
          center: Offset(0, -25),
        ),
        Ring(
          percent: (nutritionProgress / 3) * 100,
          color: RingColorScheme(ringColor: Color(0xffFF9533), backgroundColor: Color(0x1AFF9533)),
          width: 4,
          radius: 15,
          center: Offset(0, -25),
        ),
        Ring(
          percent: checkWaterPercent,
          color: RingColorScheme(ringColor: Color(0xff3D84FF), backgroundColor: Color(0x1A3D84FF)),
          width: 4,
          radius: 20,
          center: Offset(0, -25),
        ),
      ],
    );
  }
}
