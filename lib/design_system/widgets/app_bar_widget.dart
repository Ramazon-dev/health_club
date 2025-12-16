import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class AppbarWidget extends AppBar {
  AppbarWidget({
    super.key,
    super.title,
    super.automaticallyImplyLeading,
    bool showBackButton = true,
    bool showDivider = false,
    bool centerTitle = true,
    Widget? leading,
    List<Widget>? actions,
    Color iconColor = Colors.white,
    Color buttonColor = ThemeColors.base100,
    Color backgroundColor = Colors.white,
    PreferredSize? bottom,
  }) : super(
         elevation: 0,
         foregroundColor: backgroundColor,
         backgroundColor: backgroundColor,
         surfaceTintColor: backgroundColor,
         toolbarHeight: kToolbarHeight + 10.h,
         leadingWidth: 20.w + 54.h,
         shadowColor: Colors.transparent,
         centerTitle: centerTitle,
         leading: showBackButton
             ? Builder(
                 builder: (context) => InkWell(
                   onTap: () {
                     Navigator.of(context).maybePop();
                   },
                   child: Center(
                     child: Container(
                       margin: EdgeInsets.only(left: 16.r, top: 10.h),
                       height: 54.h,
                       width: 54.h,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: buttonColor),
                       child: leading ?? Icon(Icons.arrow_back_ios_outlined, color: Colors.black, size: 18.sp),
                     ),
                   ),
                 ),
               )
             : null,
         actionsPadding: EdgeInsets.only(right: 20.w, left: 6.w),
         actions: actions
             ?.map(
               (e) => Container(
                 margin: EdgeInsets.only(left: 4.w, top: 10.h),
                 height: 54.h,
                 width: 54.h,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: iconColor),
                 child: e,
               ),
             )
             .toList(),
         bottom:
             bottom ??
             (showDivider
                 ? PreferredSize(
                     preferredSize: Size.fromHeight(16.0),
                     child: Divider(
                       color: ThemeColors.inputFillColor,
                       height: 1.0,
                       thickness: 1.0,
                       indent: 20.0.w,
                       endIndent: 20.0.w,
                     ),
                   )
                 : null),
       );
}
