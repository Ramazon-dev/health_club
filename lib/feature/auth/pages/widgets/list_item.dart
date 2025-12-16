import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class ListItem extends StatelessWidget {
  final bool selected;
  final String title;

  const ListItem({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: selected ? ThemeColors.primaryColor : Colors.white,
        border: Border.all(color: ThemeColors.base200),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: selected ? Colors.white : Colors.black),
      ),
    );
  }
}
