import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/feature/main/profile/widgets/daily_metrics_bottom_sheet.dart';
import 'package:health_club/feature/main/profile/widgets/half_circle_progress_bar.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../domain/core/core.dart';
import '../../../../router/app_router.gr.dart';

class DailyMetricsWidget extends StatefulWidget {
  const DailyMetricsWidget({super.key});

  @override
  State<DailyMetricsWidget> createState() => _DailyMetricsWidgetState();
}

class _DailyMetricsWidgetState extends State<DailyMetricsWidget> {
  int foodEating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionDayCubit, NutritionDayState>(
      listener: (context, state) {
        if (state is NutritionDayLoaded) {
          foodEating = 0;
          if (state.nutrition.breakfast?.imageUrl != null) {
            foodEating += 1;
          }
          if (state.nutrition.lunch?.imageUrl != null) {
            foodEating += 1;
          }
          if (state.nutrition.dinner?.imageUrl != null) {
            foodEating += 1;
          }
        }
      },
      builder: (context, nutritionState) {
        return BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
          listener: (context, state) async {
            if (state is DashboardMetricsLoaded) {
              context.read<MetricsHistoryCubit>().fetchMetricsHistory();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 155.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: InkWell(
                            onTap: () async {
                              final tabsRouter = context.tabsRouter;
                              final result = await context.router.push(DailyReportRoute());
                              if (result == 'setActiveIndex') {
                                tabsRouter.setActiveIndex(3);
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Еда',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    10.width,
                                    Icon(Icons.arrow_forward_ios, size: 15.r, color: ThemeColors.base400),
                                  ],
                                ),
                                8.height,
                                HalfCircleProgressBar(
                                  progress: foodEating / 3,
                                  progressColor: Color(0xffff2222),
                                  backgroundColor: Color(0x1AFF2222),
                                  icon: Image.asset(AppAssets.foodPng, height: 42.r, width: 42.r),
                                ),
                                8.height,
                                Text(
                                  '$foodEating/3',
                                  style: TextStyle(
                                    color: ThemeColors.baseBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              final waterController = TextEditingController();
                              final dashboardMetricsCubit = context.read<DashboardMetricsCubit>();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DailyMetricsBottomSheet(
                                  controller: waterController,
                                  title: 'Выпито воды (мл)',
                                  onPressed: () async {
                                    final waterCurrent = (state is DashboardMetricsLoaded)
                                        ? (state.dashboardMetrics.water?.current ?? 0)
                                        : 0;
                                    if (waterCurrent > 10000) {
                                      context.router.maybePop();
                                      await CustomSneakBar.show(
                                        context: context,
                                        status: SneakBarStatus.warning,
                                        title: 'Потребление более 10000 МЛ воды в день опасно для здоровья',
                                      );
                                      return;
                                    }
                                    await dashboardMetricsCubit.updateMetrics(
                                      waterML: int.tryParse(waterController.text),
                                    );
                                  },
                                ),
                                // builder: (context) {
                                //   return SizedBox(
                                //     height: 0.7.sh,
                                //     child: BottomSheetWidget(
                                //       widgets: [
                                //         Text(
                                //           'Заполните данные за текущий день',
                                //           style: TextStyle(
                                //             color: ThemeColors.baseBlack,
                                //             fontSize: 18.sp,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //         20.height,
                                //         Align(
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Выпито воды (мл)',
                                //             style: TextStyle(
                                //               color: ThemeColors.baseBlack,
                                //               fontSize: 16.sp,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ),
                                //         5.height,
                                //         TextFormField(
                                //           autofocus: true,
                                //           controller: waterController,
                                //           keyboardType: TextInputType.number,
                                //           decoration: InputDecoration(hintText: '0'),
                                //         ),
                                //         // Spacer(),
                                //         40.height,
                                //         Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             ButtonWithScale(
                                //               width: 0.45.sw,
                                //               height: 60.h,
                                //               color: ThemeColors.base100,
                                //               onPressed: () {
                                //                 context.router.maybePop();
                                //               },
                                //               text: 'Отмена',
                                //               textStyle: TextStyle(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w500,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                                //               listener: (context, state) async {
                                //                 final router = context.router;
                                //                 if (state is DashboardMetricsLoaded) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.success,
                                //                     title: 'Дневной отчет успешно изменен!',
                                //                   );
                                //                 } else if (state is DashboardMetricsError) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.error,
                                //                     title: state.message ?? 'Что-то пошло не так',
                                //                   );
                                //                 }
                                //               },
                                //               builder: (context, state) => ButtonWithScale(
                                //                 isLoading: state is DashboardMetricsLoading,
                                //                 width: 0.45.sw,
                                //                 height: 60.h,
                                //                 onPressed: () async {
                                //                   await dashboardMetricsCubit.updateMetrics(
                                //                     waterML: int.tryParse(waterController.text),
                                //                   );
                                //                 },
                                //                 text: 'Сохранить',
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   );
                                // },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Вода',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    10.width,
                                    Icon(Icons.arrow_forward_ios, size: 15.r, color: ThemeColors.base400),
                                  ],
                                ),
                                8.height,
                                HalfCircleProgressBar(
                                  progress: (state is DashboardMetricsLoaded)
                                      ? ((state.dashboardMetrics.water?.current ?? 0) /
                                            (state.dashboardMetrics.water?.norm ?? 0))
                                      : (0 / 2500),
                                  progressColor: Color(0xff3D84FF),
                                  backgroundColor: Color(0x1A3D84FF),
                                  icon: Image.asset(AppAssets.waterPng, height: 42.r, width: 42.r),
                                ),
                                8.height,
                                Text(
                                  (state is DashboardMetricsLoaded)
                                      ? '${state.dashboardMetrics.water?.current ?? 0}/${state.dashboardMetrics.water?.norm ?? 0}'
                                      : '0/2500',
                                  style: TextStyle(
                                    color: ThemeColors.baseBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.height,
                SizedBox(
                  height: 155.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              final stepsController = TextEditingController();
                              final dashboardMetricsCubit = context.read<DashboardMetricsCubit>();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DailyMetricsBottomSheet(
                                  controller: stepsController,
                                  title: 'Шаги (за сегодня)',
                                  onPressed: () async {
                                    final stepsCurrent = (state is DashboardMetricsLoaded)
                                        ? (state.dashboardMetrics.steps?.current ?? 0)
                                        : 0;
                                    if (stepsCurrent < 20000) {
                                      await dashboardMetricsCubit.updateMetrics(
                                        steps: int.tryParse(stepsController.text),
                                      );
                                    } else if (stepsCurrent > 20000 && stepsCurrent < 50000) {
                                      context.router.maybePop();
                                      await CustomSneakBar.show(
                                        context: context,
                                        status: SneakBarStatus.warning,
                                        title:
                                            'Риск травм\nЦель выше 20 000 шагов перегружает суставы. Будьте осторожны и выбирайте правильную обувь.',
                                      );
                                      await dashboardMetricsCubit.updateMetrics(
                                        steps: int.tryParse(stepsController.text),
                                      );
                                    } else if (stepsCurrent > 50000) {
                                      context.router.maybePop();
                                      await CustomSneakBar.show(
                                        context: context,
                                        status: SneakBarStatus.error,
                                        maxLines: 4,
                                        title:
                                            'Опасная нагрузка!\n50 000 шагов — это экстремальный стресс для сердца и организма.',
                                      );
                                    }
                                  },
                                ),
                                // builder: (context) {
                                //   return SizedBox(
                                //     height: 0.7.sh,
                                //     child: BottomSheetWidget(
                                //       widgets: [
                                //         Text(
                                //           'Заполните данные за текущий день',
                                //           style: TextStyle(
                                //             color: ThemeColors.baseBlack,
                                //             fontSize: 18.sp,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //         20.height,
                                //         Align(
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Шаги (за сегодня)',
                                //             style: TextStyle(
                                //               color: ThemeColors.baseBlack,
                                //               fontSize: 16.sp,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ),
                                //         5.height,
                                //         TextFormField(
                                //           autofocus: true,
                                //           controller: stepsController,
                                //           keyboardType: TextInputType.number,
                                //           decoration: InputDecoration(hintText: '0'),
                                //         ),
                                //         // Spacer(),
                                //         40.height,
                                //         Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             ButtonWithScale(
                                //               width: 0.45.sw,
                                //               height: 60.h,
                                //               color: ThemeColors.base100,
                                //               onPressed: () {
                                //                 context.router.maybePop();
                                //               },
                                //               text: 'Отмена',
                                //               textStyle: TextStyle(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w500,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                                //               listener: (context, state) async {
                                //                 final router = context.router;
                                //                 if (state is DashboardMetricsLoaded) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.success,
                                //                     title: 'Дневной отчет успешно изменен!',
                                //                   );
                                //                 } else if (state is DashboardMetricsError) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.error,
                                //                     title: state.message ?? 'Что-то пошло не так',
                                //                   );
                                //                 }
                                //               },
                                //               builder: (context, state) => ButtonWithScale(
                                //                 isLoading: state is DashboardMetricsLoading,
                                //                 width: 0.45.sw,
                                //                 height: 60.h,
                                //                 onPressed: () async {
                                //                   await dashboardMetricsCubit.updateMetrics(
                                //                     steps: int.tryParse(stepsController.text),
                                //                   );
                                //                 },
                                //                 text: 'Сохранить',
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   );
                                // },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Шаги',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    10.width,
                                    Icon(Icons.arrow_forward_ios, size: 15.r, color: ThemeColors.base400),
                                  ],
                                ),
                                8.height,
                                HalfCircleProgressBar(
                                  progress: (state is DashboardMetricsLoaded)
                                      ? ((state.dashboardMetrics.steps?.current ?? 0) /
                                            (state.dashboardMetrics.steps?.norm ?? 0))
                                      : (0 / 10000),
                                  progressColor: Color(0xffFF9533),
                                  backgroundColor: Color(0x1AFF9533),
                                  icon: Image.asset(AppAssets.stepsPng, height: 42.r, width: 42.r),
                                ),
                                8.height,
                                Text(
                                  (state is DashboardMetricsLoaded)
                                      ? '${state.dashboardMetrics.steps?.current ?? 0}/${state.dashboardMetrics.steps?.norm ?? 0}'
                                      : '0/10 000',
                                  style: TextStyle(
                                    color: ThemeColors.baseBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: InkWell(
                            onTap: () async {
                              String? start;
                              String? end;
                              final sleepController = TextEditingController();
                              final dashboardMetricsCubit = context.read<DashboardMetricsCubit>();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DailyMetricsBottomSheet(
                                  controller: sleepController,
                                  title: 'Сон (часы)',
                                  onPressed: () async {
                                    final startTime = start;
                                    final endTime = end;
                                    if (startTime == null || endTime == null) return;
                                    await dashboardMetricsCubit.updateMetrics(
                                      sleepHours: double.tryParse(sleepController.text),
                                      sleepStart: startTime,
                                      sleepEnd: endTime,
                                    );
                                  },
                                  sleepDuration: () async {
                                    // some();
                                    TimeRange? result = await showTimeRangePicker(
                                      context: context,
                                      strokeWidth: 4,
                                      ticks: 12,
                                      ticksOffset: 2,
                                      ticksLength: 8,
                                      handlerRadius: 8,
                                      ticksColor: Colors.grey,
                                      rotateLabels: false,
                                      labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
                                          .asMap()
                                          .entries
                                          .map((e) {
                                            return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                                          })
                                          .toList(),
                                      labelOffset: 30,
                                      padding: 55,
                                      interval: Duration(minutes: 30),
                                      minDuration: Duration(minutes: 30),
                                      labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
                                      start: const TimeOfDay(hour: 22, minute: 0),
                                      end: const TimeOfDay(hour: 6, minute: 0),
                                      clockRotation: 180.0,
                                    );
                                    if (result == null) return;
                                    final calculate = calculateSleep(
                                      bedTime: result.startTime,
                                      wakeTime: result.endTime,
                                    );
                                    start = result.startTime.toHHmm();
                                    end = result.endTime.toHHmm();
                                    sleepController.text = calculate.toString();
                                  },
                                ),
                                // builder: (context) {
                                //   return SizedBox(
                                //     height: 0.7.sh,
                                //     child: BottomSheetWidget(
                                //       widgets: [
                                //         Text(
                                //           'Заполните данные за текущий день',
                                //           style: TextStyle(
                                //             color: ThemeColors.baseBlack,
                                //             fontSize: 18.sp,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //         20.height,
                                //         Align(
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             'Сон (часы)',
                                //             style: TextStyle(
                                //               color: ThemeColors.baseBlack,
                                //               fontSize: 16.sp,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ),
                                //         5.height,
                                //         InkWell(
                                //           onTap: () async {
                                //             // some();
                                //             TimeRange? result = await showTimeRangePicker(
                                //               context: context,
                                //               strokeWidth: 4,
                                //               ticks: 12,
                                //               ticksOffset: 2,
                                //               ticksLength: 8,
                                //               handlerRadius: 8,
                                //               ticksColor: Colors.grey,
                                //               rotateLabels: false,
                                //               labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
                                //                   .asMap()
                                //                   .entries
                                //                   .map((e) {
                                //                     return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                                //                   })
                                //                   .toList(),
                                //               labelOffset: 30,
                                //               padding: 55,
                                //               interval: Duration(minutes: 30),
                                //               minDuration: Duration(minutes: 30),
                                //               labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
                                //               start: const TimeOfDay(hour: 22, minute: 0),
                                //               end: const TimeOfDay(hour: 6, minute: 0),
                                //               clockRotation: 180.0,
                                //             );
                                //             if (result == null) return;
                                //             final calculate = calculateSleep(
                                //               bedTime: result.startTime,
                                //               wakeTime: result.endTime,
                                //             );
                                //             start = result.startTime.toHHmm();
                                //             end = result.endTime.toHHmm();
                                //             sleepController.text = calculate.toString();
                                //           },
                                //           child: TextFormField(
                                //             autofocus: true,
                                //             enabled: false,
                                //             controller: sleepController,
                                //             keyboardType: TextInputType.number,
                                //             decoration: InputDecoration(hintText: '0'),
                                //           ),
                                //         ),
                                //         // Spacer(),
                                //         40.height,
                                //         Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             ButtonWithScale(
                                //               width: 0.45.sw,
                                //               height: 60.h,
                                //               color: ThemeColors.base100,
                                //               onPressed: () {
                                //                 context.router.maybePop();
                                //               },
                                //               text: 'Отмена',
                                //               textStyle: TextStyle(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w500,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                                //               listener: (context, state) async {
                                //                 final router = context.router;
                                //                 if (state is DashboardMetricsLoaded) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.success,
                                //                     title: 'Дневной отчет успешно изменен!',
                                //                   );
                                //                 } else if (state is DashboardMetricsError) {
                                //                   router.maybePop();
                                //                   await CustomSneakBar.show(
                                //                     context: context,
                                //                     status: SneakBarStatus.error,
                                //                     title: state.message ?? 'Что-то пошло не так',
                                //                   );
                                //                 }
                                //               },
                                //               builder: (context, state) => ButtonWithScale(
                                //                 isLoading: state is DashboardMetricsLoading,
                                //                 width: 0.45.sw,
                                //                 height: 60.h,
                                //                 onPressed: () async {
                                //                   final startTime = start;
                                //                   final endTime = end;
                                //                   if (startTime == null || endTime == null) return;
                                //                   await dashboardMetricsCubit.updateMetrics(
                                //                     sleepHours: double.tryParse(sleepController.text),
                                //                     sleepStart: startTime,
                                //                     sleepEnd: endTime,
                                //                   );
                                //                 },
                                //                 text: 'Сохранить',
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   );
                                // },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Сон',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    10.width,
                                    Icon(Icons.arrow_forward_ios, size: 15.r, color: ThemeColors.base400),
                                  ],
                                ),
                                8.height,
                                HalfCircleProgressBar(
                                  progress: (state is DashboardMetricsLoaded)
                                      ? ((state.dashboardMetrics.sleep?.current ?? 0) /
                                            (state.dashboardMetrics.sleep?.norm ?? 0))
                                      : (0 / 8),
                                  progressColor: Color(0xff16DC00),
                                  backgroundColor: Color(0x1A16DC00),
                                  icon: Image.asset(AppAssets.sleepPng, height: 42.r, width: 42.r),
                                ),
                                8.height,
                                Text(
                                  (state is DashboardMetricsLoaded)
                                      ? '${state.dashboardMetrics.sleep?.current ?? 0}/${state.dashboardMetrics.sleep?.norm ?? 0}'
                                      : '0/8',
                                  style: TextStyle(
                                    color: ThemeColors.baseBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double calculateSleep({required TimeOfDay bedTime, required TimeOfDay wakeTime}) {
    final now = DateTime.now();

    final dtBed = DateTime(now.year, now.month, now.day, bedTime.hour, bedTime.minute);
    DateTime dtWake = DateTime(now.year, now.month, now.day, wakeTime.hour, wakeTime.minute);

    if (dtWake.isBefore(dtBed)) {
      dtWake = dtWake.add(const Duration(days: 1));
    }
    final duration = dtWake.difference(dtBed);
    return duration.inMinutes / 60;
  }
}
