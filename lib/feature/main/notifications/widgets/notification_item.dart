import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

class NotificationItem extends StatelessWidget {
  final int index;
  const NotificationItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
      child: Column(
        children: [
          if (index == 0)
            CustomCachedNetworkImage(
              imageUrl:
              'https://images.unsplash.com/photo-1507019403270-cca502add9f8?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybCUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
              height: 150.h,
              width: 1.sw,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
            ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Заголовок',
                      style: TextStyle(
                        color: ThemeColors.baseBlack,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 4.r,
                      foregroundColor: ThemeColors.primaryGreen600,
                      backgroundColor: ThemeColors.primaryGreen600,
                    ),
                  ],
                ),
                5.height,
                Text(
                  'Подзаголовок',
                  style: TextStyle(
                    color: ThemeColors.baseBlack,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                30.height,
                Row(
                  children: [
                    Text(
                      'Сегодня, 12:17',
                      style: TextStyle(
                        color: ThemeColors.base400,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 17.r, color: ThemeColors.base400),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
