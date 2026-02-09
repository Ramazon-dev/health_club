import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/main/profile/widgets/first_visit_bottom_sheet.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/network/model/profile_response.dart';
import '../../../../di/init.dart';
import 'package:collection/collection.dart';

class SubscriptionWidget extends StatefulWidget {
  final bool isActive;
  final bool isFrozen;
  final Subscription? subscription;
  final String lastname;
  final String number;

  const SubscriptionWidget({
    super.key,
    required this.isActive,
    this.subscription,
    required this.lastname,
    required this.isFrozen, required this.number,
  });

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0x33ffffff)),
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.subscription != null) ...[
            Text(
              'Абонемент: ${widget.subscription?.name ?? ''}',
              style: TextStyle(color: ThemeColors.white50, fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.subscription?.startedAt != null) ...[
                      10.height,
                      Text(
                        "Начало: ${widget.subscription?.startedAt?.dateFormat() ?? ''}",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                      ),
                    ],
                    10.height,
                    Text(
                      'Осталось дней: ${widget.subscription?.daysLeft ?? 0}',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: widget.isActive ? ThemeColors.statusGreen : ThemeColors.red200,
                    // color: Color(0x3311d564),
                  ),
                  child: Row(
                    children: [
                      if (widget.isActive && !widget.isFrozen) ...[
                        Icon(Icons.done, color: Colors.white, size: 18.r),
                        SizedBox(width: 5.r),
                      ],
                      Text(
                        widget.isFrozen
                            ? 'Заморожен'
                            : widget.isActive
                            ? 'Активный'
                            : 'Не активный',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            BlocBuilder<FirstTrainingsCubit, FirstTrainingsState>(
              builder: (context, state) {
                if (state is! FirstTrainingsLoaded) return Column(children: invitationWidget());
                final trainings = state.trainings;
                final training = trainings.firstWhereOrNull((element) => element.clientPhone ==  widget.number);
                return Column(
                  children: [
                    if (training != null) ...[
                      Text(
                        'Вы записаны!',
                        style: TextStyle(color: ThemeColors.white50, fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      5.height,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.dumbbellDark,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            height: 20.r,
                            width: 20.r,
                          ),
                          5.width,
                          Text(
                            training.placeTitle ?? '',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.dumbbellDark,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            height: 20.r,
                            width: 20.r,
                          ),
                          5.width,
                          Expanded(
                            child: Text(
                              training.placeAddress ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 20.r),
                          5.width,
                          Text(
                            training.date ?? '',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: Colors.white, size: 20.r),
                          5.width,
                          Text(
                            training.time ?? "",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ] else
                      ...invitationWidget(),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> invitationWidget() {
    return [
      Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppAssets.stars,
          colorFilter: ColorFilter.mode(ThemeColors.statusYellow, BlendMode.srcIn),
          height: 50.r,
          width: 50.r,
        ),
      ),
      10.height,
      Center(
        child: Text(
          'Начните свой фитнес-путь сегодня!',
          style: TextStyle(color: ThemeColors.white50, fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
      10.height,
      Text(
        'Первый шаг к лучшей версии себя - всего в одном клике.',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: ThemeColors.white50),
        textAlign: TextAlign.center,
      ),
      10.height,
      ButtonWithScale(
        color: Color(0xffff2222),
        // color: Color(0x1AFF2222),
        text: 'Записаться на пробную тренировку',
        textStyle: TextStyle(color: ThemeColors.white50, fontSize: 14.sp, fontWeight: FontWeight.w500),
        onPressed: () {
          final wizardSlotsCubit = context.read<WizardSlotsCubit>();
          final wizardClubsCubit = context.read<WizardClubsCubit>();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                // height: 0.9.sh,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: wizardSlotsCubit),
                    BlocProvider.value(value: wizardClubsCubit),
                    BlocProvider(create: (context) => getIt<RegisterFirstVisitCubit>()),
                  ],
                  child: FirstVisitBottomSheet(lastname: widget.lastname),
                ),
              );
            },
          );
        },
      ),
    ];
  }
}
