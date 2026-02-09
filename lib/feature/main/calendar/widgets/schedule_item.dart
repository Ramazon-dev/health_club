import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/extensions/dialog_ext.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../data/network/model/calendar_response.dart';
import '../../../../design_system/design_system.dart';

class ScheduleItem extends StatelessWidget {
  final bool isLast;
  final PastResponse past;

  const ScheduleItem({super.key, this.isLast = false, required this.past});

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
                    past.status ?? '',
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
            past.datetimeStart?.bookingDate() ?? '',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
          SizedBox(height: 20.h),
          Text(
            past.title ?? '',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
          SizedBox(height: 10.h),
          Text(
            past.subtitle ?? '',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (past.canCancel == true)
                ButtonWithScale(
                  verticalPadding: 15.h,
                  horizontalPadding: 30.r,
                  color: ThemeColors.base100,
                  // color: ThemeColors.red300,
                  onPressed: () async {
                    final bookSlotsCubit = context.read<BookSlotCubit>();
                    context.dialogWithSubtitle(
                      title: 'Отменить бронь',
                      subtitle: 'Вы действительно хотите Отменить бронь',
                      onCancelled: () => Navigator.maybePop(context),
                      onConfirm: () => bookSlotsCubit.cancelReserve(past.id ?? 0),
                    );
                  },
                  text: 'Отменить',
                  textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                ),
            ],
          ),
          SizedBox(height: 20.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     PrimaryButton2(onPressed: () {}, text: 'Отменить', size: Size(0.4.sw, 50.h)),
          //     PrimaryButton2(onPressed: () {}, text: 'Перенести', size: Size(0.4.sw, 50.h)),
          //   ],
          // ),
        ],
      ),
    );
  }
}
