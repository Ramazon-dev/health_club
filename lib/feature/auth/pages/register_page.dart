import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/auth/pages/widgets/list_item.dart';
import 'package:health_club/feature/auth/pages/widgets/uzbekistan_cities.dart';
import 'package:health_club/router/app_router.gr.dart';
import '../../../data/network/model/clubs_response.dart';
import '../../../data/network/model/auth/wizard_options_response.dart';
import '../../../data/storage/app_storage.dart';
import '../../../design_system/design_system.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../di/init.dart';
import 'package:collection/collection.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  final int step;

  const RegisterPage({super.key, required this.step});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otherConcernController = TextEditingController();
  final TextEditingController otherProblemController = TextEditingController();
  final TextEditingController otherTargetController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // final TextEditingController timeController = TextEditingController();

  ValueNotifier<List<WizardOptionResponse>> selectedConcernNotifier = ValueNotifier([]);
  ValueNotifier<List<WizardOptionResponse>> selectedProblemNotifier = ValueNotifier([]);
  ValueNotifier<List<WizardOptionResponse>> selectedTargetNotifier = ValueNotifier([]);
  ValueNotifier<Region?> selectedRegionNotifier = ValueNotifier(null);
  ValueNotifier<District?> selectedDistrictNotifier = ValueNotifier(null);

  // ValueNotifier<BodyDetails?> selectedBodyDetailNotifier = ValueNotifier(null);
  ValueNotifier<bool?> genderNotifier = ValueNotifier(null);
  ValueNotifier<ClubResponse?> selectedClubNotifier = ValueNotifier(null);

  // ValueNotifier<int> selectedWeekDayNotifier = ValueNotifier(DateTime.now().weekday);
  ValueNotifier<String?> selectedTime = ValueNotifier(null);

  bool showOtherConcern = false;
  bool showOtherProblem = false;
  bool showOtherTarget = false;

  void changeScroll({double? position}) {
    scrollController.animateTo(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    if (widget.step == 0 || widget.step == 1) {
      // context.read<RegisterCubit>().initializeWizardStep(widget.step);
      // context.read<RegisterCubit>().changeToInitial();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>()..getWizard(widget.step),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            toolbarHeight: kToolbarHeight + 10.h,
            // leadingWidth: 20.w + 54.h,
            // leading: InkWell(
            //   onTap: () {
            //     Navigator.of(context).maybePop();
            //   },
            //   child: Center(
            //     child: Container(
            //       margin: EdgeInsets.only(left: 16.r, top: 10.h),
            //       height: 54.h,
            //       width: 54.h,
            //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: ThemeColors.base100),
            //       child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black, size: 18.sp),
            //     ),
            //   ),
            // ),
            actions: [
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterDiagnostics || state is RegisterSuccess || state is RegisterLoading) {
                    return SizedBox();
                  } else {
                    return TextButton(
                      onPressed: () {
                        context.read<RegisterCubit>().skip();
                      },
                      child: Text('Пропустить'),
                    );
                  }
                },
              ),
            ],
          ),
          bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: state is RegisterName
                    ? ButtonWithScale(
                        onPressed: () {
                          final cubit = context.read<RegisterCubit>();
                          if (nameController.text.isEmpty) {
                            context.showSnackBar('Введите имя');
                          } else if (lastnameController.text.isEmpty) {
                            context.showSnackBar('Введите фамилию');
                          } else {
                            cubit.uploadName(name: nameController.text, surname: lastnameController.text);
                          }
                          // cubit.changeToName();
                        },
                        text: 'Продолжить',
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonWithScale(
                            width: 0.3.sw,
                            height: 60.h,
                            color: ThemeColors.base100,
                            onPressed: () {
                              changeScroll();
                              final cubit = context.read<RegisterCubit>();
                              // if (state is RegisterName) {
                              //   cubit.changeToInitial();
                              // } else
                              if (state is RegisterConcerns) {
                                cubit.changeToName();
                              } else if (state is RegisterProblems) {
                                cubit.changeToConcerns();
                              } else if (state is RegisterBodyDetails) {
                                cubit.changeToProblems();
                              } else if (state is RegisterBodyDetailsResult) {
                                cubit.changeToBodyDetails();
                              } else if (state is RegisterGift) {
                                cubit.changeToBodyDetailsResult();
                              } else if (state is RegisterTarget) {
                                cubit.changeToGift();
                              } else if (state is RegisterAddress) {
                                cubit.changeToTarget();
                              } else if (state is RegisterDiagnostics) {
                                cubit.changeToAddress();
                              } else if (state is RegisterSuccess) {
                                cubit.changeToDiagnostics();
                              }
                            },
                            text: 'Назад',
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          ButtonWithScale(
                            // isLoading: state is RegisterLoading,
                            width: 0.58.sw,
                            height: 60.h,
                            text: (state is RegisterBodyDetailsResult) ? 'ПОЛУЧИТЬ ПОДАРОК' : 'Продолжить',
                            color: (state is RegisterBodyDetailsResult)
                                ? ThemeColors.statusRed
                                : ThemeColors.primaryColor,
                            onPressed: () {
                              changeScroll();
                              final cubit = context.read<RegisterCubit>();
                              // if (state is RegisterInitial) {
                              //   cubit.changeToName();
                              // } else
                              //   if (state is RegisterName) {
                              //   if (nameController.text.isEmpty) {
                              //     context.showSnackBar('Введите имя');
                              //   } else if (lastnameController.text.isEmpty) {
                              //     context.showSnackBar('Введите фамилию');
                              //   } else {
                              //     cubit.uploadName(name: nameController.text, surname: lastnameController.text);
                              //   }
                              // } else
                              if (state is RegisterConcerns) {
                                final selectedCorner = selectedConcernNotifier.value
                                    .where((element) => (element.selected ?? false))
                                    .toList();
                                if (selectedCorner.isNotEmpty || otherConcernController.text.isNotEmpty) {
                                  final selected = selectedCorner.map((e) => e.text ?? '').toList();
                                  cubit.uploadConcern(selected, otherConcernController.text);
                                } else {
                                  context.showSnackBar('Выберите что вас беспокоит');
                                }
                              } else if (state is RegisterProblems) {
                                final selectedProblem = selectedProblemNotifier.value
                                    .where((element) => (element.selected ?? false))
                                    .toList();
                                if (selectedProblem.isNotEmpty || otherProblemController.text.isNotEmpty) {
                                  final selected = selectedProblem.map((e) => e.text ?? '').toList();
                                  cubit.uploadProblem(selected, otherProblemController.text);
                                } else {
                                  context.showSnackBar('Введите какие у вас проблемы');
                                }
                              } else if (state is RegisterBodyDetails) {
                                if (heightController.text.isEmpty) {
                                  context.showSnackBar('Введите свой рост');
                                } else if (widthController.text.isEmpty) {
                                  context.showSnackBar('Введите свой вес');
                                } else if (birthController.text.isEmpty) {
                                  context.showSnackBar('Введите дату рождения');
                                } else if (genderNotifier.value == null) {
                                  context.showSnackBar('Выберите пол');
                                } else {
                                  cubit.uploadBodyDetails(
                                    height: heightController.text,
                                    width: widthController.text,
                                    birthday: birthController.text,
                                    gender: genderNotifier.value == true,
                                  );
                                }
                              } else if (state is RegisterBodyDetailsResult) {
                                cubit.changeToGift();
                              } else if (state is RegisterGift) {
                                cubit.getTargets();
                              } else if (state is RegisterTarget) {
                                final selectedTarget = selectedTargetNotifier.value
                                    .where((element) => (element.selected ?? false))
                                    .toList();
                                if (selectedTarget.isNotEmpty || otherTargetController.text.isNotEmpty) {
                                  final selected = selectedTarget.map((e) => e.text ?? '').toList();
                                  cubit.uploadTarget(selected, otherTargetController.text);
                                } else {
                                  context.showSnackBar('Введите какие у вас цель');
                                }
                              } else if (state is RegisterAddress) {
                                if (selectedRegionNotifier.value == null) {
                                  context.showSnackBar('Введите свой город');
                                } else if (selectedDistrictNotifier.value == null) {
                                  context.showSnackBar('Введите свой район');
                                } else {
                                  cubit.uploadAddress(
                                    '${selectedRegionNotifier.value?.name ?? ''} - ${selectedDistrictNotifier.value?.name ?? ''}',
                                  );
                                }
                                // if (addressController.text.isNotEmpty) {
                                //   cubit.uploadAddress(addressController.text);
                                // } else {
                                //   context.showSnackBar('Введите свой адрес');
                                // }
                              } else if (state is RegisterDiagnostics) {
                                if (selectedClubNotifier.value == null) {
                                  context.showSnackBar('Выберите клуб');
                                } else if (dateController.text.isEmpty) {
                                  context.showSnackBar('Выберите дату');
                                } else if (selectedTime.value == null) {
                                  context.showSnackBar('Выберите время');
                                } else {
                                  cubit.uploadDiagnostic(
                                    placeId: selectedClubNotifier.value?.id ?? 10,
                                    date: dateController.text,
                                    time: selectedTime.value!,
                                  );
                                }
                              } else if (state is RegisterSuccess) {
                                getIt<AppStorage>().setRegister(true);
                                context.router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
                              }
                            },
                          ),
                        ],
                      ),
              );
            },
          ),

          body: BlocConsumer<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) => current is! RegisterLoading,
            listener: (context, state) {
              if (state is RegisterName) {
                final wizard = state.wizard;
                if (wizard == null) return;
                nameController.text = wizard.user?.name ?? '';
                lastnameController.text = wizard.user?.surname ?? '';
                birthController.text = wizard.user?.birthday ?? '';
                genderNotifier.value = (wizard.user?.gender ?? '') == 'M';
                heightController.text = wizard.user?.height ?? '';
                widthController.text = wizard.user?.weight ?? '';
                addressController.text = wizard.user?.address ?? '';
              } else
              // if (state is RegisterError) {
              //   print('object RegisterCubit Error state changed ${state.message}');
              // } else
              if (state is RegisterConcerns) {
                selectedConcernNotifier.value = state.options;
              } else if (state is RegisterProblems) {
                selectedProblemNotifier.value = state.options;
              } else if (state is RegisterTarget) {
                selectedTargetNotifier.value = state.options;
              } else if (state is RegisterSkipped) {
                getIt<AppStorage>().setRegister(true);
                context.router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
              }
            },
            builder: (context, state) => SizedBox(
              height: 1.sh,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.only(left: 16.r, right: 16.r, bottom: 16.h, top: 16.h),
                    // padding: EdgeInsets.all(16.r),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 80.height,
                        // if (state is RegisterInitial) ...[
                        //   Text(
                        //     'Фитнес, который не навредит 💚',
                        //     style: TextStyle(
                        //       fontSize: 30.sp,
                        //       fontWeight: FontWeight.w500,
                        //       color: ThemeColors.baseBlack,
                        //     ),
                        //   ),
                        //   // 10.height,
                        //   // Text(
                        //   //   'Я помогу подобрать тренировки под твое здоровье',
                        //   //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                        //   // ),
                        //   30.height,
                        //   MessageItem(
                        //     text:
                        //         'Привет, я Мила я помогу тебе подобрать лучший путь к достижению твоих целей здоровья. 😊',
                        //     boxColor: Color(0xff70C5C7),
                        //   ),
                        //   30.height,
                        //   Image.asset(AppAssets.mila),
                        // ] else
                        if (state is RegisterName) ...[
                          MessageItem(
                            text:
                                'Здравствуйте! Меня зовут Мила и я Ваш личный  Ассистент здоровья в 35’ Health Club. Давайте познакомимся!',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          Text(
                            'Имя',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ThemeColors.base100,
                              hintText: 'Имя',
                              hintStyle: TextStyle(color: ThemeColors.base500),
                            ),
                          ),
                          10.height,
                          Text(
                            'Фамилия',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          TextFormField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                              hintText: 'Фамилия',
                              filled: true,
                              fillColor: ThemeColors.base100,
                              hintStyle: TextStyle(color: ThemeColors.base500),
                            ),
                          ),
                          20.height,
                        ] else if (state is RegisterConcerns) ...[
                          MessageItem(
                            text: 'Очень приятно! Давайте немного поговорим о том, что Вас может беспокоить.',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          ValueListenableBuilder(
                            valueListenable: selectedConcernNotifier,
                            builder: (context, selectedCorner, child) {
                              final firstSelected = selectedCorner.firstWhereOrNull(
                                (element) => element.selected == true,
                              );
                              return Column(
                                children: [
                                  if (firstSelected != null && !showOtherConcern) ...[
                                    MessageItem(text: firstSelected.answer ?? '', boxColor: Color(0xff70C5C7)),
                                    20.height,
                                  ],
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final corner = selectedCorner[index];
                                      return GestureDetector(
                                        onTap: () {
                                          selectedConcernNotifier.value = List.generate(selectedCorner.length, (i) {
                                            final cons = selectedCorner[i];
                                            return i == index
                                                ? corner.copyWith(selected: !(cons.selected ?? false))
                                                : cons;
                                          });
                                          showOtherConcern = corner.text == 'Другое';
                                          setState(() {});
                                        },
                                        child: ListItem(title: corner.text ?? '', selected: corner.selected ?? false),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                                    itemCount: state.options.length,
                                  ),
                                ],
                              );
                            },
                          ),
                          if (showOtherConcern) ...[
                            20.height,
                            TextFormField(
                              controller: otherConcernController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.base100,
                                hintText: 'Опишите, что вас беспокоит',
                              ),
                            ),
                          ],
                          // 20.height,
                          // ReviewsWidget(),
                        ] else if (state is RegisterProblems) ...[
                          MessageItem(
                            text:
                                'Опишите пожалуйста свой образ жизни. \n\nВся информация конфиденциальна и останется между нами.',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          ValueListenableBuilder(
                            valueListenable: selectedProblemNotifier,
                            builder: (context, selectedProblem, child) {
                              final firstSelected = selectedProblem.firstWhereOrNull(
                                (element) => element.selected == true,
                              );
                              return Column(
                                children: [
                                  if (firstSelected != null && !showOtherProblem) ...[
                                    MessageItem(text: firstSelected.answer ?? '', boxColor: Color(0xff70C5C7)),
                                    20.height,
                                  ],
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final problem = selectedProblem[index];
                                      return GestureDetector(
                                        onTap: () {
                                          selectedProblemNotifier.value = List.generate(selectedProblem.length, (i) {
                                            final cons = selectedProblem[i];
                                            return i == index
                                                ? problem.copyWith(selected: !(cons.selected ?? false))
                                                : cons;
                                          });
                                          showOtherProblem = problem.text == 'Другое';
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: problem.selected == true ? ThemeColors.primaryColor : Colors.white,
                                            border: Border.all(color: ThemeColors.inputBorderColor),
                                          ),
                                          child: Text(
                                            problem.text ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: problem.selected == true ? Colors.white : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                                    itemCount: state.options.length,
                                  ),
                                ],
                              );
                            },
                          ),
                          if (showOtherProblem) ...[
                            20.height,
                            TextFormField(
                              controller: otherProblemController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.base100,
                                hintText: 'Опишите, свой образ жизни',
                              ),
                            ),
                          ],
                        ] else if (state is RegisterBodyDetails) ...[
                          // 20.height,
                          MessageItem(text: 'Мы почти у цели!', boxColor: Color(0xff70C5C7)),
                          20.height,
                          MessageItem(
                            text:
                                'Нам очень важно сделать качественную первичную диагностику, поэтому поделитесь еще этой важной информацией.',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          Text(
                            'Рост (СМ)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          TextFormField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Например: 175'),
                          ),
                          10.height,
                          Text(
                            'Вес (КГ)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          TextFormField(
                            controller: widthController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Например: 70'),
                          ),
                          10.height,
                          Text(
                            'Дата рождения',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                birthController.text = date.dateForRequest();
                              }
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: birthController,
                              decoration: InputDecoration(hintText: 'Выберите дату'),
                            ),
                          ),
                          10.height,
                          Text(
                            'Пол',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          ValueListenableBuilder(
                            valueListenable: genderNotifier,
                            builder: (context, isMale, child) => Row(
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: AppCheckboxListTile(
                                    text: 'Мужской',
                                    value: isMale ?? false,
                                    control: ListTileControlAffinity.leading,
                                    radius: 20,
                                    onChanged: (value) {
                                      if (value != null) {
                                        genderNotifier.value = value;
                                      }
                                    },
                                    context: context,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.4.sw,
                                  child: AppCheckboxListTile(
                                    text: 'Женский',
                                    value: !(isMale ?? true),
                                    control: ListTileControlAffinity.leading,
                                    radius: 20,
                                    onChanged: (value) {
                                      if (value != null) {
                                        genderNotifier.value = !value;
                                      }
                                    },
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (state is RegisterBodyDetailsResult) ...[
                          // 20.height,
                          MessageItem(
                            boxColor: Color(0xff70C5C7),
                            text:
                                '''На основе предоставленной информации, мы можем рассчитать Ваш ИМТ (Индекс Массы Тела)''',
                            second: 'Он: (${state.bmi})',
                          ),
                          20.height,
                          MessageItem(
                            boxColor: Color(0xff70C5C7),
                            text: '''Что показывает ИМТ: 
Менее 18.5 - Недостаточно массы
18.5 – 24.9 - Норма
25 – 29.9 - Избыток массы
30 - выше - Ожирение
''',
                          ),
                          20.height,
                          MessageItem(
                            text: 'НО! Эти данные отдельно ничего не означают и мы хотим Вам сделать подарок!',
                            boxColor: Color(0xff70C5C7),
                          ),
                        ] else if (state is RegisterGift) ...[
                          BodyDetail(
                            text: '''Сама масса тела и ИМТ мало дают информации.
Поэтому, мы дарим вам подарок:
Комплексная диагностика состава тела
+ Консультация с нашим специалистом''',
                          ),
                          SizedBox(
                            // color: Colors.yellow,
                            height: 0.45.sh,
                            width: 1.sw,
                            child: Stack(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: genderNotifier,
                                  builder: (context, gender, child) {
                                    return Container(
                                      height: 0.5.sh,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: gender == true
                                              ? AssetImage(AppAssets.manWhite)
                                              : AssetImage(AppAssets.womanWhite),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: 10,
                                  left: 0,
                                  child: BodyDetail(text: '''Процент\n жира в теле - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 0,
                                  child: BodyDetail(text: '''Вода в \n организме - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 180,
                                  left: 0,
                                  child: BodyDetail(text: '''Матаболический\n возраст - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 280,
                                  left: 0,
                                  child: BodyDetail(text: '''Метаболический \n индекс - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  child: BodyDetail(text: '''Выцеральный\n жир - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 100,
                                  right: 0,
                                  child: BodyDetail(text: '''Необходимые\n калории - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 180,
                                  right: 0,
                                  child: BodyDetail(text: '''Состояние\nкостной массы - ?''', isYellow: true),
                                ),
                                Positioned(
                                  top: 280,
                                  right: 0,
                                  child: BodyDetail(text: '''Процент мышечной\nмассы - ?''', isYellow: true),
                                ),
                              ],
                            ),
                          ),
                          BodyDetail(
                            text:
                                '''Обычные весы этого не покажут. нажмите на "Продолжить", и я раскажу, как получить детальный отчет о составе вашего тела и наконец-то достичь цели.''',
                          ),
                        ] else if (state is RegisterTarget) ...[
                          // 20.height,
                          MessageItem(
                            text: 'Какую цель здоровья, Вы всегда мечтали достигнуть?',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          ValueListenableBuilder(
                            valueListenable: selectedTargetNotifier,
                            builder: (context, selectedTarget, child) {
                              final firstSelected = selectedTarget.firstWhereOrNull(
                                (element) => element.selected == true,
                              );
                              return Column(
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final target = selectedTarget[index];
                                      return GestureDetector(
                                        onTap: () {
                                          selectedTargetNotifier.value = List.generate(selectedTarget.length, (i) {
                                            final cons = selectedTarget[i];
                                            return i == index
                                                ? target.copyWith(selected: !(cons.selected ?? false))
                                                : cons;
                                          });
                                          showOtherTarget = target.text == 'Другое';
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: target.selected == true ? ThemeColors.primaryColor : Colors.white,
                                            border: Border.all(color: ThemeColors.inputBorderColor),
                                          ),
                                          child: Text(
                                            target.text ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: target.selected == true ? Colors.white : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                                    itemCount: state.options.length,
                                  ),
                                  if (firstSelected != null && showOtherTarget) ...[
                                    20.height,
                                    MessageItem(text: firstSelected.answer ?? '', boxColor: Color(0xff70C5C7)),
                                  ],
                                ],
                              );
                            },
                          ),
                          if (showOtherTarget) ...[
                            20.height,
                            TextFormField(
                              controller: otherTargetController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.base100,
                                hintText: 'Опишите, что вас беспокоит',
                              ),
                            ),
                          ],
                        ] else if (state is RegisterAddress) ...[
                          // 20.height,
                          MessageItem(
                            text: 'Для получения Вашего подарка, пожалуйста укажите свой город и район проживания.',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          // TextFormField(
                          //   controller: addressController,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: ThemeColors.base100,
                          //     hintText: 'Например: улица Амира Темура, дом 20',
                          //   ),
                          // ),
                          10.height,
                          Text(
                            'Выберите город',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          ValueListenableBuilder(
                            valueListenable: selectedRegionNotifier,
                            builder: (context, selectedRegion, child) {
                              return DropdownButtonFormField2(
                                value: selectedRegion,
                                enableFeedback: true,
                                isExpanded: true,
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedRegionNotifier.value = value;
                                    selectedDistrictNotifier.value = null;
                                  }
                                },
                                items: allRegions
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.name,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.baseBlack,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                iconStyleData: IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15.r, bottom: 15, right: 15.r),
                                ),
                              );
                            },
                          ),
                          20.height,
                          Text(
                            'Выберите район',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          ValueListenableBuilder(
                            valueListenable: selectedRegionNotifier,
                            builder: (context, selectedRegion, child) {
                              return ValueListenableBuilder(
                                valueListenable: selectedDistrictNotifier,
                                builder: (context, selectedDistrict, child) {
                                  return DropdownButtonFormField2(
                                    value: selectedDistrict,
                                    enableFeedback: true,
                                    isExpanded: true,
                                    onChanged: (value) {
                                      if (value != null) {
                                        selectedDistrictNotifier.value = value;
                                      }
                                    },
                                    items: selectedRegion?.districts
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors.baseBlack,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15.r, bottom: 15, right: 15.r),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ] else if (state is RegisterDiagnostics) ...[
                          // 20.height,
                          MessageItem(
                            text:
                                'Остался всего один шаг! Выберите удобный клуб, дату и время для вашей персональной Health-диагностики. Это бесплатно и ни к чему вас не обязывает.',
                            boxColor: Color(0xff70C5C7),
                          ),
                          20.height,
                          Text(
                            'Запись на диагностику',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          20.height,
                          Text(
                            'Клуб',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          ValueListenableBuilder(
                            valueListenable: selectedClubNotifier,
                            builder: (context, selectedClub, child) => DropdownButtonFormField2(
                              value: selectedClub,
                              enableFeedback: true,
                              isExpanded: true,
                              onChanged: (value) {
                                selectedClubNotifier.value = value;
                                final date = dateController.text.parseFromDate();
                                if (date != null && value != null) {
                                  selectedTime.value = null;
                                  // context.read<SlotsCubit>().getSlots(value.id ?? 0, date.weekday);
                                }
                              },
                              selectedItemBuilder: (context) => state.clubs.map((e) {
                                return Text(e.title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis);
                              }).toList(),
                              items: state.clubs
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.baseBlack,
                                            ),
                                          ),
                                          Text(
                                            e.address ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              iconStyleData: IconStyleData(
                                icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15.r, bottom: 15, right: 15.r),
                              ),
                            ),
                          ),
                          10.height,
                          Text(
                            'Дата',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          GestureDetector(
                            onTap: () async {
                              final wizardSlotsCubit = context.read<WizardSlotsCubit>();
                              final now = DateTime.now();
                              final date = await showDatePicker(
                                context: context,
                                firstDate: now,
                                lastDate: now.add(Duration(days: 30)),
                                // lastDate: now.add(Duration(days: 7 - now.weekday)),
                              );
                              final club = selectedClubNotifier.value;
                              if (date == null || club == null) return;
                              selectedTime.value = null;
                              dateController.text = date.dateForRequest();
                              wizardSlotsCubit.fetchSlots(club.id ?? 0, date.dateForRequest());
                              //       selectedTime.value = null;
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: dateController,
                              decoration: InputDecoration(
                                hintText: 'Выберите дату',
                                suffixIcon: Icon(Icons.calendar_today_outlined, color: ThemeColors.base300, size: 22.r),
                              ),
                            ),
                          ),
                          10.height,
                          Text(
                            'Время',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          5.height,
                          BlocConsumer<WizardSlotsCubit, WizardSlotsState>(
                            listener: (context, state) {
                              if (state is WizardSlotsError) {
                                context.showSnackBar(state.message ?? '');
                              }
                            },
                            builder: (context, state) {
                              if (state is WizardSlotsLoaded) {
                                return ValueListenableBuilder(
                                  valueListenable: selectedTime,
                                  builder: (context, time, child) => Wrap(
                                    spacing: 8.r,
                                    runSpacing: 8.r,
                                    children: state.slots
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              selectedTime.value = e;
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8.r),
                                              decoration: BoxDecoration(
                                                color: time == e ? ThemeColors.primaryColor : ThemeColors.base100,
                                                borderRadius: BorderRadius.circular(10.r),
                                              ),
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                  color: time == e ? Colors.white : ThemeColors.baseBlack,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                          //     if (time != null) {
                          //       timeController.text = time.format(context);
                          //     }
                          //   },
                          //   child: TextFormField(
                          //     enabled: false,
                          //     controller: timeController,
                          //     decoration: InputDecoration(
                          //       hintText: 'Выберите время',
                          //       suffixIcon: Icon(Icons.access_time_outlined, color: ThemeColors.base300, size: 22.r),
                          //     ),
                          //   ),
                          // ),
                          10.height,
                        ] else if (state is RegisterSuccess) ...[
                          // 20.height,
                          Text(
                            'Готово, ${nameController.text}! Вы сделали первый шаг ✅',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.baseBlack,
                            ),
                          ),
                          10.height,
                          Text(
                            'Мы с нетерпением ждем Вас на бесплатный комплексный анализ состава тела и консультацию!',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                          ),
                          30.height,
                          Container(
                            padding: EdgeInsets.all(15.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: ThemeColors.base200),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Детали вашей записи',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.baseBlack,
                                  ),
                                ),
                                10.height,
                                Text(
                                  'Вся информация о вашей предстоящей записи',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors.base400,
                                  ),
                                ),
                                20.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Фамилия',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    Text(
                                      nameController.text,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.baseBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Клуб',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    30.width,
                                    Expanded(
                                      child: Text(
                                        selectedClubNotifier.value?.address ?? '',
                                        maxLines: 2,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors.baseBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Дата',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    Text(
                                      dateController.text,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.baseBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 40.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Время',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.base400,
                                      ),
                                    ),
                                    Text(
                                      selectedTime.value ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.baseBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // 20.height,
                          // MessageItem(
                          //   text:
                          //       'Не волнуйтесь насчет специальной одежды или подготовки. Просто приходите. У нас уютная студия, где все внимание специалист уделит только вам. До встречи! 😊',
                          //   boxColor: Color(0xff70C5C7),
                          // ),
                          // ]
                          // else if (state is RegisterError) ...[
                          //   (1.sh / 3).toInt().height,
                          //   Center(
                          //     child: Text(
                          //       'Что то пошло не так',
                          //       style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                          //     ),
                          //   ),
                        ],
                        SizedBox(height: (kBottomNavigationBarHeight + 20.h)),
                      ],
                    ),
                  ),
                  // if (state is! RegisterInitial)
                  //   Positioned(left: 0, bottom: 0, child: SizedBox(height: 200, child: Image.asset(AppAssets.mila))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConcernItem {
  final String title;
  final String subtitle;

  ConcernItem({required this.title, required this.subtitle});
}

class BodyDetail extends StatelessWidget {
  final String text;
  final bool isYellow;

  const BodyDetail({super.key, required this.text, this.isYellow = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isYellow ? ThemeColors.statusYellow : Color(0xff36b4ae).withValues(alpha: 0.8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isYellow ? Colors.black : Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final String text;
  final String? second;
  final bool fromUser;
  final Color? boxColor;
  final Color? textColor;

  const MessageItem({super.key, required this.text, this.fromUser = false, this.boxColor, this.textColor, this.second});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: boxColor ?? Color(0xff36b4ae)),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(color: textColor ?? Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              if (second != null) ...[
                20.height,
                Center(
                  child: Text(
                    second ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (fromUser)
          Positioned(
            bottom: -1,
            right: -1,
            child: SvgPicture.asset(
              AppAssets.messageVector,
              colorFilter: ColorFilter.mode(boxColor ?? Color(0xff36b4ae), BlendMode.srcIn),
            ),
          )
        else
          Positioned(
            bottom: -1,
            left: -1,
            child: SvgPicture.asset(
              AppAssets.message,
              colorFilter: ColorFilter.mode(boxColor ?? Color(0xff36b4ae), BlendMode.srcIn),
            ),
          ),
      ],
    );
  }
}
