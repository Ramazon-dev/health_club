import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class BodyHistoryPage extends StatefulWidget {
  const BodyHistoryPage({super.key});

  @override
  State<BodyHistoryPage> createState() => _BodyHistoryPageState();
}

class _BodyHistoryPageState extends State<BodyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История состава тела',
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Вес:',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                        ),
                        4.height,
                        Text(
                          '78.3 kg',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Жир (%):',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                        ),
                        4.height,
                        Text(
                          '23.5%',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Мышцы:',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                        ),
                        4.height,
                        Text(
                          '31.2 kg',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Висцеральный жир:',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
                        ),
                        4.height,
                        Text(
                          '11',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.height,
              Text(
                'Метаболический возраст:',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.base400),
              ),
              4.height,
              Text(
                '37',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.black950),
              ),
              20.height,
              ButtonWithScale(
                // isLoading: isLoading,
                // onPressed: () {},
                onPressed: () {
                  context.router.maybePop();
                },
                text: 'Скачать ТАниту (.PDF)',
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
