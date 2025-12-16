import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_widgets.dart';

extension DialogExt on BuildContext {
  dialog({
    required String title,
    required void Function() onCancelled,
    required void Function() onConfirm,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog(
      context: this,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondaryButton(
                    onPressed: () {
                      context.maybePop();
                      onCancelled();
                    },
                    text: cancelText ?? 'context.lang.cancel',
                    size: Size(0.36.sw, 50.h),
                  ),
                  PrimaryButton(
                    size: Size(0.36.sw, 50.h),
                    onPressed: () {
                      context.router.maybePop();
                      onConfirm();
                    },
                    text: confirmText ?? 'context.lang.confirm',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialogWithSubtitle({
    required String title,
    required String subtitle,
    required void Function() onCancelled,
    required void Function() onConfirm,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog(
      context: this,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondaryButton(
                    onPressed: onCancelled,
                    text: cancelText ?? 'Отменить',
                    size: Size(0.36.sw, 50.h),
                  ),
                  PrimaryButton(
                    size: Size(0.36.sw, 50.h),
                    onPressed: () {
                      context.router.maybePop();
                      onConfirm();
                    },
                    text: confirmText ?? 'Да',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showDynamicDialog({
    required List<Widget> widgets,
}) {
    return showDialog(
      context: this,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(31.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              ...widgets,
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Закрыть',
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
