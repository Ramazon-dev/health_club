import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const ProfileButton({super.key, required this.title, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 54.r,
                width: 54.r,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Color(0xfff5f5f5)),
                child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(ThemeColors.baseBlack, BlendMode.srcIn)),
              ),
            ),
            10.width,
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
