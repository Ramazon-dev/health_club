import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class DailyReportPage extends StatefulWidget {
  const DailyReportPage({super.key});

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Дневной отчёт',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.organicFood),
                10.width,
                Text(
                  'Питание',
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            8.height,
            Text(
              'Загрузите фото приёма пищи на завтрак, обед и ужин',
              style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            15.height,
            Text(
              'Завтрак',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            8.height,
            Row(
              children: [
                SvgPicture.asset(AppAssets.time),
                10.width,
                Text(
                  'с 06:00 до 12:00',
                  style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
