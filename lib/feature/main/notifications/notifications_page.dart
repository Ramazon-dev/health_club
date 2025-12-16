import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/feature/main/notifications/widgets/notification_item.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ThemeColors.base100,
      //   surfaceTintColor: ThemeColors.base100,
      //   foregroundColor: ThemeColors.base100,
      //   centerTitle: true,
      //   title: Tooltip(
      //     message: 'sasasasas',
      //     child: Text(
      //       'Уведомления',
      //       style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
      //     ),
      //   ),
      // ),
      appBar: AppbarWidget(
        backgroundColor: ThemeColors.base100,
        iconColor: Colors.white,
        buttonColor: Colors.white,
        showBackButton: true,
        title: Tooltip(
          message: 'sasasasas',
          child: Text(
            'Уведомления',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const Icon(Icons.done_all, color: Colors.black),
            onTap: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: TabBar(
                dividerHeight: 0,
                controller: tabController,
                labelColor: ThemeColors.white50,
                labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ThemeColors.primaryColor),
                tabs: [
                  Tab(height: 52, text: 'Уведомления'),
                  Tab(height: 52, text: 'Новости'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.router.push(NotificationsDetailRoute());
                    },
                    child: NotificationItem(index: index),
                  ),
                  separatorBuilder: (context, index) => 10.height,
                  itemCount: 2,
                ),

                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.router.push(NotificationsDetailRoute());
                    },
                    child: NotificationItem(index: index),
                  ),
                  separatorBuilder: (context, index) => 10.height,
                  itemCount: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
