import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

@RoutePage()
class NotificationsDetailPage extends StatefulWidget {
  const NotificationsDetailPage({super.key});

  @override
  State<NotificationsDetailPage> createState() => _NotificationsDetailPageState();
}

class _NotificationsDetailPageState extends State<NotificationsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        backgroundColor: ThemeColors.base100,
        iconColor: Colors.white,
        buttonColor: Colors.white,
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1507019403270-cca502add9f8?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybCUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
              height: 235.h,
              width: 1.sw,
              borderRadius: BorderRadius.circular(15.r),
            ),
            20.height,
            Text(
              'Сегодня, 12:17',
              style: TextStyle(color: ThemeColors.base400, fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
            20.height,
            Text(
              'Поздравляем! Вы получили новый ранг «Серебрянный Атлет»',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w400),
            ),
            15.height,
            Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
