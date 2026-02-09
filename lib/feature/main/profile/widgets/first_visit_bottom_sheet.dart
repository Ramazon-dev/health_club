import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/network/model/clubs_response.dart';

class FirstVisitBottomSheet extends StatefulWidget {
  final String lastname;

  const FirstVisitBottomSheet({super.key, required this.lastname});

  @override
  State<FirstVisitBottomSheet> createState() => _FirstVisitBottomSheetState();
}

class _FirstVisitBottomSheetState extends State<FirstVisitBottomSheet> {
  final TextEditingController dateController = TextEditingController();
  final ValueNotifier<ClubResponse?> selectedClubNotifier = ValueNotifier(null);
  final ValueNotifier<String?> selectedTime = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Запись на тренировку',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            10.height,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Выберите клуб, дату и время для вашей тренировки.',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
            20.height,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Клуб',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
              ),
            ),
            5.height,
            BlocBuilder<WizardClubsCubit, WizardClubsState>(
              builder: (context, state) {
                if (state is! WizardClubsLoaded) return SizedBox();
                return ValueListenableBuilder(
                  valueListenable: selectedClubNotifier,
                  builder: (context, selectedClub, child) => DropdownButtonFormField2(
                    value: selectedClub,
                    enableFeedback: true,
                    isExpanded: true,
                    onChanged: (value) {
                      selectedClubNotifier.value = value;
                      final date = dateController.text.parseFromDate();
                      if (date != null && value != null) {
                        selectedTime.value = null;
                        context.read<WizardSlotsCubit>().fetchSlots(value.id ?? 0, date.dateForRequest());
                        // context.read<SlotsCubit>().getSlots(value.id ?? 0, date.weekday);
                      }
                    },
                    selectedItemBuilder: (context) => state.wizardClubs.map((e) {
                      return Text(
                        e.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList(),

                    items: state.wizardClubs
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title ?? '',
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
                );
              },
            ),
            10.height,
            Text(
              'Дата',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
            ),
            5.height,
            GestureDetector(
              onTap: () async {
                final wizardSlotsCubit = context.read<WizardSlotsCubit>();
                final now = DateTime.now();
                final date = await showDatePicker(
                  context: context,
                  firstDate: now,
                  lastDate: now.add(Duration(days: 30)),
                  // lastDate: now.add(Duration(days: 7 - now.weekday)),
                );
                final club = selectedClubNotifier.value;
                if (date == null || club == null) return;
                selectedTime.value = null;
                dateController.text = date.dateForRequest();
                wizardSlotsCubit.fetchSlots(club.id ?? 0, date.dateForRequest());
                //       selectedTime.value = null;
              },
              child: TextFormField(
                enabled: false,
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Выберите дату',
                  suffixIcon: Icon(Icons.calendar_today_outlined, color: ThemeColors.base300, size: 22.r),
                ),
              ),
            ),
            10.height,
            Text(
              'Время',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
            ),
            5.height,
            BlocConsumer<WizardSlotsCubit, WizardSlotsState>(
              listener: (context, state) {
                if (state is WizardSlotsError) {
                  context.showSnackBar(state.message ?? '');
                }
              },
              builder: (context, state) {
                if (state is WizardSlotsLoaded) {
                  return ValueListenableBuilder(
                    valueListenable: selectedTime,
                    builder: (context, time, child) => Wrap(
                      spacing: 8.r,
                      runSpacing: 8.r,
                      children: state.slots
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                selectedTime.value = e;
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: time == e ? ThemeColors.primaryColor : ThemeColors.base100,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: time == e ? Colors.white : ThemeColors.baseBlack,
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
                  onPressed: () {},
                  text: 'Отмена',
                  textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                ),
                BlocConsumer<RegisterFirstVisitCubit, RegisterFirstVisitState>(
                  listener: (context, state) async {
                    final router = context.router;
                    if (state is RegisterFirstVisitLoaded) {
                      router.maybePop();
                      await CustomSneakBar.show(
                        context: context,
                        status: SneakBarStatus.success,
                        title: 'Визит забронирован, ожидайте подтверждения',
                      );
                    } else if (state is RegisterFirstVisitError) {
                      router.maybePop();
                      await CustomSneakBar.show(
                        context: context,
                        status: SneakBarStatus.error,
                        title: state.message ?? 'Что-то пошло не так',
                      );
                    }
                  },
                  builder: (context, state) => ButtonWithScale(
                    isLoading: state is RegisterFirstVisitLoading,
                    width: 0.45.sw,
                    height: 60.h,
                    onPressed: () async {
                      if (selectedClubNotifier.value == null) {
                        context.showSnackBar('Выберите клуб');
                      } else if (dateController.text.isEmpty) {
                        context.showSnackBar('Выберите дату');
                      } else if (selectedTime.value == null) {
                        context.showSnackBar('Выберите время');
                      } else {
                        context.read<RegisterFirstVisitCubit>().registerFirstVisit(
                          surname: widget.lastname,
                          placeId: selectedClubNotifier.value?.id ?? 10,
                          date: dateController.text,
                          time: selectedTime.value!,
                        );
                      }
                    },
                    text: 'Сохранить',
                  ),
                ),
              ],
            ),
            (kBottomNavigationBarHeight).height,
          ],
        ),
      ),
    );
  }
}
