import 'package:activity_ring/activity_ring.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../router/app_router.gr.dart';
import '../../profile/widgets/daily_metrics_bottom_sheet.dart';

class DashboardWidget extends StatelessWidget {
  final String stepsText;
  final double stepsPercent;
  final String sleepText;
  final double sleepPercent;
  final String foodText;
  final double foodPercent;
  final String waterText;
  final double waterPercent;
  final bool isToday;
  final num waterCurrent;
  final num stepsCurrent;

  const DashboardWidget({
    super.key,
    required this.stepsText,
    required this.stepsPercent,
    required this.sleepText,
    required this.sleepPercent,
    required this.foodText,
    required this.foodPercent,
    required this.waterText,
    required this.waterPercent,
    required this.isToday,
    required this.waterCurrent,
    required this.stepsCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final double checkedStepsProgress = stepsPercent > 100 ? 100 : stepsPercent;
    final double checkedSleepProgress = sleepPercent > 100 ? 100 : sleepPercent;
    final double checkedWaterProgress = waterPercent > 100 ? 100 : waterPercent;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.r),
      child: Column(
        children: [
          SizedBox(
            height: 155.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: !isToday
                      ? null
                      : () async {
                          context.router.push(DailyReportRoute());
                        },
                  child: Container(
                    width: 0.43.sw,
                    padding: EdgeInsets.all(12.r),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: Alignment.topRight, child: Image.asset(AppAssets.foodTransparent)),
                        Ring(
                          percent: foodPercent,
                          color: RingColorScheme(ringColor: Color(0xffFF9533), backgroundColor: Color(0x1AFF9533)),
                          width: 12,
                          radius: 30,
                          center: Offset(40, 0),
                        ),
                        16.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Приём пищи',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.base400,
                              ),
                            ),
                            5.height,
                            Text(
                              foodText,
                              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Color(0xffFF9533)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: !isToday
                      ? null
                      : () {
                          final waterController = TextEditingController();
                          final dashboardMetricsCubit = context.read<DashboardMetricsCubit>();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => DailyMetricsBottomSheet(
                              controller: waterController,
                              title: 'Выпито воды (мл)',
                              onPressed: () async {
                                if (waterCurrent > 10000) {
                                  context.router.maybePop();
                                  await CustomSneakBar.show(
                                    context: context,
                                    status: SneakBarStatus.warning,
                                    title: 'Потребление более 10000 МЛ воды в день опасно для здоровья',
                                  );
                                  return;
                                }
                                await dashboardMetricsCubit.updateMetrics(waterML: int.tryParse(waterController.text));
                              },
                            ),
                          );
                        },
                  child: Container(
                    width: 0.43.sw,
                    padding: EdgeInsets.all(12.r),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: Alignment.topRight, child: Image.asset(AppAssets.waterTransparent)),
                        Ring(
                          percent: checkedWaterProgress,
                          color: RingColorScheme(ringColor: Color(0xff3D84FF), backgroundColor: Color(0x1A3D84FF)),
                          width: 12,
                          radius: 30,
                          center: Offset(40, 0),
                        ),
                        16.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Вода',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.base400,
                              ),
                            ),
                            5.height,
                            Text(
                              waterText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Color(0xffff2222)),
                            ),
                          ],
                        ),
                      ],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: !isToday
                      ? null
                      : () {
                          final stepsController = TextEditingController();
                          final dashboardMetricsCubit = context.read<DashboardMetricsCubit>();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => DailyMetricsBottomSheet(
                              controller: stepsController,
                              title: 'Шаги (за сегодня)',
                              onPressed: () async {
                                if (stepsCurrent < 20000) {
                                  await dashboardMetricsCubit.updateMetrics(steps: int.tryParse(stepsController.text));
                                } else if (stepsCurrent > 20000 && stepsCurrent < 50000) {
                                  context.router.maybePop();
                                  await CustomSneakBar.show(
                                    context: context,
                                    status: SneakBarStatus.warning,
                                    title: 'Риск травм\nЦель выше 20 000 шагов перегружает суставы. Будьте осторожны и выбирайте правильную обувь.',
                                  );
                                  await dashboardMetricsCubit.updateMetrics(steps: int.tryParse(stepsController.text));
                                } else if (stepsCurrent > 50000) {
                                  context.router.maybePop();
                                  await CustomSneakBar.show(
                                    context: context,
                                    status: SneakBarStatus.error,
                                    maxLines: 4,
                                    title: 'Опасная нагрузка!\n50 000 шагов — это экстремальный стресс для сердца и организма.',
                                  );
                                }
                              },
                            ),
                          );
                        },
                  child: Container(
                    width: 0.43.sw,
                    padding: EdgeInsets.all(12.r),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: Alignment.topRight, child: Image.asset(AppAssets.stepsTransparent)),
                        Ring(
                          percent: checkedStepsProgress,
                          color: RingColorScheme(ringColor: Color(0xffff2222), backgroundColor: Color(0x1AFF2222)),
                          width: 12,
                          radius: 30,
                          center: Offset(40, 0),
                        ),
                        16.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Шаги',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.base400,
                              ),
                            ),
                            5.height,
                            Text(
                              stepsText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Color(0xffff2222)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: !isToday
                      ? null
                      : () async {
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
                                      .map((e) => ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value))
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
                                final calculate = calculateSleep(bedTime: result.startTime, wakeTime: result.endTime);
                                start = result.startTime.toHHmm();
                                end = result.endTime.toHHmm();
                                sleepController.text = calculate.toString();
                              },
                            ),
                          );
                        },
                  child: Container(
                    width: 0.43.sw,
                    padding: EdgeInsets.all(12.r),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: Alignment.topRight, child: Image.asset(AppAssets.sleepTransparent)),
                        Ring(
                          percent: checkedSleepProgress,
                          color: RingColorScheme(ringColor: Color(0xff16DC00), backgroundColor: Color(0x1A16DC00)),
                          width: 12,
                          radius: 30,
                          center: Offset(40, 0),
                        ),
                        16.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Сон',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.base400,
                              ),
                            ),
                            5.height,
                            Text(
                              sleepText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Color(0xff16DC00)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
