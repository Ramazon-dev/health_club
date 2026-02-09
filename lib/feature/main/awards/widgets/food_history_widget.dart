import 'package:flutter/material.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../data/network/model/nutrition_diary_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../design_system/widgets/network_image.dart';

class FoodHistoryWidget extends StatefulWidget {
  final List<NutritionDiaryResponse> nutrition;
  final DateTime selectedDay;

  const FoodHistoryWidget({super.key, required this.nutrition, required this.selectedDay});

  @override
  State<FoodHistoryWidget> createState() => _FoodHistoryWidgetState();
}

class _FoodHistoryWidgetState extends State<FoodHistoryWidget> {
  final ValueNotifier<MealsResponse?> selectedNutritionNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final nutrition = widget.nutrition.where((element) => element.date?.isSameDay(widget.selectedDay) == true).toList();
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => 1.height,
      itemCount: nutrition.length,
      itemBuilder: (context, index) {
        final nutritionDay = nutrition[index];
        final breakfasts = nutritionDay.breakfast?.analysis?.mealsResponse;
        final lunch = nutritionDay.lunch?.analysis?.mealsResponse;
        final dinner = nutritionDay.dinner?.analysis?.mealsResponse;
        return ValueListenableBuilder(
          valueListenable: selectedNutritionNotifier,
          builder: (context, selectedNutrition, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((breakfasts != null && breakfasts.isNotEmpty) ||
                  (lunch != null && lunch.isNotEmpty) ||
                  (dinner != null && dinner.isNotEmpty))
                ...[
                  24.height,
                  Text(
                    nutrition[index].date?.dateFormat() ?? '',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.base400),
                  ),
                ],
              if (breakfasts != null && breakfasts.isNotEmpty) ...[
                8.height,
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final breakfast = breakfasts[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedNutrition?.name == breakfast.name) {
                          selectedNutritionNotifier.value = null;
                        } else {
                          selectedNutritionNotifier.value = breakfast;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      AppNetworkImage(
                                        imageUrl: breakfast.photoUrl ?? '',
                                        height: 64.r,
                                        width: 64.r,
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      8.width,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'завтрак',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.base400,
                                              ),
                                            ),
                                            5.height,
                                            Text(
                                              '${breakfast.calories ?? 0} ккал',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.statusOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  selectedNutrition?.name == breakfast.name
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: ThemeColors.base200,
                                  size: 24.r,
                                ),
                              ],
                            ),
                            if (selectedNutrition?.name == breakfast.name) ...[
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 24.r),
                                  5.width,
                                  Text(
                                    '${breakfast.rating ?? 0}/10',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: 80.r,
                                  //   padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8.r),
                                  //     color: ThemeColors.base100,
                                  //   ),
                                  //   child: Column(
                                  //     children: [
                                  //       Text(
                                  //         '${breakfast.calories}',
                                  //         style: TextStyle(
                                  //           fontSize: 16.sp,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: ThemeColors.baseBlack,
                                  //         ),
                                  //       ),
                                  //       5.height,
                                  //       Text(
                                  //         'ккал',
                                  //         style: TextStyle(
                                  //           fontSize: 14.sp,
                                  //           fontWeight: FontWeight.w400,
                                  //           color: ThemeColors.base400,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Container(
                                      // width: 80.r,
                                      padding: EdgeInsets.symmetric(vertical: 6.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: ThemeColors.base100,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${breakfast.protein}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.baseBlack,
                                            ),
                                          ),
                                          5.height,
                                          Text(
                                            'белки',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  5.width,
                                  Expanded(
                                    child: Container(
                                      // width: 80.r,
                                      padding: EdgeInsets.symmetric(vertical: 6.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: ThemeColors.base100,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${breakfast.fat}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.baseBlack,
                                            ),
                                          ),
                                          5.height,
                                          Text(
                                            'жиры',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  5.width,
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: ThemeColors.base100,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${breakfast.carbs}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.baseBlack,
                                            ),
                                          ),
                                          5.height,
                                          Text(
                                            'углеводы',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              5.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ThemeColors.base100,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        breakfast.verdict ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.baseBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              8.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: ThemeColors.primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.aiInnovation),
                                    5.width,
                                    Expanded(
                                      child: Text(
                                        breakfast.recommendation ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.white50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 8.height,
                  itemCount: breakfasts.length,
                ),
              ],
              5.height,
              if (lunch != null && lunch.isNotEmpty) ...[
                // 24.height,
                // Text(
                //   nutrition[index].date?.dateFormat() ?? '',
                //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.base400),
                // ),
                8.height,
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final food = lunch[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedNutrition?.name == food.name) {
                          selectedNutritionNotifier.value = null;
                        } else {
                          selectedNutritionNotifier.value = food;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      AppNetworkImage(
                                        imageUrl: food.photoUrl ?? '',
                                        height: 64.r,
                                        width: 64.r,
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      8.width,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Обед',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.base400,
                                              ),
                                            ),
                                            5.height,
                                            Text(
                                              '${food.calories ?? 0} ккал',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.statusOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  selectedNutrition?.name == food.name
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: ThemeColors.base200,
                                  size: 24.r,
                                ),
                              ],
                            ),
                            if (selectedNutrition?.name == food.name) ...[
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 24.r),
                                  5.width,
                                  Text(
                                    '${food.rating ?? 0}/10',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.calories}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'ккал',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.protein}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'белки',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.fat}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'жиры',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.carbs}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'углеводы',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              5.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ThemeColors.base100,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        food.verdict ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.baseBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              8.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: ThemeColors.primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.aiInnovation),
                                    5.width,
                                    Expanded(
                                      child: Text(
                                        food.recommendation ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.white50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 8.height,
                  itemCount: lunch.length,
                ),
              ],
              5.height,
              if (dinner != null && dinner.isNotEmpty) ...[
                // 24.height,
                // Text(
                //   nutrition[index].date?.dateFormat() ?? '',
                //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.base400),
                // ),
                8.height,
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final food = dinner[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedNutrition?.name == food.name) {
                          selectedNutritionNotifier.value = null;
                        } else {
                          selectedNutritionNotifier.value = food;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      AppNetworkImage(
                                        imageUrl: food.photoUrl ?? '',
                                        height: 64.r,
                                        width: 64.r,
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      8.width,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ужин',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.base400,
                                              ),
                                            ),
                                            5.height,
                                            Text(
                                              '${food.calories ?? 0} ккал',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.statusOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Icon(
                                  selectedNutrition?.name == food.name
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: ThemeColors.base200,
                                  size: 24.r,
                                ),
                              ],
                            ),
                            if (selectedNutrition?.name == food.name) ...[
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 24.r),
                                  5.width,
                                  Text(
                                    '${food.rating ?? 0}/10',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.calories}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'ккал',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.protein}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'белки',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80.r,
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.fat}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'жиры',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 14.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: ThemeColors.base100,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${food.carbs}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          'углеводы',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              5.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ThemeColors.base100,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        food.verdict ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.baseBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              8.height,
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: ThemeColors.primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.aiInnovation),
                                    5.width,
                                    Expanded(
                                      child: Text(
                                        food.recommendation ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.white50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 8.height,
                  itemCount: dinner.length,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
