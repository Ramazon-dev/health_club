import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/main/calendar/widgets/calendar_widget.dart';
import 'package:health_club/feature/main/calendar/widgets/schedule_item.dart';
import 'package:health_club/feature/main/calendar/widgets/sign_up_for_partner_widget.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  late TabController tabController;
  final ValueNotifier<bool> selectedFirst = ValueNotifier(false);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.base100,
        surfaceTintColor: ThemeColors.base100,
        foregroundColor: ThemeColors.base100,
        centerTitle: true,
        title: Tooltip(
          message: 'sasasasas',
          child: Text(
            'Календарь',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) => SingleChildScrollView(
          padding: EdgeInsets.all(15.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is CalendarLoaded)
                CalendarWidget(past: state.past, upcoming: state.upcoming)
              else
                CalendarWidget(past: [], upcoming: []),
              Builder(
                builder: (context) {
                  if (state is CalendarLoaded) {
                    final date = state.selectedDate ?? DateTime.now();
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    final DateTime startOfWeek = today.subtract(Duration(days: now.weekday - 1));
                    final DateTime endOfWeek = today.add(Duration(days: 7 - now.weekday + 1));
                    final inThisWeek = (date.isAfter(today) && (date.isBefore(endOfWeek)));
                    final allEvents = [...state.past, ...state.upcoming];
                    final eventsInThisWeek = allEvents
                        .where(
                          (element) =>
                              (element.date?.isAfter(startOfWeek) == true) &&
                              (element.date?.isBefore(endOfWeek) == true),
                        )
                        .toList();
                    print(
                      'object calendar start of week $now and start of week $startOfWeek end of week $endOfWeek in this week $inThisWeek',
                    );
                    if (inThisWeek) {
                      return SignUpForPartnerWidget(selectedDate: date, isBookingsSpend: eventsInThisWeek.length < 2);
                    }
                  }
                  return SizedBox();
                },
              ),

              20.height,
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                child: TabBar(
                  onTap: (value) {
                    selectedFirst.value = value == 0;
                  },
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                  unselectedLabelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  indicator: BoxDecoration(
                    color: Color(0xff2d9994),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  tabs: [
                    Tab(text: 'Прошлые'),
                    Tab(text: 'Предстоящие'),
                  ],
                ),
              ),
              20.height,
              ValueListenableBuilder(
                valueListenable: selectedFirst,
                builder: (context, isFirst, child) {
                  if (state is CalendarLoaded) {
                    final selectedDate = state.selectedDate;
                    final past = selectedDate != null
                        ? state.past.where((element) {
                            final date = element.date;
                            if (date != null) return (selectedDate.isSameDay(date));
                            return false;
                          }).toList()
                        : state.past;
                    final upcoming = selectedDate != null
                        ? state.upcoming.where((element) {
                            final date = element.date;
                            if (date != null) return (selectedDate.isSameDay(date));
                            return false;
                          }).toList()
                        : state.upcoming;

                    if (!isFirst) {
                      if (upcoming.isEmpty) return EmptyWidget();
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ScheduleItem(past: upcoming[index]),
                        separatorBuilder: (context, index) => 15.height,
                        itemCount: upcoming.length,
                      );
                    } else {
                      if (past.isEmpty) return EmptyWidget();
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ScheduleItem(past: past[index]),
                        separatorBuilder: (context, index) => 15.height,
                        itemCount: past.length,
                      );
                    }
                  } else if (state is CalendarLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else {
                    return SizedBox();
                  }
                },
              ),
              // Expanded(
              //   child: TabBarView(
              //     controller: tabController,
              //     children: [
              //       SizedBox(
              //         child: ListView.separated(
              //           physics: NeverScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) => ScheduleItem(),
              //           separatorBuilder: (context, index) => 15.height,
              //           itemCount: 3,
              //         ),
              //       ),
              //       SizedBox(
              //         child: ListView.separated(
              //           physics: NeverScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) => ScheduleItem(isLast: true),
              //           separatorBuilder: (context, index) => 15.height,
              //           itemCount: 3,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ValueListenableBuilder(
              //   valueListenable: selectedFirst,
              //   builder: (context, first, child) => first
              //       ? ListView.separated(
              //           physics: NeverScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) => ScheduleItem(),
              //           separatorBuilder: (context, index) => 15.height,
              //           itemCount: 3,
              //         )
              //       : ListView.separated(
              //           physics: NeverScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) => ScheduleItem(isLast: true),
              //           separatorBuilder: (context, index) => 15.height,
              //           itemCount: 3,
              //         ),
              // ),
              120.height,
            ],
          ),
        ),
      ),
    );
  }
}
