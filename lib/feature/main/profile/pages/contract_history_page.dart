import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class ContractHistoryPage extends StatefulWidget {
  const ContractHistoryPage({super.key});

  @override
  State<ContractHistoryPage> createState() => _ContractHistoryPageState();
}

class _ContractHistoryPageState extends State<ContractHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История договоров',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<SubscriptionHistoryCubit, SubscriptionHistoryState>(
        builder: (context, state) {
          if (state is SubscriptionHistoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is SubscriptionHistoryError) {
            return Center(child: Text(state.message ?? ''));
          } else if (state is SubscriptionHistoryLoaded) {
            final subscriptions = state.subscriptionHistory;
            return ListView.separated(
              padding: EdgeInsetsGeometry.only(
                top: 15.r,
                left: 15.r,
                right: 15.r,
                bottom: kBottomNavigationBarHeight * 2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.date ?? '',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                    ),
                    20.height,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final subscriptionItem = subscription.subscriptionHistory[index];
                        return Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: ThemeColors.base200),
                          color: ThemeColors.base50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0x3311d564),
                              ),
                              child: Text(
                                subscriptionItem.status ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff11d564),
                                ),
                              ),
                            ),
                            20.height,
                            Text(
                              subscriptionItem.title ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: ThemeColors.baseBlack,
                              ),
                            ),
                            20.height,
                            Text(
                              'Период действия:',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: ThemeColors.base400,
                              ),
                            ),
                            4.height,
                            Text(
                              '${subscriptionItem.startDate} — ${subscriptionItem.endDate}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ThemeColors.black950,
                              ),
                            ),
                            20.height,
                            Text(
                              'Стоимость:',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: ThemeColors.base400,
                              ),
                            ),
                            4.height,
                            Text(
                              '${subscriptionItem.price} ${subscriptionItem.currency}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ThemeColors.black950,
                              ),
                            ),
                            // 20.height,
                            // ButtonWithScale(
                            //   // isLoading: isLoading,
                            //   // onPressed: () {},
                            //   onPressed: () {
                            //     context.router.maybePop();
                            //   },
                            //   text: 'Скачать договор (.PDF)',
                            // ),
                          ],
                        ),
                      );
                      },
                      separatorBuilder: (context, index) => 10.height,
                      itemCount: subscription.subscriptionHistory.length,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => 20.height,
              itemCount: subscriptions.length,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
