import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/feature/main/calendar/widgets/calendar_widget.dart';
import 'package:health_club/feature/main/calendar/widgets/schedule_item.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  late TabController tabController;
  final ValueNotifier<bool> selectedFirst = ValueNotifier(true);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
              CalendarWidget(),
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
                    Tab(text: 'Предстоящие'),
                    Tab(text: 'Прошлые'),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 0.76.sw,
              //       height: 52.h,
              //       child: Material(
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              //         child: TabBar(
              //           onTap: (value) {
              //             selectedFirst.value = value == 0;
              //           },
              //           controller: tabController,
              //           indicatorSize: TabBarIndicatorSize.tab,
              //           padding: EdgeInsets.zero,
              //           labelPadding: EdgeInsets.zero,
              //           indicatorPadding: EdgeInsets.zero,
              //           indicatorColor: Colors.white,
              //           labelColor: Colors.white,
              //           unselectedLabelColor: Colors.black,
              //           dividerColor: Colors.transparent,
              //           overlayColor: WidgetStatePropertyAll(Colors.transparent),
              //           labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
              //           unselectedLabelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              //           indicator: BoxDecoration(
              //             color: Color(0xff2d9994),
              //             borderRadius: BorderRadius.all(Radius.circular(6)),
              //           ),
              //           tabs: [
              //             Tab(text: 'Предстоящие'),
              //             Tab(text: 'Прошлые'),
              //           ],
              //         ),
              //       ),
              //     ),
              //     // Container(
              //     //   height: 52.h,
              //     //   width: 52.r,
              //     //   decoration: BoxDecoration(
              //     //     borderRadius: BorderRadius.circular(10.r),
              //     //     color: Colors.white,
              //     //     boxShadow: [
              //     //       BoxShadow(
              //     //         color: ThemeColors.primaryColor.withValues(alpha: 0.06),
              //     //         offset: const Offset(0, 8),
              //     //         blurRadius: 24,
              //     //         spreadRadius: 0,
              //     //       ),
              //     //     ],
              //     //   ),
              //     //   child: Icon(Icons.settings),
              //     // ),
              //   ],
              // ),
              20.height,
              ValueListenableBuilder(
                valueListenable: selectedFirst,
                builder: (context, isFirst, child) {
                  if (state is CalendarLoaded) {
                    final past = state.calendarResponse.past;
                    final upcoming = state.calendarResponse.upcoming;
                    if (isFirst) {
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
