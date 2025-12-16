import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_club/design_system/theme/colors.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/widgets/button_with_scale.dart';

@RoutePage()
class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final ValueNotifier<bool> selectedGenderNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 65),
            Text(
              'Укажите свой пол',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 120),
            ValueListenableBuilder(
              valueListenable: selectedGenderNotifier,
              builder: (context, isMale, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedGenderNotifier.value = true;
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 180.h,
                          width: 110.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: isMale ? Color(0xffd29994) : Color(0xffe5e5e5)),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Муж',
                          style: TextStyle(color: ThemeColors.base400, fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.r),
                  GestureDetector(
                    onTap: () {
                      selectedGenderNotifier.value = false;
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 180.h,
                          width: 110.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: isMale ? Color(0xffe5e5e5) : Color(0xffd29994)),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Жен',
                          style: TextStyle(color: ThemeColors.base400, fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWithScale(
              onPressed: () {},
              width: 0.45.sw,
              color: Color(0xfff5f5f5),
              text: 'Назад',
              textStyle: TextStyle(color: ThemeColors.baseBlack, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 5.r),
            ButtonWithScale(
              onPressed: () {
                context.router.push(MainWrapper());
              },
              text: 'Продолжить',
              width: 0.45.sw,
            ),
          ],
        ),
      ),
    );
  }
}
