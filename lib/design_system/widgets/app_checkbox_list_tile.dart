import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppCheckboxListTile extends CheckboxListTile {
  final String? text;
  final Widget? titleWidget;
  final Color? checkboxColor;
  final BuildContext context;
  final ListTileControlAffinity? control;
  final double radius;

  AppCheckboxListTile({
    super.key,
    required super.value,
    required super.onChanged,
    super.subtitle,
    super.enabled,
    this.control,
    this.titleWidget,
    this.text,
    this.radius = 5,
    this.checkboxColor = ThemeColors.violet500,

    required this.context,
  }) : super(
         dense: true,
         checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
         side: BorderSide(color: ThemeColors.black100),
         contentPadding: EdgeInsets.zero,
         visualDensity: VisualDensity.compact,
         title:
             titleWidget ??
             Text(
               text ?? '',
               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
             ),
         checkboxScaleFactor: 1.2,
         controlAffinity: control ?? ListTileControlAffinity.trailing,
         overlayColor: WidgetStatePropertyAll(ThemeColors.primaryColor),
         fillColor: WidgetStateProperty.resolveWith((states) {
           if (states.contains(WidgetState.selected)) {
             return checkboxColor ?? ThemeColors.violet500;
           } else {
             return ThemeColors.base50;
           }
         }),
       );
}
