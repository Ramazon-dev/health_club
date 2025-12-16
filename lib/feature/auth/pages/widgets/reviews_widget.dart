import 'package:flutter/material.dart';
import '../../../../design_system/design_system.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: PageView(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
            child: Column(
              children: [
                Text(
                  "Я думала, что из-за грижы мне нелзя тренироваться. Но здесь я нашла безопасный способ укрепить спину. Боль ушла!",
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Divider(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '-Anna, 42 года',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
            child: Column(
              children: [
                Text(
                  "Каждое утро я смотрел в зеркало и был недоволен. За 3 меняца я собирал 12 кг. Это изменило мою жизнь.",
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '-Максим, 35 года',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ThemeColors.base100),
            child: Column(
              children: [
                Text(
                  "Постоянное усталость мешала мне жить. Теперь у меня столько энергии, что хватает и на работу и на семью!",
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '-Елена, 29 года',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
