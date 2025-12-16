import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      body: ListView.separated(
        padding: EdgeInsetsGeometry.only(top: 15.r, left: 15.r, right: 15.r, bottom: kBottomNavigationBarHeight * 2),
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                    child: SvgPicture.asset(AppAssets.time),
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Время тренировки:',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                      ),
                      4.height,
                      Text(
                        '18:05 - 19:10',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
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
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                      ),
                      4.height,
                      Text(
                        'Силовая тренировка',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                    child: SvgPicture.asset(AppAssets.location),
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Клуб:',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                      ),
                      4.height,
                      Text(
                        '35’Health Clubs — Центр',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.white),
                    child: SvgPicture.asset(AppAssets.userSquare),
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Тренер:',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                      ),
                      4.height,
                      Text(
                        'Алексей Ильин',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            '19.09.2025',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
