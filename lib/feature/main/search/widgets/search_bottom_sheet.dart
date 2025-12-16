import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/feature/main/search/widgets/filter_bottom_sheet.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../../design_system/design_system.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final listOfCategories = ['Все', 'Посещенные', 'Только 35HC', 'Со скидки'];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 300 / 1.sh,
      minChildSize: 300 / 1.sh,
      maxChildSize: 0.8,
      snap: true,
      snapSizes: [300 / 1.sh, 0.8],
      shouldCloseOnMinExtent: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ),
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5.r,
                width: 60.r,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: ThemeColors.black100),
              ),
            ),
            15.height,
            // TextFormField(decoration: InputDecoration(hintText: 'search')),
            SizedBox(
              height: 54.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.router.push(SearchRoute());
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeColors.base100,
                          // color: context.color.color50,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.search,
                              height: 20.r,
                              width: 20.r,
                              colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Поиск',
                              style: TextStyle(
                                color: ThemeColors.base400,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  WScaleAnimation(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => FilterBottomSheet(),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ThemeColors.base100,

                            // color: state.hasActiveFilters ? ThemeColors.black950 : context.color.color50,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.settings,
                            // colorFilter: ColorFilter.mode(
                            // state.hasActiveFilters ? Colors.white : context.color.color400,
                            // BlendMode.srcIn,
                            // ),
                          ),
                        ),
                        // if (state.hasActiveFilters)
                        //   Positioned(
                        //     top: 8,
                        //     right: 8,
                        //     child: Container(
                        //       width: 8,
                        //       height: 8,
                        //       decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.height,
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index == 0 ? ThemeColors.primaryColor : ThemeColors.base100,
                  ),
                  child: Text(
                    listOfCategories[index],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: index == 0 ? Colors.white : ThemeColors.black950,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5.r),
                itemCount: listOfCategories.length,
              ),
            ),
            20.height,
            ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: ThemeColors.base100,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.primaryColor.withValues(alpha: 0.2),
                      offset: const Offset(0, 8),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    context.router.push(FitnessRoute());
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.yellow, radius: 24.r),
                          10.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Premium Fitness Center',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors.baseBlack,
                                ),
                              ),
                              2.height,
                              Row(
                                children: [
                                  Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 20.r),
                                  SizedBox(width: 5.w),
                                  Text(
                                    '4.8 ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.black950,
                                    ),
                                  ),
                                  Text(
                                    '(1 154 отзывов)',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.base400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      25.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 3.r, backgroundColor: ThemeColors.flowKitGreen),
                                  5.width,
                                  Text(
                                    'Открыто до 18:00',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.flowKitGreen,
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Text(
                                '3 км от вас',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.base400,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(AppAssets.map, height: 54.r, width: 54.r),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            ),
          ],
        ),
      ),
    );
  }
}
