import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double slider = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5.r,
              width: 60.r,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: ThemeColors.black100),
            ),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              92.width,
              Text(
                'Фильтр',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.trash,
                    height: 20.r,
                    width: 20.r,
                    colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                  ),
                  5.width,
                  Text(
                    'Сбросить',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          20.height,
          Text(
            'Тип заведения',
            style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          10.height,
          AppCheckboxListTile(
            context: context,
            value: true,
            onChanged: (value) {},
            checkboxColor: ThemeColors.primaryColor,
            text: 'Филиалы 35HC',
          ),
          AppCheckboxListTile(
            context: context,
            value: false,
            onChanged: (value) {},
            checkboxColor: ThemeColors.primaryColor,
            text: 'Партнеры (Абонемент)',
          ),
          AppCheckboxListTile(
            context: context,
            value: false,
            onChanged: (value) {},
            checkboxColor: ThemeColors.primaryColor,
            text: 'Партнеры (Скидка)',
          ),
          20.height,
          Divider(),
          20.height,
          Text(
            'Категория партнера',
            style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          10.height,
          DropdownButtonFormField(
            value: null,
            enableFeedback: true,
            isExpanded: true,
            onChanged: (value) {},
            items: [
              DropdownMenuItem(value: 1, child: Text('data1')),
              DropdownMenuItem(value: 2, child: Text('data2')),
              DropdownMenuItem(value: 3, child: Text('data3')),
            ],
            icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400),
            decoration: InputDecoration(
              filled: true,
              fillColor: ThemeColors.base50,
              hintText: 'Выбрать категорию',
              contentPadding: EdgeInsets.all(15.r),
            ),
          ),
          20.height,
          Divider(),
          20.height,
          Text(
            'Радиус',
            style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('500 m', style: Theme.of(context).textTheme.bodyLarge),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: ThemeColors.base100,
                    inactiveTrackColor: ThemeColors.base100,
                    inactiveTickMarkColor: ThemeColors.base100,
                    thumbColor: ThemeColors.primaryColor,
                    valueIndicatorColor: ThemeColors.primaryColor,
                    valueIndicatorTextStyle: TextStyle(color: Colors.white),
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    value: slider,
                    min: 0.5,
                    max: 10,
                    label: '$slider km',
                    divisions: 19,
                    onChanged: (value) {
                      slider = value;

                      setState(() {});
                    },
                  ),
                ),
              ),
              Text('10 km', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          20.height,
          Divider(),
          40.height,
          ButtonWithScale(
            // isLoading: isLoading,
            onPressed: () {},
            text: 'Применить',
          ),
          15.height,
        ],
      ),
    );
  }
}
