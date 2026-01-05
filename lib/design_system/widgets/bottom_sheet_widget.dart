import 'package:flutter/material.dart';
import '../design_system.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<Widget> widgets;

  const BottomSheetWidget({super.key, required this.widgets});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.8.sh,
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          10.height,
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5.r,
              width: 60.r,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: ThemeColors.black100),
            ),
          ),
          15.height,
          ...widget.widgets,
          20.height,
        ],
      ),
    );
  }
}
