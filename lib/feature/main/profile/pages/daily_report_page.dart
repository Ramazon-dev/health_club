import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class DailyReportPage extends StatefulWidget {
  const DailyReportPage({super.key});

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  final breakfastTitleController = TextEditingController();
  final breakfastTextController = TextEditingController();
  final lunchTitleController = TextEditingController();
  final lunchTextController = TextEditingController();
  final dinnerTitleController = TextEditingController();
  final dinnerTextController = TextEditingController();

  final ValueNotifier<File?> breakfastImageNotifier = ValueNotifier(null);
  final ValueNotifier<File?> lunchImageNotifier = ValueNotifier(null);
  final ValueNotifier<File?> dinnerImageNotifier = ValueNotifier(null);
  final ValueNotifier<List<String>?> breakfastNetworkImageNotifier = ValueNotifier(null);
  final ValueNotifier<List<String>?> lunchNetworkImageNotifier = ValueNotifier(null);
  final ValueNotifier<List<String>?> dinnerNetworkImageNotifier = ValueNotifier(null);

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final result = await compressAndConvert(image);
        if (result != null) {
          final img = File(result.path);
          return img;
        }
      }
      return null;
    } catch (e) {
      print('object something went wrong catch $e');
      return null;
    }
  }

  Future<XFile?> compressAndConvert(XFile file) async {
    final filePath = file.path;

    final outPath = "${filePath.substring(0, filePath.lastIndexOf('.'))}_converted.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      outPath,
      format: CompressFormat.jpeg,
      quality: 90,
    );

    return result;
  }

  Future<void> initializeNutrition(NutritionDiaryResponse nutrition) async {
    breakfastNetworkImageNotifier.value = nutrition.breakfast?.images;
    lunchNetworkImageNotifier.value = nutrition.lunch?.images;
    dinnerNetworkImageNotifier.value = nutrition.dinner?.images;
  }

  @override
  void initState() {
    final nutritionDayState = context.read<NutritionDayCubit>().state;
    if (nutritionDayState is NutritionDayLoaded) {
      initializeNutrition(nutritionDayState.nutrition);
    }
    super.initState();
  }

  @override
  void dispose() {
    breakfastTitleController.dispose();
    breakfastTextController.dispose();
    lunchTitleController.dispose();
    lunchTextController.dispose();
    dinnerTitleController.dispose();
    dinnerTextController.dispose();
    breakfastImageNotifier.dispose();
    lunchImageNotifier.dispose();
    dinnerImageNotifier.dispose();
    breakfastNetworkImageNotifier.dispose();
    lunchNetworkImageNotifier.dispose();
    dinnerNetworkImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Мое питание',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocConsumer<NutritionDayCubit, NutritionDayState>(
        listener: (context, state) {
          if (state is NutritionDayLoaded) {
            breakfastImageNotifier.value = null;
            lunchImageNotifier.value = null;
            dinnerImageNotifier.value = null;
            breakfastTitleController.text = '';
            breakfastTextController.text = '';
            lunchTitleController.text = '';
            lunchTextController.text = '';
            dinnerTitleController.text = '';
            dinnerTextController.text = '';
            initializeNutrition(state.nutrition);
            context.read<NutritionHistoryCubit>().fetchHistory();
            CustomSneakBar.show(context: context, status: SneakBarStatus.success, title: 'Фото успешно добавлено');
          } else if (state is NutritionDayError) {
            final message = state.message;
            if (message != null) {
              CustomSneakBar.show(context: context, status: SneakBarStatus.error, title: message);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                  'Загрузите все фотографии пищи за день. Анализ и рекомендации по еде можно посмотреть в разделе «Дневные показатели»',
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
                  builder: (context, image, child) => DottedBorder(
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
                      child: image != null
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
                                // final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  breakfastImageNotifier.value = image;
                                  // nutritionCubit.upload(image, 'breakfast');
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
                10.height,
                ValueListenableBuilder(
                  valueListenable: breakfastNetworkImageNotifier,
                  builder: (context, images, child) => (images == null || images.isEmpty)
                      ? SizedBox()
                      : Container(
                          height: 100.r,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CustomCachedNetworkImage(
                              imageUrl: images[index],
                              height: 100.r,
                              width: 100.r,
                              borderRadius: BorderRadius.circular(15.r),
                              fit: BoxFit.cover,
                            ),
                            separatorBuilder: (context, index) => 10.width,
                            itemCount: images.length,
                          ),
                        ),
                ),
                10.height,
                ValueListenableBuilder(
                  valueListenable: breakfastImageNotifier,
                  builder: (context, image, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Название',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: breakfastTitleController,
                        decoration: InputDecoration(hintText: 'Например: Омлет с тостами'),
                        maxLength: 250,
                      ),
                      15.height,
                      Text(
                        'Детальное описание',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: breakfastTextController,
                        decoration: InputDecoration(hintText: 'Ингредиенты, вес, способ приготовления'),
                        maxLines: 2,
                        maxLength: 1000,
                      ),
                      15.height,
                      ButtonWithScale(
                        isLoading: state is NutritionDayLoading,
                        text: 'Отправить на анализ',
                        onPressed: image == null
                            ? null
                            : () {
                                if (breakfastTitleController.text.isEmpty) {
                                  context.showSnackBar('Введите Название еды');
                                } else if (breakfastTextController.text.isEmpty) {
                                  context.showSnackBar('Введите описание еды');
                                } else {
                                  context.read<NutritionDayCubit>().upload(
                                    file: image,
                                    type: 'breakfast',
                                    title: breakfastTitleController.text,
                                    text: breakfastTextController.text,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
                10.height,
                Builder(
                  builder: (context) {
                    if (state is NutritionDayLoaded) {
                      final analysis = state.nutrition.breakfast?.analysis;
                      if (analysis == null) return SizedBox();
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: analysis.mealsResponse.length,
                        itemBuilder: (context, index) {
                          final analytic = analysis.mealsResponse[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                analytic.name ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              10.height,
                              Text(
                                'Калория: ${analytic.calories}',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.verdict ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.recommendation ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.error ?? '',
                                style: TextStyle(
                                  color: ThemeColors.statusRed,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                      );
                    }
                    return SizedBox();
                  },
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
                  builder: (context, image, child) => DottedBorder(
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
                      child: image != null
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
                                // final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  lunchImageNotifier.value = image;
                                  // nutritionCubit.upload(image, 'lunch');
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
                10.height,
                ValueListenableBuilder(
                  valueListenable: lunchNetworkImageNotifier,
                  builder: (context, images, child) => (images == null || images.isEmpty)
                      ? SizedBox()
                      : Container(
                          height: 100.r,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CustomCachedNetworkImage(
                              imageUrl: images[index],
                              height: 100.r,
                              width: 100.r,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            separatorBuilder: (context, index) => 10.width,
                            itemCount: images.length,
                          ),
                        ),
                ),
                10.height,
                ValueListenableBuilder(
                  valueListenable: lunchImageNotifier,
                  builder: (context, image, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Название',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: lunchTitleController,
                        decoration: InputDecoration(hintText: 'Например: Долма'),
                        maxLength: 250,
                      ),
                      15.height,
                      Text(
                        'Детальное описание',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: lunchTextController,
                        decoration: InputDecoration(hintText: 'Ингредиенты, вес, способ приготовления'),
                        maxLines: 2,
                        maxLength: 1000,
                      ),
                      15.height,
                      ButtonWithScale(
                        isLoading: state is NutritionDayLoading,
                        text: 'Отправить на анализ',
                        onPressed: image == null
                            ? null
                            : () {
                                if (lunchTitleController.text.isEmpty) {
                                  context.showSnackBar('Введите Название еды');
                                } else if (lunchTextController.text.isEmpty) {
                                  context.showSnackBar('Введите описание еды');
                                } else {
                                  context.read<NutritionDayCubit>().upload(
                                    file: image,
                                    type: 'lunch',
                                    title: lunchTitleController.text,
                                    text: lunchTextController.text,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
                10.height,
                Builder(
                  builder: (context) {
                    if (state is NutritionDayLoaded) {
                      final analysis = state.nutrition.lunch?.analysis;
                      if (analysis == null) return SizedBox();
                      // if (analysis.isFood != true) return SizedBox();
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final analytic = analysis.mealsResponse[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                analytic.name ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              10.height,
                              Text(
                                'Калория: ${analytic.calories}',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.verdict ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.recommendation ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.error ?? '',
                                style: TextStyle(
                                  color: ThemeColors.statusRed,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: analysis.mealsResponse.length,
                      );
                    }
                    return SizedBox();
                  },
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
                  builder: (context, image, child) => DottedBorder(
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
                      child: image != null
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
                                // final nutritionCubit = context.read<NutritionDayCubit>();
                                final image = await _pickImage(ImageSource.gallery);
                                if (image != null) {
                                  dinnerImageNotifier.value = image;
                                  // nutritionCubit.upload(image, 'dinner');
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
                10.height,
                ValueListenableBuilder(
                  valueListenable: dinnerNetworkImageNotifier,
                  builder: (context, images, child) => (images == null || images.isEmpty)
                      ? SizedBox()
                      : Container(
                          height: 100.r,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CustomCachedNetworkImage(
                              imageUrl: images[index],
                              height: 100.r,
                              width: 100.r,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            separatorBuilder: (context, index) => 10.width,
                            itemCount: images.length,
                          ),
                        ),
                ),
                10.height,
                ValueListenableBuilder(
                  valueListenable: dinnerImageNotifier,
                  builder: (context, image, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Название',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: dinnerTitleController,
                        decoration: InputDecoration(hintText: 'Например: Куриный суп'),
                        maxLength: 250,
                      ),
                      15.height,
                      Text(
                        'Детальное описание',
                        style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      5.height,
                      TextFormField(
                        controller: dinnerTextController,
                        decoration: InputDecoration(hintText: 'Ингредиенты, вес, способ приготовления'),
                        maxLines: 2,
                        maxLength: 1000,
                      ),
                      15.height,
                      ButtonWithScale(
                        isLoading: state is NutritionDayLoading,
                        text: 'Отправить на анализ',
                        onPressed: image == null
                            ? null
                            : () {
                                if (dinnerTitleController.text.isEmpty) {
                                  context.showSnackBar('Введите Название еды');
                                } else if (dinnerTextController.text.isEmpty) {
                                  context.showSnackBar('Введите описание еды');
                                } else {
                                  context.read<NutritionDayCubit>().upload(
                                    file: image,
                                    type: 'dinner',
                                    title: dinnerTitleController.text,
                                    text: dinnerTextController.text,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
                10.height,
                Builder(
                  builder: (context) {
                    if (state is NutritionDayLoaded) {
                      final analysis = state.nutrition.dinner?.analysis;
                      if (analysis == null) return SizedBox();
                      // if (analysis.isFood != true) return SizedBox();
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final analytic = analysis.mealsResponse[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                analytic.name ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              10.height,
                              Text(
                                'Калория: ${analytic.calories}',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.verdict ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.recommendation ?? '',
                                style: TextStyle(
                                  color: ThemeColors.baseBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              10.height,
                              Text(
                                analytic.error ?? '',
                                style: TextStyle(
                                  color: ThemeColors.statusRed,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: analysis.mealsResponse.length,
                      );
                    }
                    return SizedBox();
                  },
                ),
                20.height,
                (kBottomNavigationBarHeight).height,
                // Row(
                //   children: [
                //     SvgPicture.asset(AppAssets.noteEdit),
                //     10.width,
                //     Text(
                //       'Показатели за сегодня',
                //       style: TextStyle(color: ThemeColors.baseBlack, fontSize: 24.sp, fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),
                // 8.height,
                // Text(
                //   'Заполните данные за текущий день',
                //   style: TextStyle(color: ThemeColors.base400, fontSize: 16.sp, fontWeight: FontWeight.w400),
                // ),
                // 15.height,
                // Text(
                //   'Выпито воды (мл)',
                //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                // ),
                // 5.height,
                // TextFormField(
                //   controller: waterController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: '0'),
                // ),
                // 15.height,
                // Text(
                //   'Сон (часы)',
                //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                // ),
                // 5.height,
                // TextFormField(
                //   controller: sleepController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: '0'),
                // ),
                // 15.height,
                // Text(
                //   'Шаги (за сегодня)',
                //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                // ),
                // 5.height,
                // TextFormField(
                //   controller: stepsController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: '0'),
                // ),
                // 15.height,
                // BlocConsumer<DashboardMetricsCubit, DashboardMetricsState>(
                //   listener: (context, state) async {
                //     if (state is DashboardMetricsLoaded) {
                //       final router = context.router;
                //       router.maybePop();
                //       await CustomSneakBar.show(
                //         context: context,
                //         status: SneakBarStatus.success,
                //         title: 'Дневной отчет успешно изменен!',
                //       );
                //     }
                //   },
                //   builder: (context, state) => ButtonWithScale(
                //     isLoading: state is DashboardMetricsLoading,
                //     onPressed: () async {
                //       await context.read<DashboardMetricsCubit>().updateMetrics(
                //         waterML: int.tryParse(waterController.text),
                //         sleepHours: double.tryParse(sleepController.text),
                //         steps: int.tryParse(stepsController.text),
                //       );
                //     },
                //     text: 'Сохранить',
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.r),
        child: ButtonWithScale(
          onPressed: () {
            context.router.pop('setActiveIndex');
          },
          text: 'Дневные показатели',
        ),
      ),
    );
  }
}
