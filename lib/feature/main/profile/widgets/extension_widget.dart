import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

import '../../../../app_bloc/app_bloc.dart';

class ExtensionWidget extends StatelessWidget {
  const ExtensionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserMeCubit, UserMeState>(
      builder: (context, state) {
        if (state is! UserMeLoaded) return SizedBox();
        final user = state.userMe;
        final extensionIsActive = (user.plus ?? 0) > 0;
        if (!extensionIsActive) return SizedBox();
        return Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0x33ffffff)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Расширения PLUS',
                    style: TextStyle(color: ThemeColors.white50, fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  10.height,
                  Row(
                    children: [
                      Text(
                        "Осталось дней: ${user.plus ?? 0}",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
