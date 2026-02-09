import 'package:flutter/material.dart';
import 'package:health_club/feature/main/calendar/widgets/calendar_booking_bottom_sheet.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../design_system/design_system.dart';
import '../../../../domain/core/core.dart';

class SignUpForPartnerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isBookingsSpend;

  const SignUpForPartnerWidget({super.key, required this.selectedDate, required this.isBookingsSpend});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserMeCubit, UserMeState>(
      builder: (context, userMeState) {
        if (userMeState is! UserMeLoaded) return SizedBox();
        final user = userMeState.userMe;
        final extensionIsActive = (user.plus ?? 0) > 0;
        return BlocBuilder<PartnersCubit, PartnersState>(
          builder: (context, partnersState) {
            if (partnersState is! PartnersLoaded) return SizedBox();
            final partners = partnersState.points;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                BlocListener<BookSlotCubit, BookSlotState>(
                  listener: (context, state) async {
                    if (state is BookSlotLoaded) {
                      final calendarCubit = context.read<CalendarCubit>();
                      await CustomSneakBar.show(
                        context: context,
                        status: SneakBarStatus.success,
                        title: 'Бронирования успешно прошло',
                      );
                      calendarCubit.fetchCalendar();
                    } else if (state is BookSlotError) {
                      CustomSneakBar.show(context: context, status: SneakBarStatus.error, title: state.message ?? '');
                    }
                  },
                  child: ButtonWithScale(
                    // isLoading: state is SlotsLoading,
                    onPressed: () async {
                      final boolSlotsCubit = context.read<BookSlotCubit>();
                      final subscriptionIsActive = userMeState.userMe.subscription != null;
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return BottomSheetWidget(
                            widgets: [
                              CalendarBookingBottomSheet(
                                bookSlotCubit: boolSlotsCubit,
                                partners: partners,
                                selectedDate: selectedDate,
                                extensionIsActive: extensionIsActive,
                                subscriptionIsActive: subscriptionIsActive,
                                isBookingsSpend: isBookingsSpend,
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: 'Забронировать',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
