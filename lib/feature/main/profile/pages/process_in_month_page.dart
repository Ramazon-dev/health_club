import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';

@RoutePage()
class ProcessInMonthPage extends StatefulWidget {
  const ProcessInMonthPage({super.key});

  @override
  State<ProcessInMonthPage> createState() => _ProcessInMonthPageState();
}

class _ProcessInMonthPageState extends State<ProcessInMonthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Ваш процесс в месяц',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            BlocBuilder<TrainingHistoryCubit, TrainingHistoryState>(
              builder: (context, state) {
                if (state is! TrainingHistoryLoaded) return SizedBox();
                final trainings = state.trainingHistory;
                final month = DateTime(DateTime.now().year, DateTime.now().month);
                final now = DateTime.now();
                final trainingsInMonth = trainings
                    .where(
                      (element) => (element.date?.isAfterOrSame(month) == true && element.date?.isBefore(now) == true),
                    )
                    .toList()
                    .reversed;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.dumbbellDark),
                          10.width,
                          Text(
                            'Тренировки',
                            style: TextStyle(
                              color: ThemeColors.baseBlack,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      8.height,
                      Text(
                        'Минимум 10 тренировок в месяц. Интервал 48 часов (± 1 час)',
                        style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      20.height,
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            final profileMonthProgress = state.profile.monthProgress;
                            return Row(
                              children: [
                                Container(
                                  height: 54.r,
                                  width: 54.r,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(AppAssets.dumbbellDark),
                                ),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Тренировок в этом месяце',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${profileMonthProgress?.current ?? 0}/${profileMonthProgress?.target ?? 0}',
                                      style: TextStyle(
                                        color: ThemeColors.baseBlack,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      // 10.height,
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 54.r,
                      //       width: 54.r,
                      //       padding: EdgeInsets.all(15.r),
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                      //       child: SvgPicture.asset(AppAssets.pharagraph),
                      //     ),
                      //     10.width,
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Соблюдение интервалов',
                      //           style: TextStyle(
                      //             color: ThemeColors.base400,
                      //             fontSize: 12.sp,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //         Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(4.r),
                      //             color: Color(0x1A11D564),
                      //           ),
                      //           padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
                      //           child: Text(
                      //             'В норме',
                      //             style: TextStyle(
                      //               color: ThemeColors.statusGreen,
                      //               fontSize: 14.sp,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // 10.height,
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 54.r,
                      //       width: 54.r,
                      //       padding: EdgeInsets.all(15.r),
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                      //       child: SvgPicture.asset(AppAssets.dumbbell),
                      //     ),
                      //     10.width,
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Следующая смена нагрузки',
                      //           style: TextStyle(
                      //             color: ThemeColors.base400,
                      //             fontSize: 12.sp,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //         Text(
                      //           'через 3 тренировки',
                      //           style: TextStyle(
                      //             color: ThemeColors.baseBlack,
                      //             fontSize: 18.sp,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // 10.height,
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 54.r,
                      //       width: 54.r,
                      //       padding: EdgeInsets.all(15.r),
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                      //       child: SvgPicture.asset(AppAssets.weight),
                      //     ),
                      //     10.width,
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Следующие замеры Tanita',
                      //           style: TextStyle(
                      //             color: ThemeColors.base400,
                      //             fontSize: 12.sp,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //         Text(
                      //           'через 3 тренировки',
                      //           style: TextStyle(
                      //             color: ThemeColors.baseBlack,
                      //             fontSize: 18.sp,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      20.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Дата',
                            style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Тип',
                            style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final training = trainingsInMonth.toList()[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                training.date?.dateFormat() ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: training.trainings
                                    .map(
                                      (e) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [Text(e.type ?? ''), 5.height, Text(e.timeRange ?? '')],
                                      ),
                                    )
                                    .toList(),
                              ),
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   physics: NeverScrollableScrollPhysics(),
                              //   itemBuilder: (context, i) => Column(
                              //     mainAxisSize: MainAxisSize.min,
                              //     children: [
                              //       Text(training.trainings[i].type ?? ''),
                              //       5.height,
                              //       Text(training.trainings[i].timeRange ?? ''),
                              //     ],
                              //   ),
                              // ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: trainingsInMonth.length,
                      ),
                      // Divider(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       '24.12.2025',
                      //       style: TextStyle(
                      //         color: ThemeColors.baseBlack,
                      //         fontSize: 16.sp,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //     SvgPicture.asset(AppAssets.cancel),
                      //   ],
                      // ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
