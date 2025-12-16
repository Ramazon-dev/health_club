import 'package:flutter/material.dart';
import '../design_system.dart';

class PrimaryButton extends ElevatedButton {
  PrimaryButton({
    super.key,
    required super.onPressed,
    required String text,
    final EdgeInsetsGeometry? padding,
    final Size? maximumSize,
    final Size? minimumSize,
    final Size? size,
    final bool? isLoading,
    final Color? circularColor,
    final Color? backgroundColor = ThemeColors.primaryColor,
    final double? radius,
    final double? textSize,
  }) : super(
    child: isLoading == true
        ? Center(
      child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
    )
        : Text(
      text,
      style: TextStyle(
        fontSize: textSize ?? 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      maximumSize: maximumSize,
      minimumSize: minimumSize,
      padding: padding,
      backgroundColor: backgroundColor,
      elevation: 0,
      disabledBackgroundColor: Color(0xfff5f5f5),
      disabledForegroundColor: Color(0xfff5f5f5),
      fixedSize: maximumSize == null ? size ?? Size(1.sw, 60.h) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10.r),
      ),
    ),
  );

  PrimaryButton.icon({
    super.key,
    required super.onPressed,
    required String text,
    required IconData icon,
    final EdgeInsetsGeometry? padding,
    final Size? maximumSize,
    final Size? minimumSize,
    final bool? isLoading,
    final Size? size,
    final double? textSize,
    final Color? backgroundColor,
    final double? radius,
  }) : super(
    child: isLoading == true
        ? Center(
      child: CircularProgressIndicator.adaptive(),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(width: 10.r),
        Text(
          text,
          style: TextStyle(
            fontSize: textSize ?? 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      maximumSize: maximumSize,
      minimumSize: minimumSize,
      padding: padding,
      backgroundColor: backgroundColor,
      elevation: 0,
      disabledBackgroundColor: Color(0xfff5f5f5),
      disabledForegroundColor: Color(0xfff5f5f5),
      fixedSize: maximumSize == null ? size ?? Size(320.r, 48.h) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10.r),
      ),
    ),
  );
}

class PrimaryButton2 extends ElevatedButton {
  PrimaryButton2({
    super.key,
    required super.onPressed,
    required String text,
    final EdgeInsetsGeometry? padding,
    final Size? maximumSize,
    final Size? minimumSize,
    final Size? size,
    final bool? isLoading,
    final Color? circularColor,
    final Color? backgroundColor,
    final Color? textColor,
    final double? radius,
    final double? textSize,
  }) : super(
    child: isLoading == true
        ? Center(
      child: CircularProgressIndicator.adaptive(),
    )
        : Text(
      text,
      style: TextStyle(
        fontSize: textSize ?? 14.sp,
        fontWeight: FontWeight.w500,
        color: textColor ?? ThemeColors.baseBlack,
      ),
    ),
    style: ElevatedButton.styleFrom(
      maximumSize: maximumSize,
      minimumSize: minimumSize,
      padding: padding,
      elevation: 0,
      backgroundColor: backgroundColor ?? ThemeColors.graphite100,
      disabledBackgroundColor: Color(0xfff5f5f5),
      disabledForegroundColor: Color(0xfff5f5f5),
      fixedSize: maximumSize == null ? size ?? Size(320.r, 48.h) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10.r),
      ),
    ),
  );
}

class SecondaryButton extends ElevatedButton {
  SecondaryButton({
    super.key,
    required super.onPressed,
    required String text,
    final Size? size,
    final Color? borderColor,
    final Color? textColor,
    final double? elevation = 0,
    final Color? backgroundColor,
    final double? borderRadius,
  }) : super(
    child: Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ThemeColors.baseBlack,
        ),
      ),
    ),
    style: ElevatedButton.styleFrom(
      fixedSize: size ?? Size(1.sw, 60.h),
      elevation: elevation,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
        side: BorderSide(color: Color(0xffe5e5e5), width: 1),
      ),
    ),
  );

  SecondaryButton.icon({
    super.key,
    required super.onPressed,
    required String text,
    required Widget icon,
    final EdgeInsetsGeometry? padding,
    final Size? maximumSize,
    final Size? minimumSize,
    final bool? isLoading,
    final Size? size,
    final double? textSize,
    final Color? backgroundColor,
    final double? radius,
    final double? elevation = 0,
  }) : super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 10.r),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      fixedSize: size ?? Size(1.sw, 50.h),
      elevation: elevation,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10.r),
        side: BorderSide(color: ThemeColors.base200, width: 1.r),
      ),
    ),
  );
}

class TextButtonWidget extends TextButton {
  TextButtonWidget({
    super.key,
    required super.onPressed,
    required String text,
    final bool? isLoading,
    final Color? circularColor,
    final TextStyle? style,
  }) : super(
    child: isLoading == true
        ? Center(
      child: CircularProgressIndicator.adaptive(),
    )
        : Text(
      text,
      style: style ?? TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
