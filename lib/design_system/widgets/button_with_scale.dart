import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class ButtonWithScale extends StatefulWidget {
  final double radius;
  final double horizontalPadding, verticalPadding;
  final double horizontalMargin, verticalMargin;
  final double? height, width;
  final Function()? onPressed;
  final Widget? child;
  final String? text;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isEnabled;
  final Color? loadingColor;
  final List<BoxShadow>? shadow;

  const ButtonWithScale({
    super.key,
    this.radius = 12,
    this.horizontalPadding = 18,
    this.verticalPadding = 18,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.height,
    this.width,
    this.onPressed,
    this.child,
    this.text,
    this.color,
    this.borderColor,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
    this.loadingColor,
    this.shadow,
  });

  @override
  State<ButtonWithScale> createState() => _ButtonWithScaleState();
}

class _ButtonWithScaleState extends State<ButtonWithScale> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WScaleAnimation(
          onTap: widget.onPressed,
          isDisabled: widget.onPressed == null || widget.isLoading || !widget.isEnabled,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height,
            padding: (widget.isLoading)
                ? EdgeInsets.all(18)
                : EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
            margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin, vertical: widget.verticalMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: (widget.onPressed != null && widget.isEnabled)
                  ? (widget.color ?? ThemeColors.primaryColor)
                  : ThemeColors.disabledColor,
              border: widget.borderColor != null ? Border.all(color: widget.borderColor!) : null,
              // gradient: (widget.onPressed != null && widget.color == null && widget.isEnabled)
              //     ? LinearGradient(
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //         colors: ThemeColors.boxGradientViolet,
              //       )
              //     : null,
              boxShadow:
                  widget.shadow ??
                  [
                    BoxShadow(color: Color(0x1a2D9994), offset: Offset(0, 2), blurRadius: 4),
                    BoxShadow(color: Color(0x1a2D9994), offset: Offset(0, 8), blurRadius: 8),
                    BoxShadow(color: Color(0x0d2D9994), offset: Offset(0, 18), blurRadius: 11),
                    BoxShadow(color: Color(0x0d2D9994), offset: Offset(0, 33), blurRadius: 13),
                    BoxShadow(color: Color(0x002D9994), offset: Offset(0, 51), blurRadius: 14),
                  ],
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox(
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator(
                      color: widget.loadingColor ?? ThemeColors.white50,
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : widget.child ??
                      Text(
                        widget.text ?? '',
                        style:
                            widget.textStyle ??
                            TextStyle(
                              color: (widget.onPressed != null && widget.isEnabled)
                                  ? Colors.white
                                  : ThemeColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
          ),
        ),
      ],
    );
  }
}
