import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/router/app_router.gr.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        backgroundColor: ThemeColors.base100,
        iconColor: Colors.white,
        buttonColor: Colors.white,
        showBackButton: true,
        title: Tooltip(
          message: 'Коментарий',
          child: Text(
            'Коментарий',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const Icon(Icons.clear, color: Colors.black),
            onTap: () async {
              final router = context.router;
              await router.maybePop();
              await router.maybePop();
              await router.maybePop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Text(
              'Последный штрих',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
            5.height,
            Text(
              'Хотите добавить что-то ёще? Ваш развернутый отзыв очень важен для нас',
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            30.height,
            TextFormField(
              controller: controller,
              maxLines: 8,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Напишите здесь',
                hintStyle: TextStyle(color: ThemeColors.base400, fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.primaryColor),
                ),
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.primaryColor),
                ),
                Container(
                  height: 3.h,
                  width: 0.3.sw,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ThemeColors.primaryColor),
                ),
              ],
            ),
            20.height,
            ButtonWithScale(
              onPressed: () {
                context.router.push(CongratulationsRoute());
              },
              text: 'Отправить отзый',
            ),
          ],
        ),
      ),
    );
  }
}
