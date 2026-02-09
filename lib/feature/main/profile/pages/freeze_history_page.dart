import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../design_system/design_system.dart';
import '../widgets/freeze_subscription_bottom_sheet.dart';

@RoutePage()
class FreezeHistoryPage extends StatefulWidget {
  const FreezeHistoryPage({super.key});

  @override
  State<FreezeHistoryPage> createState() => _FreezeHistoryPageState();
}

class _FreezeHistoryPageState extends State<FreezeHistoryPage> {
  final ValueNotifier<DateTimeRange<DateTime>?> rangeNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Заморозки',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<FreezeHistoryCubit, FreezeHistoryState>(
          listener: (context, state) {
            if (state is FreezeHistoryError) {
              CustomSneakBar.show(
                context: context,
                status: SneakBarStatus.error,
                title: state.message ?? 'Что то пошло не так',
              );
            } else if (state is FreezeHistoryLoaded) {
              context.read<ProfileCubit>().fetchProfile();
            }
          },
          builder: (context, state) {
            if (state is FreezeHistoryLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is FreezeHistoryError) {
              return Center(child: Text(state.message ?? ''));
            } else if (state is FreezeHistoryLoaded) {
              final freezeHistory = state.freezeHistory;
              return Column(
                children: [
                  20.height,
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        final subscription = state.profile.subscription;
                        final isFrozen = subscription?.isFrozen ?? false;
                        final isActive = subscription?.endedAt?.isAfter(DateTime.now()) == true;
                        final freezeDaysLeft = subscription?.freezeDaysLeft;
                        final freezeDaysTotal = subscription?.freezeDaysTotal;

                        return Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                20.height,
                                if (freezeDaysLeft != null && freezeDaysTotal != null)
                                  Text(
                                    'Осталось:$freezeDaysLeft дней из $freezeDaysTotal дней заморозки',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: ThemeColors.base400,
                                    ),
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
                                      if (isActive)
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
                                        if (isActive && !isFrozen) ...[
                                          Icon(Icons.done, color: Color(0xff11d564), size: 18.r),
                                          SizedBox(width: 5.r),
                                        ],
                                        Text(
                                          isFrozen
                                              ? 'Заморожен'
                                              : isActive
                                              ? 'Активный'
                                              : 'Не активный',
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
                              if (isActive &&
                                  freezeDaysTotal != null &&
                                  freezeDaysLeft != null &&
                                  freezeDaysLeft > 0) ...[
                                SizedBox(height: 20.h),
                                Divider(height: 1),
                                // SizedBox(height: 20.h),
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: Text(
                                //     'Контракт',
                                //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.black),
                                //   ),
                                // ),
                                // SizedBox(height: 10.h),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     PrimaryButton2(
                                //       onPressed: () {
                                //         context.showDynamicDialog(
                                //           widgets: [
                                //             Text(
                                //               'Успешно прошел',
                                //               style: TextStyle(
                                //                 fontSize: 16.sp,
                                //                 fontWeight: FontWeight.w600,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             10.height,
                                //             Text(
                                //               'state.success',
                                //               style: TextStyle(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w500,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             20.height,
                                //             Text(
                                //               DateTime.now().bookingDate(),
                                //               style: TextStyle(
                                //                 fontSize: 12.sp,
                                //                 fontWeight: FontWeight.w400,
                                //                 color: ThemeColors.baseBlack,
                                //               ),
                                //             ),
                                //             20.height,
                                //           ],
                                //         );
                                //         // context.router.push(RatingRoute());
                                //       },
                                //       text: 'Просмотреть',
                                //       textSize: 14.sp,
                                //       textColor: Colors.black,
                                //       size: Size(0.4.sw, 47.h),
                                //     ),
                                //     PrimaryButton2(
                                //       onPressed: () {},
                                //       text: 'Скачать',
                                //       textColor: Colors.black,
                                //       textSize: 14.sp,
                                //       size: Size(0.4.sw, 47.h),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 20.h),
                                SecondaryButton(
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
                                                // final freezeDaysLeft = subscription?.freezeDaysLeft;
                                                // final freezeDaysTotal = subscription?.freezeDaysTotal;
                                                final range = rangeNotifier.value;
                                                if (range != null) {
                                                  if (freezeDaysLeft > range.end.difference(range.start).inDays) {
                                                    context.router.maybePop();
                                                    freezeCubit.freezeSubscription(
                                                      range.end.difference(range.start).inDays,
                                                      range.start.dateForRequest(),
                                                    );
                                                  } else {
                                                    CustomSneakBar.show(
                                                      context: context,
                                                      status: SneakBarStatus.error,
                                                      title: 'Недостаточно дней для заморозки',
                                                    );
                                                  }
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
                              ],
                            ],
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsetsGeometry.only(
                      top: 15.r,
                      left: 15.r,
                      right: 15.r,
                      bottom: kBottomNavigationBarHeight * 2,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final historyItem = freezeHistory[index];
                      return Row(
                        children: [
                          Container(
                            height: 64.r,
                            width: 64.r,
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: ThemeColors.base50,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.snow,
                              colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                            ),
                          ),
                          SizedBox(width: 8.r),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Начало: ${historyItem.startDate}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.baseBlack,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Конец: ${historyItem.endDate}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.baseBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => 15.height,
                    itemCount: freezeHistory.length,
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(15),
      //   child: ButtonWithScale(
      //     // isLoading: isLoading,
      //     // onPressed: () {},
      //     onPressed: () {
      //       context.router.maybePop();
      //     },
      //     text: 'Скачать отчет о заморозке (.PDF)',
      //   ),
      // ),
    );
  }
}
