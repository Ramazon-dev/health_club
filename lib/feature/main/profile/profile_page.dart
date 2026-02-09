import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/design_system/widgets/network_image.dart';
import 'package:health_club/feature/main/profile/widgets/daily_metrics_widget.dart';
import 'package:health_club/feature/main/profile/widgets/extension_widget.dart';
import 'package:health_club/feature/main/profile/widgets/profile_processing_widget.dart';
import 'package:health_club/feature/main/profile/widgets/subscription_widget.dart';
import 'package:health_club/feature/main/profile/widgets/target_widget.dart';
import 'package:health_club/router/app_router.gr.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
                color: Color(0xff2d9994),
              ),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: CircleAvatar(radius: 50.r, backgroundColor: Colors.cyanAccent),
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message ?? ''));
                  } else if (state is ProfileLoaded) {
                    final profile = state.profile;
                    final avatar = profile.avatar;
                    final subscription = state.profile.subscription;
                    final isFrozen = subscription?.isFrozen ?? false;
                    final isActive = subscription?.endedAt?.isAfter(DateTime.now()) == true;
                    return Column(
                      children: [
                        SizedBox(height: 40.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 56.r),
                            // InkWell(
                            //   onTap: () {
                            //     context.router.push(NotificationsRoute());
                            //   },
                            //   child: Container(
                            //     height: 56.h,
                            //     width: 56.r,
                            //     padding: EdgeInsets.all(16.r),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(16.r),
                            //       color: Colors.white24,
                            //     ),
                            //     child: SvgPicture.asset(
                            //       AppAssets.notification,
                            //       colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            //     ),
                            //   ),
                            // ),
                            // 'https://static.vecteezy.com/system/resources/thumbnails/065/615/845/small/portrait-of-a-woman-with-long-hair-against-a-vibrant-urban-background-at-night-photo.jpeg',
                            if (avatar != null && avatar.isNotEmpty)
                              AppNetworkImage(
                                imageUrl: avatar,
                                height: 100.r,
                                width: 100.r,
                                borderRadius: BorderRadius.circular(100),
                              )
                            else
                              CircleAvatar(
                                radius: 50.r,
                                backgroundColor: Colors.cyanAccent,
                                child: Icon(Icons.person, color: ThemeColors.baseBlack, size: 40.r),
                              ),
                            InkWell(
                              onTap: () {
                                context.router.push(SettingsRoute());
                              },
                              child: Container(
                                height: 56.h,
                                width: 56.r,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white24,
                                ),
                                child: Icon(Icons.menu, color: Colors.white),
                                // child: SvgPicture.asset(
                                //   AppAssets.settings,
                                //   colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          '${profile.name} ${profile.surname}',
                          style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8.h),
                        SubscriptionWidget(
                          isFrozen: isFrozen,
                          isActive: isActive,
                          subscription: subscription,
                          lastname: profile.surname ?? '',
                          number: profile.phone ?? '',
                        ),
                        ExtensionWidget(),
                        SizedBox(height: 20.h),
                        TargetWidget(profile: profile),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.r),
              child: Column(
                children: [
                  // 10.height,
                  // ButtonWithScale(
                  //   // isLoading: isLoading,
                  //   onPressed: () async {
                  //     // context.router.push(DailyReportRoute());
                  //     context.router.push(DailyReportResultRoute());
                  //   },
                  //   text: 'Дневной отчёт',
                  // ),
                  // 10.height,
                  // Container(
                  //   padding: EdgeInsets.all(15.r),
                  //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0x33ffffff)),
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       if (true) ...[
                  //         Align(
                  //           alignment: Alignment.center,
                  //           child: SvgPicture.asset(
                  //             AppAssets.stars,
                  //             colorFilter: ColorFilter.mode(ThemeColors.statusYellow, BlendMode.srcIn),
                  //             height: 50.r,
                  //             width: 50.r,
                  //           ),
                  //         ),
                  //         10.height,
                  //         Center(
                  //           child: Text(
                  //             'Начните свой фитнес-путь сегодня!',
                  //             style: TextStyle(
                  //               color: ThemeColors.baseBlack,
                  //               fontSize: 16.sp,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ),
                  //         10.height,
                  //         Text(
                  //           'Первый шаг к лучшей версии себя - всего в одном клике.',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 14.sp,
                  //             color: ThemeColors.baseBlack,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         10.height,
                  //         ButtonWithScale(
                  //           color: ThemeColors.statusColor,
                  //           text: 'Записаться на пробную тренировку',
                  //           textStyle: TextStyle(
                  //             color: ThemeColors.baseBlack,
                  //             fontSize: 14.sp,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //           onPressed: () {},
                  //         ),
                  //       ],
                  //     ],
                  //   ),
                  // ),
                  10.height,
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return Container(
                        // height: 230.h,
                        width: 1.sw,
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Ваши тренировки за 30 дней',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                context.router.push(ProcessInMonthRoute());
                              },
                              child: (state is ProfileLoaded)
                                  ? ProfileProcessingWidget(process: state.profile.monthProgress?.percent ?? 0)
                                  : ProfileProcessingWidget(process: 0),
                            ),
                            // ProgressGauge(progress: 0.8),
                            const SizedBox(height: 12),
                            if (state is ProfileLoaded)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${state.profile.monthProgress?.current}/${state.profile.monthProgress?.target} ',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  DailyMetricsWidget(),
                  //
                  // /// todo
                  // ///
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(context: context);
                  //
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Pure"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     showTimeRangePicker(
                  //       context: context,
                  //       start: const TimeOfDay(hour: 22, minute: 9),
                  //       onStartChange: (start) {
                  //         if (kDebugMode) {
                  //           print("start time $start");
                  //         }
                  //       },
                  //       onEndChange: (end) {
                  //         if (kDebugMode) {
                  //           print("end time $end");
                  //         }
                  //       },
                  //       interval: const Duration(hours: 1),
                  //       minDuration: const Duration(hours: 1),
                  //       use24HourFormat: false,
                  //       padding: 30,
                  //       strokeWidth: 20,
                  //       handlerRadius: 14,
                  //       strokeColor: Colors.orange,
                  //       handlerColor: Colors.orange[700],
                  //       selectedColor: Colors.amber,
                  //       backgroundColor: Colors.black.withOpacity(0.3),
                  //       ticks: 12,
                  //       ticksColor: Colors.white,
                  //       snap: true,
                  //       labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"].asMap().entries.map((
                  //         e,
                  //       ) {
                  //         return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                  //       }).toList(),
                  //       labelOffset: -30,
                  //       labelStyle: const TextStyle(fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),
                  //       timeTextStyle: TextStyle(
                  //         color: Colors.orange[700],
                  //         fontSize: 24,
                  //         fontStyle: FontStyle.italic,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //       activeTimeTextStyle: const TextStyle(
                  //         color: Colors.orange,
                  //         fontSize: 26,
                  //         fontStyle: FontStyle.italic,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     );
                  //   },
                  //   child: const Text("Interval"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       start: const TimeOfDay(hour: 9, minute: 0),
                  //       end: const TimeOfDay(hour: 12, minute: 0),
                  //       disabledTime: TimeRange(
                  //         startTime: const TimeOfDay(hour: 22, minute: 0),
                  //         endTime: const TimeOfDay(hour: 5, minute: 0),
                  //       ),
                  //       disabledColor: Colors.red.withOpacity(0.5),
                  //       strokeWidth: 4,
                  //       ticks: 24,
                  //       ticksOffset: -7,
                  //       ticksLength: 15,
                  //       ticksColor: Colors.grey,
                  //       labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"].asMap().entries.map((
                  //         e,
                  //       ) {
                  //         return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                  //       }).toList(),
                  //       labelOffset: 35,
                  //       rotateLabels: false,
                  //       padding: 60,
                  //     );
                  //
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Disabled Times"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       paintingStyle: PaintingStyle.fill,
                  //       backgroundColor: Colors.grey.withOpacity(0.2),
                  //       labels: [
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 7, minute: 0), text: "Start Work"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home"),
                  //       ],
                  //       start: const TimeOfDay(hour: 10, minute: 0),
                  //       end: const TimeOfDay(hour: 13, minute: 0),
                  //       ticks: 8,
                  //       strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  //       ticksColor: Theme.of(context).primaryColor,
                  //       labelOffset: 15,
                  //       padding: 60,
                  //       disabledTime: TimeRange(
                  //         startTime: const TimeOfDay(hour: 18, minute: 0),
                  //         endTime: const TimeOfDay(hour: 7, minute: 0),
                  //       ),
                  //       disabledColor: Colors.red.withOpacity(0.5),
                  //     );
                  //
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Filled Style"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       strokeColor: Colors.teal,
                  //       handlerColor: Colors.teal[200],
                  //       selectedColor: Colors.tealAccent,
                  //       strokeWidth: 16,
                  //       handlerRadius: 18,
                  //       backgroundWidget: Image.asset("assets/images/day-night.png", height: 200, width: 200),
                  //       labels: [
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 6, minute: 0), text: "Get up"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 9, minute: 0), text: "Coffee time"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 15, minute: 0), text: "Afternoon"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 18, minute: 0), text: "Time for a beer"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 22, minute: 0), text: "Go to Sleep"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 2, minute: 0), text: "Go for a pee"),
                  //         ClockLabel.fromTime(time: const TimeOfDay(hour: 12, minute: 0), text: "Lunchtime!"),
                  //       ],
                  //       ticksColor: Colors.black,
                  //       labelOffset: 40,
                  //       padding: 55,
                  //       labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
                  //     );
                  //
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Background Widget"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       strokeWidth: 4,
                  //       ticks: 12,
                  //       ticksOffset: 2,
                  //       ticksLength: 8,
                  //       handlerRadius: 8,
                  //       ticksColor: Colors.grey,
                  //       rotateLabels: false,
                  //       labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"].asMap().entries.map((e) {
                  //         return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                  //       }).toList(),
                  //       labelOffset: 30,
                  //       padding: 55,
                  //       interval: Duration(minutes: 30),
                  //       minDuration: Duration(minutes: 30),
                  //       labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
                  //       start: const TimeOfDay(hour: 22, minute: 0),
                  //       end: const TimeOfDay(hour: 6, minute: 0),
                  //       // disabledTime: TimeRange(
                  //       //   startTime: const TimeOfDay(hour: 6, minute: 0),
                  //       //   endTime: const TimeOfDay(hour: 10, minute: 0),
                  //       // ),
                  //       clockRotation: 180.0,
                  //     );
                  //     if (result == null) return;
                  //     final now = DateTime.now();
                  //     print("result $result startTime ${result.startTime} endTime ${result.endTime}");
                  //     final start = DateTime(now.year, now.month, now.day, result.startTime.hour, result.startTime.minute);
                  //     final end = DateTime(now.year, now.month, now.day, result.endTime.hour, result.endTime.minute);
                  //     int duration = 0;
                  //     if (result.startTime.hour > 12 && result.endTime.hour < 24) {
                  //       // result.startTime.hour < 24 ||
                  //       duration = start.difference(end).inHours.abs();
                  //     } else if (result.startTime.hour < 12) {
                  //       duration = start.difference(end).inHours.abs();
                  //     } else {
                  //       duration = 24 - start.difference(end).inHours.abs();
                  //     }
                  //     print('object duration $duration difference ${start.difference(end).inHours.abs()} duration is ${24 - start.difference(end).inHours.abs()}');
                  //   },
                  //   child: const Text("Rotated Clock"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       rotateLabels: false,
                  //       ticks: 12,
                  //       ticksColor: Colors.grey,
                  //       ticksOffset: -12,
                  //       labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"].asMap().entries.map((e) {
                  //         return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                  //       }).toList(),
                  //       labelOffset: -30,
                  //       padding: 55,
                  //       start: const TimeOfDay(hour: 12, minute: 0),
                  //       end: const TimeOfDay(hour: 18, minute: 0),
                  //       disabledTime: TimeRange(
                  //         startTime: const TimeOfDay(hour: 4, minute: 0),
                  //         endTime: const TimeOfDay(hour: 10, minute: 0),
                  //       ),
                  //       maxDuration: const Duration(hours: 6),
                  //     );
                  //
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Max duration"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showTimeRangePicker(
                  //       context: context,
                  //       rotateLabels: false,
                  //       ticks: 12,
                  //       ticksColor: Colors.grey,
                  //       ticksOffset: -12,
                  //       labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"].asMap().entries.map((e) {
                  //         return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                  //       }).toList(),
                  //       labelOffset: -30,
                  //       padding: 55,
                  //       start: const TimeOfDay(hour: 12, minute: 0),
                  //       end: const TimeOfDay(hour: 18, minute: 0),
                  //       disabledTime: TimeRange(
                  //         startTime: const TimeOfDay(hour: 4, minute: 0),
                  //         endTime: const TimeOfDay(hour: 10, minute: 0),
                  //       ),
                  //       minDuration: const Duration(hours: 3),
                  //     );
                  //     if (kDebugMode) {
                  //       print("result $result");
                  //     }
                  //   },
                  //   child: const Text("Min duration"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         TimeOfDay startTime = TimeOfDay.now();
                  //         TimeOfDay endTime = TimeOfDay.now();
                  //         return AlertDialog(
                  //           contentPadding: EdgeInsets.zero,
                  //           title: const Text("Choose a nice timeframe"),
                  //           content: SizedBox(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: 450,
                  //             child: TimeRangePicker(
                  //               hideButtons: true,
                  //               onStartChange: (start) {
                  //                 setState(() {
                  //                   startTime = start;
                  //                 });
                  //               },
                  //               onEndChange: (end) {
                  //                 setState(() {
                  //                   endTime = end;
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               child: const Text('My custom cancel'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //             TextButton(
                  //               child: const Text('My custom ok'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop(TimeRange(startTime: startTime, endTime: endTime));
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //
                  //     if (kDebugMode) {
                  //       print(result.toString());
                  //     }
                  //   },
                  //   child: const Text("Custom Dialog"),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     TimeRange? result = await showCupertinoDialog(
                  //       barrierDismissible: true,
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         TimeOfDay startTime = TimeOfDay.now();
                  //         TimeOfDay endTime = TimeOfDay.now();
                  //         return CupertinoAlertDialog(
                  //           content: SizedBox(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: 340,
                  //             child: Column(
                  //               children: [
                  //                 TimeRangePicker(
                  //                   padding: 22,
                  //                   hideButtons: true,
                  //                   handlerRadius: 8,
                  //                   strokeWidth: 4,
                  //                   ticks: 12,
                  //                   activeTimeTextStyle: const TextStyle(
                  //                     fontWeight: FontWeight.normal,
                  //                     fontSize: 22,
                  //                     color: Colors.white,
                  //                   ),
                  //                   timeTextStyle: const TextStyle(
                  //                     fontWeight: FontWeight.normal,
                  //                     fontSize: 22,
                  //                     color: Colors.white70,
                  //                   ),
                  //                   onStartChange: (start) {
                  //                     setState(() {
                  //                       startTime = start;
                  //                     });
                  //                   },
                  //                   onEndChange: (end) {
                  //                     setState(() {
                  //                       endTime = end;
                  //                     });
                  //                   },
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           actions: <Widget>[
                  //             CupertinoDialogAction(
                  //               isDestructiveAction: true,
                  //               child: const Text('Cancel'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //             CupertinoDialogAction(
                  //               child: const Text('Ok'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop(TimeRange(startTime: startTime, endTime: endTime));
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //     if (kDebugMode) {
                  //       print(result.toString());
                  //     }
                  //   },
                  //   child: const Text("Cupertino style"),
                  // ),
                ],
              ),
            ),
            SizedBox(height: kBottomNavigationBarHeight * 3),
          ],
        ),
      ),
    );
  }
}
