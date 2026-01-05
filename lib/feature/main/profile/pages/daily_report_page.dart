import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/network/model/dashboard_metrics_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../domain/core/extensions/top_snackbar.dart';
import '../../../../router/app_router.gr.dart';

@RoutePage()
class DailyReportPage extends StatefulWidget {
  const DailyReportPage({super.key});

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  final waterController = TextEditingController();
  final sleepController = TextEditingController();
  final stepsController = TextEditingController();

  final ValueNotifier<File?> breakfastImageNotifier = ValueNotifier(null);
  final ValueNotifier<File?> lunchImageNotifier = ValueNotifier(null);
  final ValueNotifier<File?> dinnerImageNotifier = ValueNotifier(null);
  final ValueNotifier<String?> breakfastNetworkImageNotifier = ValueNotifier(null);
  final ValueNotifier<String?> lunchNetworkImageNotifier = ValueNotifier(null);
  final ValueNotifier<String?> dinnerNetworkImageNotifier = ValueNotifier(null);

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final img = File(image.path);
        return img;
      }
      return null;
    } catch (e) {
      debugPrint('object something went wrong catch $e');
      return null;
    }
  }

  void initializeDashboardMetrics(DashboardMetricsResponse dashboardMetrics) {
    waterController.text = '${dashboardMetrics.water?.current}';
    sleepController.text = '${dashboardMetrics.sleep?.current}';
    stepsController.text = '${dashboardMetrics.steps?.current}';
  }

  Future<void> initializeNutrition(NutritionDiaryResponse nutrition) async {
    breakfastNetworkImageNotifier.value = nutrition.breakfast?.imageUrl;
    lunchNetworkImageNotifier.value = nutrition.lunch?.imageUrl;
    dinnerNetworkImageNotifier.value = nutrition.dinner?.imageUrl;
  }

  @override
  void initState() {
    final state = context.read<DashboardMetricsCubit>().state;
    if (state is DashboardMetricsLoaded) {
      initializeDashboardMetrics(state.dashboardMetrics);
    }
    final nutritionDayState = context.read<NutritionDayCubit>().state;
    if (nutritionDayState is NutritionDayLoaded) {
      initializeNutrition(nutritionDayState.nutrition);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Дневной отчёт',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocConsumer<NutritionDayCubit, NutritionDayState>(
        listener: (context, state) {
          if (state is NutritionDayLoaded) {
            CustomSneakBar.show(context: context, status: SneakBarStatus.success, title: 'Фото успешно добавлено');
          }
        },
        builder: (context, state) => SingleChildScrollView(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppAssets.organicFood),
                  10.width,
                  Text(
                    'Питание',
                    style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              8.height,
              Text(
                'Загрузите фото приёма пищи на завтрак, обед и ужин',
                style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              15.height,
              Text(
                'Завтрак',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              8.height,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.time),
                  10.width,
                  Text(
                    'с 06:00 до 12:00',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.height,
              ValueListenableBuilder(
                valueListenable: breakfastImageNotifier,
                builder: (context, image, child) => ValueListenableBuilder(
                  valueListenable: breakfastNetworkImageNotifier,
                  builder: (context, networkImage, child) => DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(15.r),
                      dashPattern: [20, 20],
                      strokeWidth: 2,
                      color: ThemeColors.base200,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                      alignment: Alignment.center,
                      child: networkImage != null
                          ? CustomCachedNetworkImage(
                              imageUrl: networkImage,
                              height: 300.h,
                              borderRadius: BorderRadius.circular(15.r),
                            )
                          : image != null
                          ? Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                              child: Stack(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(15.r), child: Image.file(image)),
                                  Positioned(
                                    right: 5.r,
                                    top: 5.r,
                                    child: InkWell(
                                      onTap: () {
                                        breakfastImageNotifier.value = null;
                                      },
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: ThemeColors.baseBlack,
                                        child: Icon(Icons.clear, color: Colors.white, size: 18.r),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  breakfastImageNotifier.value = image;
                                  nutritionCubit.upload(image, 'breakfast');
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                height: 200.h,
                                width: 1.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.upload),
                                    10.height,
                                    Text(
                                      'Загрузите изображение',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              15.height,
              Text(
                'Обед',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              8.height,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.time),
                  10.width,
                  Text(
                    'с 12:00 до 16:00',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.height,
              ValueListenableBuilder(
                valueListenable: lunchImageNotifier,
                builder: (context, image, child) => ValueListenableBuilder(
                  valueListenable: lunchNetworkImageNotifier,
                  builder: (context, networkImage, child) => DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(15.r),
                      dashPattern: [20, 20],
                      strokeWidth: 2,
                      color: ThemeColors.base200,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                      // height: 200.h,
                      // width: 1.sw,
                      alignment: Alignment.center,
                      child: networkImage != null
                          ? CustomCachedNetworkImage(
                              imageUrl: networkImage,
                              height: 300.h,
                              borderRadius: BorderRadius.circular(15.r),
                            )
                          : image != null
                          ? Container(
                              // height: 200.h,
                              // width: 1.sw,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                              child: Stack(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(15.r), child: Image.file(image)),
                                  Positioned(
                                    right: 5.r,
                                    top: 5.r,
                                    child: InkWell(
                                      onTap: () {
                                        lunchImageNotifier.value = null;
                                      },
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: ThemeColors.baseBlack,
                                        child: Icon(Icons.clear, color: Colors.white, size: 18.r),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  lunchImageNotifier.value = image;
                                  nutritionCubit.upload(image, 'lunch');
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                height: 200.h,
                                width: 1.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.upload),
                                    10.height,
                                    Text(
                                      'Загрузите изображение',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              15.height,
              Text(
                'Ужин',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              8.height,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.time),
                  10.width,
                  Text(
                    'с 16:00 до 22:00',
                    style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              10.height,
              ValueListenableBuilder(
                valueListenable: dinnerImageNotifier,
                builder: (context, image, child) => ValueListenableBuilder(
                  valueListenable: dinnerNetworkImageNotifier,
                  builder: (context, networkImage, child) => DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(15.r),
                      dashPattern: [20, 20],
                      strokeWidth: 2,
                      color: ThemeColors.base200,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                      // height: 200.h,
                      // width: 1.sw,
                      alignment: Alignment.center,
                      child: networkImage != null
                          ? CustomCachedNetworkImage(
                              imageUrl: networkImage,
                              height: 300.h,
                              borderRadius: BorderRadius.circular(15.r),
                            )
                          : image != null
                          ? Container(
                              // height: 200.h,
                              // width: 1.sw,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                              child: Stack(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(15.r), child: Image.file(image)),
                                  Positioned(
                                    right: 5.r,
                                    top: 5.r,
                                    child: InkWell(
                                      onTap: () {
                                        dinnerImageNotifier.value = null;
                                      },
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: ThemeColors.baseBlack,
                                        child: Icon(Icons.clear, color: Colors.white, size: 18.r),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  dinnerImageNotifier.value = image;
                                  nutritionCubit.upload(image, 'dinner');
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                height: 200.h,
                                width: 1.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.upload),
                                    10.height,
                                    Text(
                                      'Загрузите изображение',
                                      style: TextStyle(
                                        color: ThemeColors.base400,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              20.height,
              BlocConsumer<NutritionAnalyzeCubit, NutritionAnalyzeState>(
                listener: (context, state) {
                  if (state is NutritionAnalyzeLoaded) {
                    context.router.push(DailyReportResultRoute());
                  }
                },
                builder: (context, state) => ButtonWithScale(
                  isLoading: state is NutritionAnalyzeLoading,
                  onPressed: () {
                    context.read<NutritionAnalyzeCubit>().analyze();
                  },
                  text: 'Проверить питание',
                ),
              ),
              20.height,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.noteEdit),
                  10.width,
                  Text(
                    'Показатели за сегодня',
                    style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              8.height,
              Text(
                'Заполните данные за текущий день',
                style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              15.height,
              Text(
                'Выпито воды (мл)',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              5.height,
              TextFormField(
                controller: waterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '0'),
              ),
              15.height,
              Text(
                'Сон (часы)',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              5.height,
              TextFormField(
                controller: sleepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '0'),
              ),
              15.height,
              Text(
                'Шаги (за сегодня)',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              5.height,
              TextFormField(
                controller: stepsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '0'),
              ),
              15.height,
              BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                listener: (context, state) async {
                  if (state is DashboardMetricsLoaded) {
                    final router = context.router;
                    router.maybePop();
                    await CustomSneakBar.show(
                      context: context,
                      status: SneakBarStatus.success,
                      title: 'Дневной отчет успешно изменен!',
                    );
                  }
                },
                builder: (context, state) => ButtonWithScale(
                  isLoading: state is DashboardMetricsLoading,
                  onPressed: () async {
                    await context.read<DashboardMetricsCubit>().updateMetrics(
                      waterML: int.tryParse(waterController.text),
                      sleepHours: double.tryParse(sleepController.text),
                      steps: int.tryParse(stepsController.text),
                    );
                  },
                  text: 'Сохранить',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
