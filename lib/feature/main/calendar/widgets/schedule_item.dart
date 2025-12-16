import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

class ScheduleItem extends StatelessWidget {
  final bool isLast;

  const ScheduleItem({super.key, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLast) ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0x3311d564),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Отменено',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Color(0xff11d564),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
          Text(
            '14 марта, 18:00 - 19:00',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
          SizedBox(height: 20.h),
          Text(
            'Силовая тренировка',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
          SizedBox(height: 10.h),
          Text(
            '35’HC — Центральный клуб',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButton2(onPressed: () {}, text: 'Отменить', size: Size(0.4.sw, 50.h)),
              PrimaryButton2(onPressed: () {}, text: 'Перенести', size: Size(0.4.sw, 50.h)),
            ],
          ),
        ],
      ),
    );
  }
}
