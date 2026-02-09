import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:health_club/di/init.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/network/model/map/map_point_response.dart';
import '../../../../data/network/model/slot_response.dart';
import '../../../../design_system/design_system.dart';

class CalendarBookingBottomSheet extends StatefulWidget {
  final List<MapPointResponse> partners;
  final BookSlotCubit bookSlotCubit;
  final DateTime selectedDate;
  final bool extensionIsActive;
  final bool subscriptionIsActive;
  final bool isBookingsSpend;

  const CalendarBookingBottomSheet({
    super.key,
    required this.bookSlotCubit,
    required this.partners,
    required this.selectedDate,
    required this.extensionIsActive,
    required this.subscriptionIsActive,
    required this.isBookingsSpend,
  });

  @override
  State<CalendarBookingBottomSheet> createState() => _CalendarBookingBottomSheetState();
}

class _CalendarBookingBottomSheetState extends State<CalendarBookingBottomSheet> {
  final ValueNotifier<SlotResponse?> selectedTimeNotifier = ValueNotifier(null);
  final selectedPartnerNotifier = ValueNotifier<MapPointResponse?>(null);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.bookSlotCubit),
        BlocProvider(create: (context) => getIt<SlotsCubit>()),
      ],
      child: ValueListenableBuilder(
        valueListenable: selectedPartnerNotifier,
        builder: (context, selectedPartner, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              if (!widget.subscriptionIsActive && !widget.extensionIsActive)
                Center(
                  child: Text(
                    'Нет активной подписки Расширение PLUS',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
                  ),
                )
              else if (!widget.subscriptionIsActive)
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
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.statusRed),
                  ),
                )
              else ...[
                Text(
                  'Выберите клуб',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                ),
                5.height,
                DropdownButtonFormField2(
                  value: selectedPartner,
                  enableFeedback: true,
                  isExpanded: true,
                  onChanged: (value) {
                    selectedPartnerNotifier.value = value;
                    if (value != null) {
                      context.read<SlotsCubit>().getSlots(value.id ?? 0, widget.selectedDate.weekday);
                    }
                  },
                  selectedItemBuilder: (context) => widget.partners.map((e) {
                    return Text(e.title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis);
                  }).toList(),
                  items: widget.partners
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors.baseBlack,
                                ),
                              ),
                              Text(
                                e.address ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.base400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.r, bottom: 15, right: 15.r),
                  ),
                ),
                20.height,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Выберите время',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
                  ),
                ),
                20.height,
                BlocConsumer<SlotsCubit, SlotsState>(
                  listener: (context, state) async {
                    if (state is SlotsLoaded) {
                      if (state.slots.isEmpty) {
                        await CustomSneakBar.show(
                          context: context,
                          status: SneakBarStatus.error,
                          title: 'Нет свободных мест на ${widget.selectedDate.dateFormat()}',
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is SlotsLoaded) {
                      final slots = state.slots;
                      if (slots.isEmpty) {
                        return Center(
                          child: Text(
                            'Нет свободных мест на ${widget.selectedDate.dateFormat()}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: ThemeColors.statusRed,
                            ),
                          ),
                        );
                      }
                      return ValueListenableBuilder(
                        valueListenable: selectedTimeNotifier,
                        builder: (context, time, child) => Wrap(
                          spacing: 8.r,
                          runSpacing: 8.r,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: slots
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
                      );
                    } else if (state is SlotsError) {
                      return Center(
                        child: Text(
                          'Что-то пошло не так, попробуйте еще раз.',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: ThemeColors.baseBlack),
                        ),
                      );
                    } else if (state is SlotsLoading) {
                      return Center(child: CircularProgressIndicator.adaptive());
                    } else {
                      return SizedBox();
                    }
                  },
                ),
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
          );
        },
      ),
    );
  }
}
