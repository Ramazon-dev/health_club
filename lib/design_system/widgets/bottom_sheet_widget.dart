import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/domain/core/extensions/date_format.dart';

import '../design_system.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<Widget> widgets;

  const BottomSheetWidget({super.key, required this.widgets});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final ValueNotifier<String?> rangeValidatorNotifier = ValueNotifier(null);
  final TextEditingController rangeController = TextEditingController();

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
          Text(
            'Заморозить членство',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: ThemeColors.baseBlack),
          ),
          10.height,

          Text(
            'Выберите период заморозки членство:',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.base400),
          ),
          ...widget.widgets,
          40.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Выберите период',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
            ),
          ),
          10.height,
          GestureDetector(
            onTap: () async {
              final range = await showDateRangePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.calendar,

                // initialDateRange: DateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(days: 5))),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 100)),
                helpText: 'минимальный период 5 дней',
              );
              if (range != null) {
                print('object range start is ${range.start} range end ${range.end}');
                print('object range check ${range.end.isBefore(range.start.add(Duration(days: 4)))}');
                print('object range duration ${range.end.difference(range.start).inDays}');
                if (range.end.isBefore(range.start.add(Duration(days: 4)))) {
                  rangeValidatorNotifier.value = 'Период не может быть меньше 5 дней';
                  rangeController.text = '';
                  return;
                }
                rangeController.text = '${range.start.dateFormat()} - ${range.end.dateFormat()}';
                rangeValidatorNotifier.value = null;
                print('object range controller ${rangeController.text}');
              }
            },
            child: TextFormField(
              controller: rangeController,
              enabled: false,
              decoration: InputDecoration(hintText: 'ДД.ММ.ГГГГ - ДД.ММ.ГГГГ'),
            ),
          ),
          5.height,

          ValueListenableBuilder(
            valueListenable: rangeValidatorNotifier,
            builder: (context, rangeValidator, child) {
              print('object range validator changed $rangeValidator');
              if (rangeValidator != null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rangeValidator,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: ThemeColors.red400),
                    ),
                    Icon(Icons.info_outline, color: ThemeColors.red400),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Spacer(),
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
              ButtonWithScale(
                width: 0.45.sw,
                height: 60.h,
                onPressed: () {
                  context.router.maybePop();
                },
                text: 'Перенести',
              ),
            ],
          ),
          20.height,
        ],
      ),
    );
  }
}
