import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      body: ListView.separated(
        padding: EdgeInsetsGeometry.only(top: 15.r, left: 15.r, right: 15.r, bottom: kBottomNavigationBarHeight * 2),
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: Color(0x3311d564)),
                child: Text(
                  'Активный',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xff11d564)),
                ),
              ),
              20.height,
              Text(
                'Абонемент «Безлимит 1 месяц»',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: ThemeColors.baseBlack),
              ),
              20.height,
              Text(
                'Период действия:',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
              ),
              4.height,
              Text(
                '01.01.2025 — 01.02.2025',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
              ),
              20.height,
              Text(
                'Стоимость:',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
              ),
              4.height,
              Text(
                '199 000 UZS',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
              ),
              20.height,
              ButtonWithScale(
                // isLoading: isLoading,
                // onPressed: () {},
                onPressed: () {
                  context.router.maybePop();
                },
                text: 'Скачать договор (.PDF)',
              ),
            ],
          ),
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
    );
  }
}
