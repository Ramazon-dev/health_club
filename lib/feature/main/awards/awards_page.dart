import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/feature/main/awards/widgets/circle_grafic_widget.dart';
import 'package:health_club/feature/main/awards/widgets/line_grafic_widget.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class AwardsPage extends StatefulWidget {
  const AwardsPage({super.key});

  @override
  State<AwardsPage> createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
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
            'Достижения',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
      ),
      body: BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) => SingleChildScrollView(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              Container(
                height: 300.h,
                width: 1.sw,
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
                child: Column(
                  children: [
                    Text(
                      'Текущей уровень',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                    ),
                    5.height,
                    Text(
                      'Календарь',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                    ),
                    if (state is ForecastLoaded) ...[
                      20.height,
                      MultiRingProgress(
                        progress: 0.7,
                        annual:
                            (state.forecast.startTargetBodyFatPercent ?? 0) /
                            (state.forecast.finalTargetBodyFatPercent ?? 0),
                        monthly:
                            (state.forecast.startTargetMuscleMassKg ?? 0) /
                            (state.forecast.finalTargetMuscleMassKg ?? 0),
                        weekly:
                            (state.forecast.startTargetTotalWeightKg ?? 0) /
                            (state.forecast.finalTargetTotalWeightKg ?? 0),
                        nextRank:
                            (state.forecast.startContractRefundThresholdKg ?? 0) /
                            (state.forecast.finalContractRefundThresholdKg ?? 0),
                        // key: ,
                      ),
                    ],
                  ],
                ),
              ),
              if (state is ForecastLoaded) ...[10.height, DetailedProgressCard(forecast: state.forecast)],
              Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.r),
                    margin: EdgeInsets.only(top: 10.h),
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
                      children: [
                        Row(
                          children: [
                            Text(
                              'Награда за \nследующий уровень',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.baseBlack,
                              ),
                            ),
                          ],
                        ),
                        20.height,
                        Text(
                          'Небольшое описание о бонусе который ждет юзера после достижения следующего уровня',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -7,
                    right: -10,
                    child: Image.asset(AppAssets.awardPng, height: 100.r, width: 100.r),
                  ),
                  // SvgPicture.asset(AppAssets.award, colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                ],
              ),
              10.height,
              Text(
                'Ваши достижения',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
              ),
              20.height,
              Row(
                spacing: 8.r,
                children: [
                  Image.asset(AppAssets.firstVisitPng),
                  Image.asset(AppAssets.visits3),
                  Image.asset(AppAssets.achievements),
                ],
              ),
              10.height,
              Row(
                spacing: 8.r,
                children: [
                  Image.asset(AppAssets.achievementPng),
                  Image.asset(AppAssets.checkIns),
                  Image.asset(AppAssets.card),
                ],
              ),
              10.height,
              Row(
                spacing: 8.r,
                children: [
                  Image.asset(AppAssets.visits3),
                  Image.asset(AppAssets.achievements),
                  Image.asset(AppAssets.firstVisitPng),
                ],
              ),
              // SvgPicture.asset(AppAssets.firstVisit),
              120.height,
            ],
          ),
        ),
      ),
    );
  }
}
