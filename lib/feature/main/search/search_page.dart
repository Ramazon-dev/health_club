import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            40.height,
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.r),
                hintText: 'Поиск',
                filled: true,
                fillColor: ThemeColors.base100,
                prefixIcon: IconButton(
                  onPressed: () {
                    context.router.maybePop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new, color: ThemeColors.baseBlack),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppAssets.search,
                    height: 20.r,
                    width: 20.r,
                    colorFilter: ColorFilter.mode(ThemeColors.base400, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Недавние',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ThemeColors.black950),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Очистить все',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.black300),
                  ),
                ),
              ],
            ),
            20.height,
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Row(
                children: [
                  CircleAvatar(radius: 24.r, backgroundColor: Colors.yellow),
                  10.width,
                  Text(
                    '35 health club',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.black950),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                ],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
