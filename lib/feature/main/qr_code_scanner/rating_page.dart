import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double personalRating = 0;
  double clubRating = 0;
  double trainingRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        backgroundColor: ThemeColors.base100,
        iconColor: Colors.white,
        buttonColor: Colors.white,
        showBackButton: true,
        title: Tooltip(
          message: 'Оценка',
          child: Text(
            'Оценка',
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            20.height,
            Text(
              'Как прошел ваш визит?',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
            30.height,
            Container(
              padding: EdgeInsets.all(16.r),
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
                      color: ThemeColors.base400,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.height,
                  Row(
                    children: [
                      StarRating(
                        rating: personalRating,
                        size: 62.r,
                        emptyIcon: Icons.star_border,
                        filledIcon: Icons.star,
                        borderColor: ThemeColors.base200,
                        onRatingChanged: (rating) {
                          print('object rating changed $rating');
                          personalRating = rating;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            20.height,
            Container(
              padding: EdgeInsets.all(16.r),
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
                      color: ThemeColors.base400,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.height,
                  Row(
                    children: [
                      StarRating(
                        rating: clubRating,
                        size: 62.r,
                        emptyIcon: Icons.star_border,
                        filledIcon: Icons.star,
                        borderColor: ThemeColors.base200,
                        onRatingChanged: (rating) {
                          print('object rating changed $rating');
                          clubRating = rating;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            20.height,
            Container(
              padding: EdgeInsets.all(16.r),
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
                      color: ThemeColors.base400,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.height,
                  Row(
                    children: [
                      StarRating(
                        rating: trainingRating,
                        size: 62.r,
                        emptyIcon: Icons.star_border,
                        filledIcon: Icons.star,
                        borderColor: ThemeColors.base200,
                        onRatingChanged: (rating) {
                          print('object rating changed $rating');
                          trainingRating = rating;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.base200),
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
              isEnabled: (personalRating != 0 && clubRating != 0 && trainingRating != 0),
              onPressed: () {
                print('object ${personalRating == 0 && clubRating == 0 && trainingRating == 0}');
                context.router.push(FeedbackRoute());
                // context.router.maybePop();
              },
              text: 'Продолжить',
            ),
          ],
        ),
      ),
    );
  }
}
