import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../design_system/widgets/button_widgets.dart';


extension SnacBarExt on BuildContext {
  showSnackBar(
    String message, {
    int duration = 1,
    Color? backgroundColor,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: duration),
        backgroundColor: backgroundColor ?? Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
        ),
      ),
    );
  }

  showDialogExt(
    BuildContext context, {
    required String message,
    required VoidCallback yes,
  }) {
    return showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          PrimaryButton(
            onPressed: yes,
            text: 'Yes',
            size: Size(80.w, 35.h),
            padding: EdgeInsets.zero,
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(),
            text: 'No',
            size: Size(80.w, 35.h),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
