import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/design_system/widgets/bottom_sheet_widget.dart';
import 'package:health_club/design_system/widgets/network_image.dart';
import 'package:health_club/feature/main/profile/widgets/profile_button.dart';
import 'package:health_club/router/app_router.gr.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
                color: Color(0xff2d9994),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.router.push(NotificationsRoute());
                        },
                        child: Container(
                          height: 56.h,
                          width: 56.r,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.white24),
                          child: SvgPicture.asset(
                            AppAssets.notification,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      AppNetworkImage(
                        imageUrl:
                            'https://static.vecteezy.com/system/resources/thumbnails/065/615/845/small/portrait-of-a-woman-with-long-hair-against-a-vibrant-urban-background-at-night-photo.jpeg',
                        height: 100.r,
                        width: 100.r,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      // CircleAvatar(radius: 50, backgroundColor: Colors.yellow),
                      InkWell(
                        onTap: () {
                          context.router.push(EditProfileRoute());
                        },
                        child: Container(
                          height: 56.h,
                          width: 56.r,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.white24),
                          child: SvgPicture.asset(
                            AppAssets.edit,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     context.router.push(EditProfileRoute());
                      //   },
                      //   child: Text(
                      //     'Изм',
                      //     style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Агнесе Калниня',
                    style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Рига, Латвия',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    height: 60.h,
                    width: 1.sw,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0x33ffffff)),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.target),
                        SizedBox(width: 10.r),
                        Text(
                          'Снижение веса',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.r),
              child: Column(
                children: [
                  10.height,
                  ButtonWithScale(
                    // isLoading: isLoading,
                    onPressed: () {
                      context.router.push(DailyReportRoute());
                    },
                    text: 'Дневной отчёт',
                  ),
                  10.height,
                  Container(
                    // height: 230.h,
                    width: 1.sw,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Ваш прогресс за месяц',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 1.sw,
                          height: 160.h,
                          child: Stack(
                            children: [
                              Positioned(bottom: 0, left: 0, child: SvgPicture.asset(AppAssets.progress)),
                              Positioned(
                                left: 35.r,
                                top: 40.h,
                                child: Transform.rotate(angle: 0.5, child: SvgPicture.asset(AppAssets.progress)),
                              ),
                              Positioned(
                                top: 5.h,
                                left: 90.r,
                                child: Transform.rotate(angle: 1, child: SvgPicture.asset(AppAssets.progress)),
                              ),
                              Positioned(
                                top: 5.h,
                                right: 90.r,
                                child: Transform.rotate(angle: 1.6, child: SvgPicture.asset(AppAssets.progress)),
                              ),
                              Positioned(
                                right: 33.r,
                                top: 41.h,
                                child: Transform.rotate(
                                  angle: 2.1,
                                  child: SvgPicture.asset(AppAssets.progress).gradient(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomLeft,
                                      colors: [Color(0xfff5f5f5), Color(0xff2d9994)],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Transform.rotate(
                                  angle: 2.6,
                                  origin: Offset(0, 2),
                                  filterQuality: FilterQuality.low,
                                  child: SvgPicture.asset(
                                    AppAssets.progress,
                                    colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '80%',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.black950,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ProgressGauge(progress: 0.8),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Начало: 01.10.2025',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: ThemeColors.base400,
                              ),
                            ),
                            Text(
                              'Окончание: 15.11.2025',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: ThemeColors.base400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Текущий статус членства',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: ThemeColors.base400,
                                  ),
                                ),
                                Text(
                                  'Осталось 15 дней',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.black),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0x3311d564),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.done, color: Color(0xff11d564), size: 18.r),
                                  SizedBox(width: 5.r),
                                  Text(
                                    'Активный',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: Color(0xff11d564),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Divider(),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Контракт',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryButton2(
                              onPressed: () {
                                context.router.popAndPush(RatingRoute());
                              },
                              text: 'Просмотреть',
                              textSize: 14.sp,
                              textColor: Colors.black,
                              size: Size(0.4.sw, 47.h),
                            ),
                            PrimaryButton2(
                              onPressed: () {},
                              text: 'Скачать',
                              textColor: Colors.black,
                              textSize: 14.sp,
                              size: Size(0.4.sw, 47.h),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        SecondaryButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheetWidget(widgets: []);
                              },
                            );
                          },
                          text: 'Заморозить членство',
                        ),
                      ],
                    ),
                  ),
                  10.height,
                  ProfileButton(
                    title: 'История платежей',
                    icon: AppAssets.calendarMonth,
                    onPressed: () {
                      context.router.push(PaymentHistoryRoute());
                    },
                  ),
                  5.height,
                  ProfileButton(
                    title: 'История заморозки',
                    icon: AppAssets.snow,
                    onPressed: () {
                      context.router.push(FreezeHistoryRoute());
                    },
                  ),
                  5.height,
                  ProfileButton(
                    title: 'История договоров',
                    icon: AppAssets.file,
                    onPressed: () {
                      context.router.push(ContractHistoryRoute());
                    },
                  ),
                  5.height,
                  ProfileButton(
                    title: 'История состава тела',
                    icon: AppAssets.bodyHuman,
                    onPressed: () {
                      context.router.push(BodyHistoryRoute());
                    },
                  ),
                  5.height,
                  ProfileButton(
                    title: 'История тренировок',
                    icon: AppAssets.training,
                    onPressed: () {
                      context.router.push(TrainingHistoryRoute());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: kBottomNavigationBarHeight * 2),
          ],
        ),
      ),
    );
  }
}

// Source - https://stackoverflow.com/a
// Posted by Muhammad Kuifatieh
// Retrieved 2025-11-21, License - CC BY-SA 4.0

extension Extension on Widget {
  gradient({required Gradient gradient}) => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
    child: this,
  );
}
