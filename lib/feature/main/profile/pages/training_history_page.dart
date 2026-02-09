import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/feature/main/profile/widgets/training_item.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class TrainingHistoryPage extends StatefulWidget {
  const TrainingHistoryPage({super.key});

  @override
  State<TrainingHistoryPage> createState() => _TrainingHistoryPageState();
}

class _TrainingHistoryPageState extends State<TrainingHistoryPage> with TickerProviderStateMixin {
  late TabController tabController;
  final ValueNotifier<bool> selectedUpcomingNotifier = ValueNotifier(false);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История тренировок',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<TrainingHistoryCubit, TrainingHistoryState>(
        builder: (context, state) {
          if (state is TrainingHistoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is TrainingHistoryError) {
            return Center(child: Text(state.message ?? ''));
          } else if (state is TrainingHistoryLoaded) {
            final trainingHistories = state.trainingHistory;
            final now = DateTime.now();
            final upcoming = trainingHistories.where((element) => element.date?.isAfter(now) == true).toList();
            final past = trainingHistories.where((element) => element.date?.isBefore(now) == true).toList();

            return SingleChildScrollView(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    child: TabBar(
                      onTap: (value) {
                        selectedUpcomingNotifier.value = value != 0;
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
                  // ListView.separated(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) => TrainingItem(training: trainingHistories[index]),
                  //   separatorBuilder: (context, index) => 16.height,
                  //   itemCount: trainingHistories.length,
                  // ),

                  ValueListenableBuilder(
                    valueListenable: selectedUpcomingNotifier,
                    builder: (context, selectedUpcoming, child) {
                      if (selectedUpcoming) {
                        if (upcoming.isEmpty) return EmptyWidget();
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TrainingItem(training: upcoming[index]),
                          separatorBuilder: (context, index) => 16.height,
                          itemCount: upcoming.length,
                        );
                      } else {
                        if (past.isEmpty) return EmptyWidget();
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TrainingItem(training: past[index]),
                          separatorBuilder: (context, index) => 16.height,
                          itemCount: past.length,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
