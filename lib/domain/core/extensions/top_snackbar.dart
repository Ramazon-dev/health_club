import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_club/design_system/design_system.dart';

enum SneakBarStatus { success, error, warning }

extension SneakBarStatusExtension on SneakBarStatus {
  Color get backgroundColor {
    switch (this) {
      case SneakBarStatus.success:
        return Colors.green;
      case SneakBarStatus.error:
        return Colors.red;
      case SneakBarStatus.warning:
        return Colors.orange;
    }
  }

  String get icon {
    switch (this) {
      case SneakBarStatus.success:
        return AppAssets.done;
      case SneakBarStatus.error:
        return AppAssets.cancel;
      case SneakBarStatus.warning:
        return AppAssets.done;
    }
  }
}

class CustomSneakBar {
  static Future<void> show({required BuildContext context, required SneakBarStatus status, required String title}) {
    return showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      reverseTransitionDuration: const Duration(milliseconds: 700),
      transitionDuration: const Duration(milliseconds: 700),
      barrierColor: Colors.transparent,
      builder: (context, controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.black),
          child: Flash(
            controller: controller,
            position: FlashPosition.top,
            child: FlashBar(
              controller: controller,
              position: FlashPosition.top,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.all(16.r),
              content: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.primaryColor.withValues(alpha: 0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      // decoration: BoxDecoration(color: status.backgroundColor, borderRadius: BorderRadius.circular(12)),
                      // padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        status.icon,
                        width: 24.r,
                        height: 24.r,
                        colorFilter: ColorFilter.mode(ThemeColors.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
