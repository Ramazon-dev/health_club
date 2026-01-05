import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_club/design_system/extensions/dialog_ext.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../app_bloc/app_bloc.dart';
import '../../design_system/design_system.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TabsRouter? tabsRouter;

  final List<MapEntry<String?, String?>> bottomNavBarItems = [
    MapEntry(AppAssets.calendar, AppAssets.calendarSelected),
    MapEntry(AppAssets.search, AppAssets.searchSelected),
    const MapEntry(null, null),
    MapEntry(AppAssets.champion, AppAssets.championSelected),
    MapEntry(AppAssets.profile, AppAssets.profileSelected),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (tabsRouter?.activeIndex != 0) {
          tabsRouter?.setActiveIndex(0);

          return;
        }
        SystemNavigator.pop();
      },
      child: BlocListener<CheckQrCubit, CheckQrState>(
        listener: (context, state) async {
          if (state is CheckQrLoaded) {
            context.showDynamicDialog(
              widgets: [
                Text(
                  'Успешно прошел',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: ThemeColors.baseBlack),
                ),
                10.height,
                Text(
                  state.success,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                ),
                20.height,
                Text(
                  DateTime.now().bookingDate(),
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                ),
                20.height,
              ],
            );
            // await CustomSneakBar.show(context: context, status: SneakBarStatus.success, title: state.success);
          } else if (state is CheckQrError) {
            await CustomSneakBar.show(
              context: context,
              status: SneakBarStatus.error,
              title: state.message ?? 'Что то пошло не так',
            );
          }
        },
        child: AutoTabsScaffold(
          extendBody: true,
          homeIndex: 4,
          routes: [CalendarRoute(), MapRoute(), CalendarRoute(), AwardsRoute(), ProfileRoute()],
          backgroundColor: ThemeColors.base100,
          // body: Column(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButtonBuilder: (context, tabsRouter) {
            final isHide = tabsRouter.topRoute.meta['hideNavBar'] == true;
            return Visibility(
              visible: !isHide,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: ThemeColors.primaryColor,
                  foregroundColor: ThemeColors.primaryColor,
                  surfaceTintColor: ThemeColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
                  padding: EdgeInsets.zero,
                  fixedSize: 1.sw > 600 ? Size(80.r, 80.r) : Size(60.r, 60.r),
                ),
                onPressed: () {
                  context.router.push(QrCodeScannerRoute());
                },
                child: SvgPicture.asset(AppAssets.scan),
              ),
            );
          },
          bottomNavigationBuilder: (context, tabsRouter) {
            final isHide = tabsRouter.topRoute.meta['hideNavBar'] == true;
            this.tabsRouter = tabsRouter;
            return Visibility(
              visible: !isHide,
              child: BottomAppBar(
                color: Colors.white,
                clipBehavior: Clip.none,
                elevation: 8,
                shadowColor: ThemeColors.primaryColor,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                child: SizedBox(
                  height: 88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _NavItem(
                        index: 0,
                        currentIndex: tabsRouter.activeIndex,
                        icon: AppAssets.calendar,
                        selectedIcon: AppAssets.calendarSelected,
                        onTap: () => tabsRouter.setActiveIndex(0),
                      ),
                      _NavItem(
                        index: 1,
                        currentIndex: tabsRouter.activeIndex,
                        icon: AppAssets.search,
                        selectedIcon: AppAssets.searchSelected,
                        onTap: () => tabsRouter.setActiveIndex(1),
                      ),
                      const SizedBox(width: 48), // место под центральную кнопку
                      _NavItem(
                        index: 3,
                        currentIndex: tabsRouter.activeIndex,
                        icon: AppAssets.champion,
                        selectedIcon: AppAssets.championSelected,
                        onTap: () => tabsRouter.setActiveIndex(3),
                      ),
                      _NavItem(
                        index: 4,
                        currentIndex: tabsRouter.activeIndex,
                        icon: AppAssets.profile,
                        selectedIcon: AppAssets.profileSelected,
                        onTap: () => tabsRouter.setActiveIndex(4),
                      ),
                    ],
                  ),
                ),
              ),
            );
            // return Visibility(
            //   visible: !isHide,
            //   child: BottomAppBarWidget(
            //     shadowColor: Colors.cyan,
            //     height: 1.sw > 600 ? 93.h : 61.h,
            //
            //     surfaceTintColor: Colors.white,
            //     clipBehavior: Clip.hardEdge,
            //     shape: const CircularNotchedRectangle(),
            //     notchMargin: 1.sw > 600 ? 13 : 8,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: List.generate(
            //         bottomNavBarItems.length,
            //         (index) => Expanded(
            //           child: BottomNavBarItemWidget(
            //             icon: bottomNavBarItems[index].key,
            //             label: bottomNavBarItems[index].value,
            //             onTap: () {
            //               tabsRouter.setActiveIndex(index);
            //             },
            //             selected: tabsRouter.activeIndex == index,
            //             isTablet: 1.sw > 600,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // );

            // this.tabsRouter = tabsRouter;
            // return BottomNavigationBar(
            //   backgroundColor: Colors.white,
            //   elevation: 10,
            //   currentIndex: tabsRouter.activeIndex,
            //   onTap: (value) {
            //     tabsRouter.setActiveIndex(value);
            //   },
            //   selectedItemColor: Colors.black,
            //   unselectedItemColor: Colors.cyan,
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            //   type: BottomNavigationBarType.fixed,
            //   items: [
            //     BottomNavigationBarItem(
            //       label: 'calendar',
            //       icon: SvgPicture.asset(AppAssets.calendar),
            //       activeIcon: SvgPicture.asset(AppAssets.calendarSelected),
            //     ),
            //     BottomNavigationBarItem(
            //       icon: SvgPicture.asset(AppAssets.search),
            //       activeIcon: SvgPicture.asset(AppAssets.searchSelected),
            //       label: 'search',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: SvgPicture.asset(AppAssets.champion),
            //       activeIcon: SvgPicture.asset(AppAssets.calendarSelected),
            //       label: 'awards',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: SvgPicture.asset(AppAssets.profile),
            //       activeIcon: SvgPicture.asset(AppAssets.profileSelected),
            //       label: 'profile',
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String icon, selectedIcon;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;
    return IconButton(onPressed: onTap, icon: isSelected ? SvgPicture.asset(selectedIcon) : SvgPicture.asset(icon));
  }
}

class BottomNavBarItemWidget extends StatelessWidget {
  final String? icon;
  final String? label;
  final GestureTapCallback onTap;
  final bool selected;
  final bool isTablet;

  const BottomNavBarItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.selected,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: selected
          ? SvgPicture.asset(selected ? icon! : label!, height: isTablet ? 30.h : 20.h, width: isTablet ? 30.r : 20.r)
          : SizedBox(height: isTablet ? 30.h : 20.h, width: isTablet ? 30.r : 20.r),
    );
  }
}
