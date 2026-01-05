import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/data/storage/app_storage.dart';
import 'package:health_club/di/init.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final router = context.router;
    getIt<AppStorage>().getAccessToken().then((token) {
      print('object get access token $token');
      if (token.isNotEmpty) {
        router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
      } else {
        router.push(OnBoardingRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 80, width: 130),
            SizedBox(height: 50),
            Text(
              'Здоровая нация - качественная жизнь',
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
