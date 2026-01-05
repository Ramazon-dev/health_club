import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_club/app_bloc/histories/payment_history/payment_history_cubit.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История платежей',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
        builder: (context, state) {
          if (state is PaymentHistoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is PaymentHistoryError) {
            return Center(child: Text(state.message));
          } else if (state is PaymentHistoryLoaded) {
            final histories = state.paymentHistory;
            return ListView.separated(
              padding: EdgeInsetsGeometry.only(
                top: 15.r,
                left: 15.r,
                right: 15.r,
                bottom: kBottomNavigationBarHeight * 2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final history = histories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.date ?? '',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                    ),
                    16.height,
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final historyItem = history.items[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 64.r,
                              width: 64.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: ThemeColors.base50,
                              ),
                              child: Icon(Icons.add),
                            ),
                            SizedBox(width: 8.r),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  historyItem.title ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors.baseBlack,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  (historyItem.amount ?? 0).toString(),
                                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400, color: Color(0xff11d564)),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              historyItem.time ?? '',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xffA4A4A4)),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => 16.height,
                      itemCount: history.items.length,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => 16.height,
              itemCount: histories.length,
            );
          } else {
            return SizedBox();
          }
        },
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
      //     text: 'Скачать полный отчет (.PDF)',
      //   ),
      // ),
    );
  }
}
