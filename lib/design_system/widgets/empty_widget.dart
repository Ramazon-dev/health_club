import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 100.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.height,
            Text(
              'Список пуст',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            // SizedBox(height: 5.0),
            // Text(
            //   'Список пуст',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff888888)),
            // ),
          ],
        ),
      ),
    );
  }
}
