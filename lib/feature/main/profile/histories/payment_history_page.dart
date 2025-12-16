import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      body: ListView.separated(
        padding: EdgeInsetsGeometry.only(top: 15.r, left: 15.r, right: 15.r, bottom: kBottomNavigationBarHeight * 2),
        shrinkWrap: true,
        itemBuilder: (context, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64.r,
              width: 64.r,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base50),
              child: Icon(Icons.add),
            ),
            SizedBox(width: 8.r),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ежемесячное членство',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                ),
                SizedBox(height: 4.h),
                Text(
                  '+350 000',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400, color: Color(0xff11d564)),
                ),
              ],
            ),
            Spacer(),
            Text(
              '12:00',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xffA4A4A4)),
            ),
          ],
        ),
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            '19.09.2025',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
        ),
        itemCount: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonWithScale(
          // isLoading: isLoading,
          // onPressed: () {},
          onPressed: () {
            context.router.maybePop();
          },
          text: 'Скачать полный отчет (.PDF)',
        ),
      ),
    );
  }
}
