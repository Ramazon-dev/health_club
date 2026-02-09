import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../data/network/model/slot_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../di/init.dart';

class BookingBottomSheet extends StatefulWidget {
  final BookSlotCubit bookSlotCubit;
  final int id;
  final TextEditingController dateController;
  final bool extensionIsActive;
  final bool subscriptionIsActive;
  final bool isBookingsSpend;

  const BookingBottomSheet({
    super.key,
    required this.id,
    required this.bookSlotCubit,
    required this.dateController,
    required this.extensionIsActive,
    required this.subscriptionIsActive,
    required this.isBookingsSpend,
  });

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  final ValueNotifier<SlotResponse?> selectedTimeNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime> selectedDateNotifier = ValueNotifier(DateTime.now());
  final slotsCubit = getIt<SlotsCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider.value(value: widget.slotsCubit),
        BlocProvider(create: (context) => slotsCubit),
        BlocProvider.value(value: widget.bookSlotCubit),
      ],
      child: Column(
        children: [
          20.height,
          if (!widget.subscriptionIsActive)
            Center(
              child: Text(
                'Нет активной подписки',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
              ),
            )
          else if (!widget.extensionIsActive)
            Center(
              child: Text(
                'Нет Расширения PLUS',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
              ),
            )
          else if (!widget.isBookingsSpend)
            Center(
              child: Text(
                'На эту неделю все 2 посещения уже использованы. Мы с радостью откроем новые посещения на следующей неделе',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
              ),
            )
          else ...[
            Text(
              'Бронирование',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: ThemeColors.baseBlack),
            ),
            10.height,
            Text(
              'Выберите дату и время для тренировки:',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.base400),
            ),
            40.height,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Выберите дату',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final now = DateTime.now();
                final date = await showDatePicker(
                  context: context,
                  firstDate: now,
                  lastDate: now.add(Duration(days: 7 - now.weekday)),
                );
                if (date == null) return;
                selectedDateNotifier.value = date;
                widget.dateController.text = date.dateForRequest();
                slotsCubit.getSlots(widget.id, date.weekday);
                selectedTimeNotifier.value = null;
                //       selectedTime.value = null;
              },
              child: TextFormField(
                enabled: false,
                controller: widget.dateController,
                decoration: InputDecoration(
                  hintText: 'Выберите дату',
                  suffixIcon: Icon(Icons.calendar_today_outlined, color: ThemeColors.base300, size: 22.r),
                ),
              ),
            ),
            10.height,
            20.height,
            BlocConsumer<SlotsCubit, SlotsState>(
              listener: (context, state) async {
                if (state is SlotsLoaded) {
                  if (state.slots.isEmpty) {
                    await CustomSneakBar.show(
                      context: context,
                      status: SneakBarStatus.error,
                      title: 'Нет свободных мест на ${selectedDateNotifier.value.dateFormat()}',
                    );
                  }
                }
              },
              builder: (context, state) {
                print('object slots cubit builder $state');
                if (state is SlotsLoaded) {
                  print('object slots cubit builder loaded ${state.slots.length}');
                  final slots = state.slots;
                  if (slots.isEmpty) {
                    return Center(
                      child: Text(
                        'Нет свободных мест на ${selectedDateNotifier.value.dateFormat()}',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Выберите время',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
                        ),
                      ),
                      10.height,
                      ValueListenableBuilder(
                        valueListenable: selectedTimeNotifier,
                        builder: (context, time, child) => Wrap(
                          spacing: 8.r,
                          runSpacing: 8.r,
                          children: state.slots
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    selectedTimeNotifier.value = e;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      color: time?.time == e.time ? ThemeColors.primaryColor : ThemeColors.base100,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      e.time ?? '',
                                      style: TextStyle(
                                        color: time?.time == e.time ? Colors.white : ThemeColors.baseBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  );
                } else if (state is SlotsError) {
                  return Center(
                    child: Text(
                      'Что-то пошло не так, попробуйте еще раз.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            20.height,
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
                  onPressed: () async {
                    final selectedTime = selectedTimeNotifier.value;
                    if (selectedTime == null) return;
                    final router = context.router;
                    await widget.bookSlotCubit.reserveSlot(selectedTime.id ?? 0);
                    router.maybePop();
                  },
                  text: 'Забронировать',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
