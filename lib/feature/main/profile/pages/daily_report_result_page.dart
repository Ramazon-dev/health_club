import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class DailyReportResultPage extends StatefulWidget {
  const DailyReportResultPage({super.key});

  @override
  State<DailyReportResultPage> createState() => _DailyReportResultPageState();
}

class _DailyReportResultPageState extends State<DailyReportResultPage> {
  Widget getNorm(bool isNorm) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: isNorm ? Color(0x1A11D564) : Color(0x1AFF3D3D),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
        child: Text(
          isNorm ? 'В норме' : 'Ниже нормы',
          style: TextStyle(
            color: isNorm ? ThemeColors.statusGreen : ThemeColors.statusRed,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    //   return Container(
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: Color(0x1AFF3D3D)),
    //     padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
    //     child: Text(
    //       'Ниже нормы',
    //       style: TextStyle(color: ThemeColors.statusRed, fontSize: 16.sp, fontWeight: FontWeight.w600),
    //     ),
    //   );
  }

  Widget stepTarget(bool isNorm) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: isNorm ? Color(0x1A11D564) : Color(0x1AFF3D3D),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
        child: Text(
          isNorm ? 'Цель достигнута' : 'Цель не достигнута',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isNorm ? ThemeColors.statusGreen : ThemeColors.statusRed,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    // return Expanded(
    //   child: Container(
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: Color(0x1AFF3D3D)),
    //     padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
    //     child: Text(
    //       'Цель не достигнута',
    //       overflow: TextOverflow.ellipsis,
    //       style: TextStyle(color: ThemeColors.statusRed, fontSize: 16.sp, fontWeight: FontWeight.w600),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Дневной отчёт',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<DashboardMetricsCubit, DashboardMetricsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                20.height,
                if (state is DashboardMetricsLoaded)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.droplet),
                            10.width,
                            Text(
                              'Вода',
                              style: TextStyle(
                                color: ThemeColors.baseBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            getNorm(
                              (state.dashboardMetrics.water?.current ?? 0) > (state.dashboardMetrics.water?.norm ?? 0),
                            ),
                          ],
                        ),
                        15.height,
                        Text(
                          '${state.dashboardMetrics.water?.current ?? ''} мл',
                          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 36.sp, fontWeight: FontWeight.w500),
                        ),
                        5.height,
                        Text(
                          'Норма: ${state.dashboardMetrics.water?.norm} мл',
                          style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        // 20.height,
                        // ButtonWithScale(
                        //   // isLoading: isLoading,
                        //   // onPressed: () {},
                        //   onPressed: () {},
                        //   text: 'Смотреть историю',
                        //   color: Colors.white,
                        //   textStyle: TextStyle(
                        //     color: ThemeColors.baseBlack,
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                20.height,
                if (state is DashboardMetricsLoaded)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.sleeping),
                            10.width,
                            Text(
                              'Сон',
                              style: TextStyle(
                                color: ThemeColors.baseBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            getNorm(
                              (state.dashboardMetrics.sleep?.current ?? 0) > (state.dashboardMetrics.sleep?.norm ?? 0),
                            ),
                          ],
                        ),
                        15.height,
                        Text(
                          '${state.dashboardMetrics.sleep?.current} ч',
                          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 36.sp, fontWeight: FontWeight.w500),
                        ),
                        5.height,
                        Text(
                          'Норма: ${state.dashboardMetrics.sleep?.norm} ч',
                          style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        // 20.height,
                        // ButtonWithScale(
                        //   // isLoading: isLoading,
                        //   // onPressed: () {},
                        //   onPressed: () {},
                        //   text: 'Смотреть историю',
                        //   color: Colors.white,
                        //   textStyle: TextStyle(
                        //     color: ThemeColors.baseBlack,
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                20.height,
                if (state is DashboardMetricsLoaded)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.sleeping),
                                10.width,
                                Text(
                                  'Шаги (неделя)',
                                  style: TextStyle(
                                    color: ThemeColors.baseBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            20.width,
                            // Spacer(),
                            stepTarget(
                              (state.dashboardMetrics.steps?.current ?? 0) > (state.dashboardMetrics.steps?.norm ?? 0),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4.r),
                            //     color: Color(0x1A11D564),
                            //   ),
                            //   padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
                            //   child: Text(
                            //     'Цель достигнута',
                            //     style: TextStyle(
                            //       color: ThemeColors.statusGreen,
                            //       fontSize: 16.sp,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        15.height,
                        Text(
                          '${state.dashboardMetrics.steps?.current}',
                          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 36.sp, fontWeight: FontWeight.w500),
                        ),
                        5.height,
                        Text(
                          'Норма: ${state.dashboardMetrics.steps?.norm}',
                          style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        // 20.height,
                        // ButtonWithScale(
                        //   // isLoading: isLoading,
                        //   // onPressed: () {},
                        //   onPressed: () {},
                        //   text: 'Смотреть историю',
                        //   color: Colors.white,
                        //   textStyle: TextStyle(
                        //     color: ThemeColors.baseBlack,
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
