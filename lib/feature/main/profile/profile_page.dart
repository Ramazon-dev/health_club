import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/design_system/extensions/dialog_ext.dart';
import 'package:health_club/design_system/widgets/bottom_sheet_widget.dart';
import 'package:health_club/design_system/widgets/network_image.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/main/profile/widgets/freeze_subscription_bottom_sheet.dart';
import 'package:health_club/feature/main/profile/widgets/profile_processing_widget.dart';
import 'package:health_club/router/app_router.gr.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<DateTimeRange<DateTime>?> rangeNotifier = ValueNotifier(null);

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
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: CircleAvatar(radius: 50.r, backgroundColor: Colors.cyanAccent),
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message ?? ''));
                  } else if (state is ProfileLoaded) {
                    final profile = state.profile;
                    final avatar = profile.avatar;
                    return Column(
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white24,
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.notification,
                                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            // 'https://static.vecteezy.com/system/resources/thumbnails/065/615/845/small/portrait-of-a-woman-with-long-hair-against-a-vibrant-urban-background-at-night-photo.jpeg',
                            if (avatar != null && avatar.isNotEmpty)
                              AppNetworkImage(
                                imageUrl: avatar,
                                height: 100.r,
                                width: 100.r,
                                borderRadius: BorderRadius.circular(100),
                              )
                            else
                              CircleAvatar(
                                radius: 50.r,
                                backgroundColor: Colors.cyanAccent,
                                child: Icon(Icons.person, color: ThemeColors.baseBlack, size: 40.r),
                              ),
                            InkWell(
                              onTap: () {
                                context.router.push(SettingsRoute());
                              },
                              child: Container(
                                height: 56.h,
                                width: 56.r,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white24,
                                ),
                                child: Icon(Icons.menu, color: Colors.white),
                                // child: SvgPicture.asset(
                                //   AppAssets.settings,
                                //   colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          '${profile.name} ${profile.surname}',
                          style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 60.h,
                          width: 1.sw,
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Color(0x33ffffff),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.target),
                              SizedBox(width: 10.r),
                              Text(
                                '${state.profile.goal}',
                                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.r),
              child: Column(
                children: [
                  10.height,
                  ButtonWithScale(
                    // isLoading: isLoading,
                    onPressed: () async {
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
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileLoaded) {
                              return ProfileProcessingWidget(process: state.profile.monthProgress?.percent ?? 0);
                              // return ProfileProcessingWidget(process: 10);
                            } else {
                              return ProfileProcessingWidget(process: 0);
                            }
                          },
                        ),
                        // ProgressGauge(progress: 0.8),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        final subscription = state.profile.subscription;
                        final isActive = subscription?.endedAt?.isAfter(DateTime.now()) == true;
                        return Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: Column(
                            children: [
                              if (subscription?.startedAt != null || subscription?.endedAt != null) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Начало: ${subscription?.startedAt?.dateFormat() ?? ''}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    Text(
                                      'Окончание: ${subscription?.endedAt?.dateFormat() ?? ''}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                              ],
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
                                        'Осталось ${subscription?.daysLeft ?? 0} дней',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
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
                                        if (isActive) ...[
                                          Icon(Icons.done, color: Color(0xff11d564), size: 18.r),
                                          SizedBox(width: 5.r),
                                        ],
                                        Text(
                                          isActive ? 'Активный' : 'Не активный',
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
                              if (isActive) ...[
                                SizedBox(height: 20.h),
                                Divider(height: 1),
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
                                        context.showDynamicDialog(
                                          widgets: [
                                            Text(
                                              'Успешно прошел',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: ThemeColors.baseBlack,
                                              ),
                                            ),
                                            10.height,
                                            Text(
                                              'state.success',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.baseBlack,
                                              ),
                                            ),
                                            20.height,
                                            Text(
                                              DateTime.now().bookingDate(),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors.baseBlack,
                                              ),
                                            ),
                                            20.height,
                                          ],
                                        );
                                        // context.router.push(RatingRoute());
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
                                BlocListener<FreezeHistoryCubit, FreezeHistoryState>(
                                  listener: (context, state) {
                                    if (state is FreezeHistoryError) {
                                      CustomSneakBar.show(
                                        context: context,
                                        status: SneakBarStatus.error,
                                        title: state.message ?? 'Что то пошло не так',
                                      );
                                    }
                                  },
                                  child: SecondaryButton(
                                    onPressed: () {
                                      final freezeCubit = context.read<FreezeHistoryCubit>();
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BottomSheetWidget(
                                            widgets: [
                                              FreezeSubscriptionBottomSheet(
                                                rangeNotifier: rangeNotifier,
                                                onTap: () {
                                                  final range = rangeNotifier.value;
                                                  if (range != null) {
                                                    context.router.maybePop();
                                                    freezeCubit.freezeSubscription(
                                                      range.end.difference(range.start).inDays,
                                                      range.start.dateForRequest(),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: 'Заморозить членство',
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: kBottomNavigationBarHeight * 3),
          ],
        ),
      ),
    );
  }
}

// Source - https://stackoverflow.com/a
// Posted by Muhammad Kuifatieh
// Retrieved 2025-11-21, License - CC BY-SA 4.0
