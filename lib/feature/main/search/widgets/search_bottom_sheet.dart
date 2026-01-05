import 'package:flutter/material.dart';
import 'package:health_club/domain/core/services/url_launcher_service.dart';
import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/network/model/map/map_point_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../domain/core/core.dart';

class SearchBottomSheet extends StatefulWidget {
  final MapPointsCubit mapPointsCubit;
  final MapPointDetailCubit mapPointDetailCubit;
  final List<MapPointResponse> mapPoints;
  final List<String> listOfCategories;

  const SearchBottomSheet({
    super.key,
    required this.mapPointsCubit,
    required this.mapPoints,
    required this.listOfCategories,
    required this.mapPointDetailCubit,
  });

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final selectedCategoryNotifier = ValueNotifier<int>(0);
  final debounce = Debounce(millisecond: 500);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('search bottom sheet ${widget.mapPoints.length}');
    return DraggableScrollableSheet(
      initialChildSize: 300 / 1.sh,
      minChildSize: 200 / 1.sh,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: [200 / 1.sh, 300 / 1.sh, 0.9],
      shouldCloseOnMinExtent: false,
      builder: (context, scrollController) => BlocProvider.value(
        value: widget.mapPointsCubit,
        child: BlocBuilder<MapPointsCubit, MapPointsState>(
          builder: (context, state) {
            return Container(
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
                  TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      debounce.run(() {
                        widget.mapPointsCubit.onSearch(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.r),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppAssets.search,
                          height: 20.r,
                          width: 20.r,
                          colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                        ),
                      ),
                      // suffixIcon: Icon(Icons.clear,color: ThemeColors.base400, size: 20.r),
                      hintText: 'search',
                      fillColor: ThemeColors.base100,
                      filled: true,
                    ),
                  ),
                  // SizedBox(
                  //   height: 54.h,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Expanded(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             context.router.push(SearchRoute());
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.all(15),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: ThemeColors.base100,
                  //               // color: context.color.color50,
                  //             ),
                  //             child: Row(
                  //               children: [
                  //                 SvgPicture.asset(
                  //                   AppAssets.search,
                  //                   height: 20.r,
                  //                   width: 20.r,
                  //                   colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                  //                 ),
                  //                 SizedBox(width: 10),
                  //                 Text(
                  //                   'Поиск',
                  //                   style: TextStyle(
                  //                     color: ThemeColors.base400,
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w400,
                  //                     height: 1,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       // SizedBox(width: 5),
                  //       // WScaleAnimation(
                  //       //   onTap: () {
                  //       //     showModalBottomSheet(
                  //       //       context: context,
                  //       //       isScrollControlled: true,
                  //       //       builder: (context) => FilterBottomSheet(),
                  //       //     );
                  //       //   },
                  //       //   child: Stack(
                  //       //     children: [
                  //       //       Container(
                  //       //         padding: EdgeInsets.all(15),
                  //       //         decoration: BoxDecoration(
                  //       //           borderRadius: BorderRadius.circular(10),
                  //       //           color: ThemeColors.base100,
                  //       //
                  //       //           // color: state.hasActiveFilters ? ThemeColors.black950 : context.color.color50,
                  //       //         ),
                  //       //         child: SvgPicture.asset(AppAssets.settings),
                  //       //       ),
                  //       //       // if (state.hasActiveFilters)
                  //       //       //   Positioned(
                  //       //       //     top: 8,
                  //       //       //     right: 8,
                  //       //       //     child: Container(
                  //       //       //       width: 8,
                  //       //       //       height: 8,
                  //       //       //       decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  //       //       //     ),
                  //       //       //   ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  10.height,
                  ValueListenableBuilder(
                    valueListenable: selectedCategoryNotifier,
                    builder: (context, selectedCategory, child) => SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            selectedCategoryNotifier.value = index;
                            widget.mapPointsCubit.onCategoryChanged(widget.listOfCategories[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: index == selectedCategory ? ThemeColors.primaryColor : ThemeColors.base100,
                            ),
                            child: Text(
                              widget.listOfCategories[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: index == selectedCategory ? Colors.white : ThemeColors.black950,
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(width: 5.r),
                        itemCount: widget.listOfCategories.length,
                      ),
                    ),
                  ),
                  20.height,
                  ListView.separated(
                    itemCount: widget.mapPoints.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final point = widget.mapPoints[index];
                      return Container(
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
                            if (widget.mapPointDetailCubit.state is! MapPointDetailLoading) {
                              widget.mapPointDetailCubit.getMapPointDetail(point.type ?? '', point.id ?? 0);
                            }
                            // context.router.push(FitnessRoute());
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomCachedNetworkImage(
                                    imageUrl: point.imageUrl ?? '',
                                    height: 48.r,
                                    width: 48.r,
                                    borderRadius: BorderRadius.circular(100),
                                    fit: BoxFit.contain,
                                  ),
                                  // CircleAvatar(backgroundColor: Colors.yellow, radius: 24.r),
                                  10.width,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          point.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
                                              '${point.rating ?? ''} ',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors.black950,
                                              ),
                                            ),
                                            Text(
                                              '(${point.reviewsCount} отзывов)',
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
                                          CircleAvatar(
                                            radius: 3.r,
                                            backgroundColor: point.isOpen == true
                                                ? ThemeColors.flowKitGreen
                                                : ThemeColors.red300,
                                          ),
                                          5.width,
                                          Text(
                                            point.isOpen == true ? 'Открыто до 18:00' : 'Закрыто',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: point.isOpen == true
                                                  ? ThemeColors.flowKitGreen
                                                  : ThemeColors.red300,
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
                                  if (point.lat != null && point.long != null)
                                    GestureDetector(
                                      onTap: () {
                                        final lat = point.lat ?? '';
                                        final long = point.long ?? '';
                                        if (lat.isEmpty && long.isEmpty) return;
                                        UrlLauncherService.openInExternalMap(
                                          lat: double.parse(point.lat ?? ''),
                                          long: double.parse(point.long ?? ''),
                                        );
                                      },
                                      child: SvgPicture.asset(AppAssets.map, height: 54.r, width: 54.r),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  ),
                  (kBottomNavigationBarHeight * 2).height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
