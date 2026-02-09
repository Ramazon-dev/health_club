import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/main/profile/widgets/custom_material_localization_delegate.dart';

import '../../../../design_system/design_system.dart';

class FreezeSubscriptionBottomSheet extends StatefulWidget {
  final ValueNotifier<DateTimeRange<DateTime>?> rangeNotifier;
  final VoidCallback onTap;

  const FreezeSubscriptionBottomSheet({super.key, required this.rangeNotifier, required this.onTap});

  @override
  State<FreezeSubscriptionBottomSheet> createState() => _FreezeSubscriptionBottomSheetState();
}

class _FreezeSubscriptionBottomSheetState extends State<FreezeSubscriptionBottomSheet> {
  final ValueNotifier<String?> rangeValidatorNotifier = ValueNotifier(null);
  final TextEditingController rangeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Заморозить членство',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: ThemeColors.baseBlack),
        ),
        10.height,

        Text(
          'Выберите период заморозки членство',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.base400),
        ),
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
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 100)),
              helpText: 'минимальный период 5 дней',
              builder: (context, child) => Localizations.override(
                context: context,
                locale: Locale('ru', 'RU'),
                delegates: [
                  CustomMaterialLocalizationsDelegate(),
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                child: child ?? SizedBox.shrink(),
              ),
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
              widget.rangeNotifier.value = range;
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
        (kBottomNavigationBarHeight * 2.3).height,
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
                if (rangeController.text.isEmpty) {
                  rangeValidatorNotifier.value = 'Период не может быть меньше 5 дней';
                  return;
                }
                widget.onTap.call();
              },
              text: 'Подтвердить',
            ),
          ],
        ),
      ],
    );
  }
}
