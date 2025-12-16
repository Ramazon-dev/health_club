import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class FreezeHistoryPage extends StatefulWidget {
  const FreezeHistoryPage({super.key});

  @override
  State<FreezeHistoryPage> createState() => _FreezeHistoryPageState();
}

class _FreezeHistoryPageState extends State<FreezeHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История заморозок',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: ListView.separated(
        padding: EdgeInsetsGeometry.only(top: 15.r, left: 15.r, right: 15.r, bottom: kBottomNavigationBarHeight * 2),
        shrinkWrap: true,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              height: 64.r,
              width: 64.r,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: ThemeColors.base50),
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
                  'Начало: 10.11.2025',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Конец: 13.11.2025',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                ),
              ],
            ),
          ],
        ),
        separatorBuilder: (context, index) => 15.height,
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
          text: 'Скачать отчет о заморозке (.PDF)',
        ),
      ),
    );
  }
}
