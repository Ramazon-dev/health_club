import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<MapEntry<String, bool>> personalList = [
    MapEntry('Дружелюбный', false),
    MapEntry('Вежливый', false),
    MapEntry('Профессионалный', false),
    MapEntry('Внимательный', false),
  ];
  List<MapEntry<String, bool>> clubList = [
    MapEntry('Чистота', false),
    MapEntry('Простор', false),
    MapEntry('Освещение', false),
    MapEntry('Доступность', false),
    MapEntry('Раздевалка', false),
    MapEntry('Современный инвентарь', false),
  ];
  List<MapEntry<String, bool>> trainingList = [
    MapEntry('Чувствую результаты', false),
    MapEntry('Энергично', false),
    MapEntry('Интересно', false),
    MapEntry('Персональный подход', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        backgroundColor: ThemeColors.base100,
        iconColor: Colors.white,
        buttonColor: Colors.white,
        showBackButton: true,
        title: Tooltip(
          message: 'Review',
          child: Text(
            'Review',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const Icon(Icons.clear, color: Colors.black),
            onTap: () async {
              final router = context.router;
              await router.maybePop();
              await router.maybePop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Text(
              'Отлично! Что именно вам понравилось?',
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
            30.height,
            Container(
              width: 1.sw,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withValues(alpha: 0.06),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Персонал',
                    style: TextStyle(
                      color: ThemeColors.baseBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  10.height,
                  Wrap(
                    spacing: 10.r,
                    runSpacing: 10.r,
                    alignment: WrapAlignment.start,
                    children: personalList
                        .map(
                          (e) => GestureDetector(
                        onTap: () {
                          personalList = personalList.map((s) {
                            if (e.key == s.key) {
                              return MapEntry(s.key, !s.value);
                            } else {
                              return s;
                            }
                          }).toList();
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: e.value ? ThemeColors.primaryColor : ThemeColors.base100,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            e.key,
                            style: TextStyle(
                              color: e.value ? Colors.white : ThemeColors.baseBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
            20.height,
            Container(
              width: 1.sw,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withValues(alpha: 0.06),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Условия клуба',
                    style: TextStyle(
                      color: ThemeColors.baseBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  10.height,
                  Wrap(
                    spacing: 10.r,
                    runSpacing: 10.r,
                    children: clubList
                        .map(
                          (e) => GestureDetector(
                        onTap: () {
                          clubList = clubList.map((s) {
                            if (e.key == s.key) {
                              return MapEntry(s.key, !s.value);
                            } else {
                              return s;
                            }
                          }).toList();
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: e.value ? ThemeColors.primaryColor : ThemeColors.base100,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            e.key,
                            style: TextStyle(
                              color: e.value ? Colors.white : ThemeColors.baseBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
            20.height,
            Container(
              width: 1.sw,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withValues(alpha: 0.06),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Тренировка',
                    style: TextStyle(
                      color: ThemeColors.baseBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  10.height,
                  Wrap(
                    spacing: 10.r,
                    runSpacing: 10.r,
                    children: trainingList
                        .map(
                          (e) => GestureDetector(
                        onTap: () {
                          trainingList = trainingList.map((s) {
                            if (e.key == s.key) {
                              return MapEntry(s.key, !s.value);
                            } else {
                              return s;
                            }
                          }).toList();
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: e.value ? ThemeColors.primaryColor : ThemeColors.base100,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            e.key,
                            style: TextStyle(
                              color: e.value ? Colors.white : ThemeColors.baseBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
            100.height,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.primaryColor),
                ),
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.primaryColor),
                ),
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.base200),
                ),
              ],
            ),
            20.height,
            ButtonWithScale(
              onPressed: () {
                context.router.push(CommentRoute());
              },
              text: 'Продолжить',
            ),
          ],
        ),
      ),
    );
  }
}
