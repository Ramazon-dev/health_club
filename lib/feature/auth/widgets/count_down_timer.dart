import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../design_system/theme/colors.dart';


class ResendCodeTimer extends StatefulWidget {
  final VoidCallback onTap;
  final ResendTimerController controller;

  const ResendCodeTimer({super.key, required this.controller, required this.onTap});

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  @override
  void initState() {
    super.initState();
    widget.controller.start();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.secondsLeft,
      builder: (context, seconds, _) {
        if (seconds == 0) {
          return TextButton(
            onPressed: widget.onTap,
            child: Text(
              'Отправить код повторно',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ThemeColors.baseBlack),
            ),
          );
        } else {
          return Text(
            'Отправить код повторно можно через $seconds сек',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.baseBlack,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          );
        }
      },
    );
  }
}

class ResendTimerController {
  final int initialSeconds;
  final ValueNotifier<int> secondsLeft;
  Timer? _timer;

  ResendTimerController({this.initialSeconds = 30}) : secondsLeft = ValueNotifier<int>(initialSeconds);

  void start() {
    _timer?.cancel();
    secondsLeft.value = initialSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    secondsLeft.dispose();
  }
}
