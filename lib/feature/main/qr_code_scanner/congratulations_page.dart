import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/router/app_router.gr.dart';

@RoutePage()
class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            Spacer(),
            Image.asset(AppAssets.milaLovePng),
            20.height,
            Text(
              'Спасибо за ваш отзыв!',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
            5.height,
            Text(
              'Мы ценим ваше мнение и используем его, чтобы стать лучше',
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWithScale(
              onPressed: () {
                context.router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
              },
              text: 'Вернуться на главную',
            ),
            // 5.height,
            // ButtonWithScale(
            //   onPressed: () {
            //     context.router.pushAll([MainWrapper(), RatingRoute()]);
            //   },
            //   text: 'Оценить заново',
            //   color: Colors.white,
            //   textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
            // ),
          ],
        ),
      ),
    );
  }
}
