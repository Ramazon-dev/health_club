import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../design_system/design_system.dart';
import '../../../../domain/core/core.dart';

class DailyMetricsBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final Function()? sleepDuration;
  final String title;

  const DailyMetricsBottomSheet({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.title,
    this.sleepDuration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.7.sh,
      child: BottomSheetWidget(
        widgets: [
          Text(
            'Заполните данные за текущий день',
            style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          5.height,
          InkWell(
            onTap: sleepDuration,
            child: TextFormField(
              autofocus: sleepDuration == null,
              enabled: sleepDuration == null,
              controller: controller,
              buildCounter: (context, {required currentLength, required isFocused, required maxLength}) =>
                  SizedBox(),
              maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '0'),
            ),
          ),
          // Spacer(),
          40.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWithScale(
                width: 0.45.sw,
                height: 60.h,
                color: ThemeColors.base100,
                onPressed: () {
                  context.router.maybePop();
                },
                text: 'Отмена',
                textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
              ),
              BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                listener: (context, state) async {
                  final router = context.router;
                  if (state is DashboardMetricsLoaded) {
                    router.maybePop();
                    await CustomSneakBar.show(
                      context: context,
                      status: SneakBarStatus.success,
                      title: 'Дневной отчет успешно изменен!',
                    );
                  } else if (state is DashboardMetricsError) {
                    router.maybePop();
                    await CustomSneakBar.show(
                      context: context,
                      status: SneakBarStatus.error,
                      title: state.message ?? 'Что-то пошло не так',
                    );
                  }
                },
                builder: (context, state) => ButtonWithScale(
                  isLoading: state is DashboardMetricsLoading,
                  width: 0.45.sw,
                  height: 60.h,
                  onPressed: onPressed,
                  text: 'Сохранить',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
