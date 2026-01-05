import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class TrainingHistoryPage extends StatefulWidget {
  const TrainingHistoryPage({super.key});

  @override
  State<TrainingHistoryPage> createState() => _TrainingHistoryPageState();
}

class _TrainingHistoryPageState extends State<TrainingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История тренировок',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<TrainingHistoryCubit, TrainingHistoryState>(
        builder: (context, state) {
          if (state is TrainingHistoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is TrainingHistoryError) {
            return Center(child: Text(state.message ?? ''));
          } else if (state is TrainingHistoryLoaded) {
            final trainingHistories = state.trainingHistory;
            return ListView.separated(
              padding: EdgeInsetsGeometry.only(
                top: 15.r,
                left: 15.r,
                right: 15.r,
                bottom: kBottomNavigationBarHeight * 2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final training = trainingHistories[index];
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final trainingItem = training.trainings[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        training.date ?? '',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                      ),
                      16.height,
                      Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: ThemeColors.base200),
                          color: ThemeColors.base50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 48.r,
                                  width: 48.r,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(AppAssets.time),
                                ),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Время тренировки:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      trainingItem.timeRange ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: ThemeColors.black950,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            20.height,
                            Row(
                              children: [
                                Container(
                                  height: 48.r,
                                  width: 48.r,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.training,
                                    colorFilter: ColorFilter.mode(ThemeColors.primaryColor, BlendMode.srcIn),
                                  ),
                                ),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Тип тренировки:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      trainingItem.type ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: ThemeColors.black950,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            20.height,
                            Row(
                              children: [
                                Container(
                                  height: 48.r,
                                  width: 48.r,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(AppAssets.location),
                                ),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Клуб:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      trainingItem.club ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: ThemeColors.black950,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            20.height,
                            Row(
                              children: [
                                Container(
                                  height: 48.r,
                                  width: 48.r,
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(AppAssets.userSquare),
                                ),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Тренер:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      trainingItem.trainer ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: ThemeColors.black950,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  },
                  separatorBuilder: (context, index) => 16.height,
                  itemCount: training.trainings.length,
                );
              },
              separatorBuilder: (context, index) => 16.height,
              itemCount: trainingHistories.length,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
