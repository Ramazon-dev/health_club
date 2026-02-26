import 'package:flutter/material.dart';
import 'package:health_club/data/network/model/calendar_response.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';

class TrainingItem extends StatelessWidget {
  final PastResponse training;

  const TrainingItem({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          training.date?.dateFormat() ?? '',
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
                        '${training.timeStart ?? ''} - ${training.timeEnd ?? ''}',
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
                        training.title ?? '',
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
                        training.subtitle ?? '',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                      ),
                    ],
                  ),
                ],
              ),
              20.height,
            ],
          ),
        ),
      ],
    );
  }
}
