import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClubDetailSliverPage(),
    );
  }

}

class ClubDetailSliverPage extends StatelessWidget {
  const ClubDetailSliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StackedImage();
  }
}

class StackedImage extends StatefulWidget {
  const StackedImage({super.key});

  @override
  State<StackedImage> createState() => _StackedImageState();
}

class _StackedImageState extends State<StackedImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            SizedBox(
              height: 320,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      // 'https://images.pexels.com/photos/4754141/pexels-photo-4754141.jpeg',
                      'https://images.pexels.com/photos/3823063/pexels-photo-3823063.jpeg',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                      ),
                    ),
                    // стрелка назад
                    Positioned(
                      top: 16,
                      left: 16,
                      child: _roundIconButton(
                        context,
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                        onTap: () => context.router.maybePop(),
                      ),
                    ),
                    // значок "поделиться" / избранное / и т.п.
                    Positioned(
                      top: 16,
                      right: 16,
                      child: _roundIconButton(context, icon: SvgPicture.asset(AppAssets.mapWhite), onTap: () {}),
                    ),
                    // индикатор слайдов "1/3"
                    Positioned(
                      bottom: 16,
                      right: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('1/3', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 260,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              'https://images.pexels.com/photos/3823063/pexels-photo-3823063.jpeg',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Row(
                                children: [
                                  Icon(Icons.circle, size: 8, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    'Открыто',
                                    style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text('Пн–Вс, 09:00–22:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      15.height,
                      Text(
                        'Premium Fitness Center',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      5.height,
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: ThemeColors.rateColor),
                          4.width,
                          Text(
                            '4.8 ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          Text(
                            '(154 отзыва)',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                          ),
                        ],
                      ),
                      16.height,
                      Text(
                        '''Premium Fitness Center — современный спортивный комплекс, созданный для тех, кто ценит качество, комфорт и результат. Клуб объединяет профессиональное оборудование, просторные залы, персональные тренировки и заботу о каждом клиенте.''',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                      ),

                      24.height,
                      Text(
                        'Контакты',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      12.height,
                      const _ContactRow(icon: Icons.location_on_outlined, text: 'Алмазарский р., улица Беруни, 2 дом'),
                      8.height,
                      const _ContactRow(icon: Icons.public, text: 'premiumfitnessclub.uz'),
                      15.height,
                      ButtonWithScale(
                        // isLoading: isLoading,
                        onPressed: () {},
                        text: 'Забронировать',
                      ),
                      40.height,
                      Text(
                        'Тренеры',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      15.height,
                      SizedBox(
                        height: 325.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: ThemeColors.base100,
                            ),
                            child: Column(
                              children: [
                                CustomCachedNetworkImage(
                                  imageUrl:
                                  'https://images.unsplash.com/photo-1507019403270-cca502add9f8?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybCUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
                                  height: 250.h,
                                  width: 240.r,
                                ),
                                15.height,
                                Text(
                                  'Софи Беннет',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.baseBlack,
                                  ),
                                ),
                                5.height,
                                Text(
                                  'Профессиональный тренер',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors.base400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(width: 10.r),
                          itemCount: 4,
                        ),
                      ),
                      30.height,
                      Text(
                        'Отзывы',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      15.height,
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: ThemeColors.base100,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: CustomCachedNetworkImage(
                                      imageUrl: 'https://images.pexels.com/photos/3823063/pexels-photo-3823063.jpeg',
                                      borderRadius: BorderRadius.circular(100),
                                      width: 56.r,
                                      height: 56.r,
                                    ),
                                  ),
                                  10.width,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Азиз Хасанов',
                                        style: TextStyle(
                                          color: ThemeColors.baseBlack,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Клиент',
                                        style: TextStyle(
                                          color: ThemeColors.base300,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              20.height,
                              Divider(),
                              20.height,
                              Row(children: [StarRating(rating: 5)]),
                              12.height,
                              Text(
                                'Отличный фитнес-клуб с современным оборудованием и приятной атмосферой. Тренеры внимательные, всё объясняют и помогают с программой тренировок. Очень доволен результатами!',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => 10.height,
                        itemCount: 3,
                      ),
                      15.height,
                      SecondaryButton(onPressed: () {}, text: 'Смотреть все'),
                      30.height,
                      Text(
                        'Время работы',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      15.height,
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.r,vertical: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: ThemeColors.base100,
                          ),
                          child: Row(
                            children: [
                              if (index == 0) ...[
                                CircleAvatar(radius: 5.r,backgroundColor: ThemeColors.statusColor),
                                15.width,
                              ],
                              Text(
                                'Понедельник',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                              ),
                              Spacer(),
                              Text(
                                '11:00 - 21:00',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 5.h),
                        itemCount: 7,
                      ),
                      30.height,
                      Text(
                        'Другие филиалы',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      15.height,
                      ListView.separated(
                        itemCount: 2,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: ThemeColors.base100,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: ThemeColors.primaryColor.withValues(alpha: 0.2),
                                offset: const Offset(0, 8),
                                blurRadius: 12,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: CustomCachedNetworkImage(
                                        imageUrl: 'https://images.pexels.com/photos/3823063/pexels-photo-3823063.jpeg',
                                        borderRadius: BorderRadius.circular(100),
                                        width: 56.r,
                                        height: 56.r,
                                      ),
                                    ),
                                    10.width,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Premium Fitness Center',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                        2.height,
                                        Row(
                                          children: [
                                            Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 20.r),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '4.8 ',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors.black950,
                                              ),
                                            ),
                                            Text(
                                              '(1 154 отзывов)',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors.base400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                25.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(radius: 3.r, backgroundColor: ThemeColors.flowKitGreen),
                                            5.width,
                                            Text(
                                              'Открыто до 18:00',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors.flowKitGreen,
                                              ),
                                            ),
                                          ],
                                        ),
                                        10.height,
                                        Text(
                                          '3 км от вас',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColors.base400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(AppAssets.map, height: 54.r, width: 54.r),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      ),
                      300.height,
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundIconButton(BuildContext context, {required Widget icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 56.r,
            height: 56.r,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(color: Colors.white24),
            child: icon,
          ),
        ),
      ),
      // child: Container(
      //   width: 56.r,
      //   height: 56.r,
      //   decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(16.r)),
      //   child: Icon(icon, color: Colors.white, size: 18),
      // ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: ThemeColors.baseBlack),
        8.width,
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
          ),
        ),
      ],
    );
  }
}
