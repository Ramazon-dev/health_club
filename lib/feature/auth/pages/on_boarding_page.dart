import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health_club/data/network/model/user_country_enum.dart';
import 'package:health_club/data/storage/local_storage.dart';
import 'package:health_club/di/init.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final ValueNotifier<bool> selectCountryNotifier = ValueNotifier(true);
  final localStorage = getIt<LocalStorage>();

  @override
  void initState() {
    if (localStorage.getCountry() != AppCountryEnum.uz.name) {
      selectCountryNotifier.value = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: selectCountryNotifier,
        builder: (context, country, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.01),
                      Colors.white.withValues(alpha: 0.02),
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.08),
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.18),
                      Colors.white.withValues(alpha: 0.25),
                      Colors.white.withValues(alpha: 0.32),
                      Colors.white.withValues(alpha: 0.40),
                      Colors.white.withValues(alpha: 0.48),
                      Colors.white.withValues(alpha: 0.57),
                      Colors.white.withValues(alpha: 0.67),
                      Colors.white.withValues(alpha: 0.77),
                      Colors.white.withValues(alpha: 0.88),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),

            // 45.height,
            // Text(
            //   'Просто \n Безопасно \nЭффективно',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 28.sp, fontWeight: FontWeight.w500),
            // ),
            SizedBox(height: 35),
            Text(
              'Выберите свою страну',
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            // SizedBox(height: 35),
            10.height,

            GestureDetector(
              onTap: () {
                selectCountryNotifier.value = true;
                localStorage.setCountry(AppCountryEnum.uz.name);
                localStorage.setBaseUrl(AppCountryEnum.uz.baseUrl);
              },
              child: Container(
                width: 0.5.sw,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
                decoration: BoxDecoration(
                  border: Border.all(color: country ? ThemeColors.primaryColor : Colors.transparent),
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0x3311d564),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (country)
                      Icon(Icons.done, color: country ? ThemeColors.primaryColor : Color(0xff11d564), size: 18.r),
                    SizedBox(width: 5.r),
                    Text(
                      'Uzbekistan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: country ? ThemeColors.primaryColor : Color(0xff11d564),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.height,
            GestureDetector(
              onTap: () {
                selectCountryNotifier.value = false;
                localStorage.setCountry(AppCountryEnum.kz.name);
                localStorage.setBaseUrl(AppCountryEnum.kz.baseUrl);
              },
              child: Container(
                width: 0.5.sw,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
                decoration: BoxDecoration(
                  border: Border.all(color: !country ? ThemeColors.primaryColor : Colors.transparent),
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0x3311d564),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!country)
                      Icon(Icons.done, color: !country ? ThemeColors.primaryColor : Color(0xff11d564), size: 18.r),
                    SizedBox(width: 5.r),
                    Text(
                      'Kazakhstan',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: !country ? ThemeColors.primaryColor : Color(0xff11d564),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: ButtonWithScale(
          onPressed: () {
            updateDioBaseUrl(localStorage.getBaseUrl());
            context.router.push(LoginRoute());
          },
          text: 'Войти',
        ),
      ),
    );
  }

  void updateDioBaseUrl(String baseUrl) {
    final dio = getIt<Dio>();
    dio.options.baseUrl = baseUrl;
  }
}
