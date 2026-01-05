import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/feature/auth/pages/widgets/list_item.dart';
import 'package:health_club/router/app_router.gr.dart';
import '../../../data/network/model/clubs_response.dart';
import '../../../data/network/model/auth/wizard_options_response.dart';
import '../../../design_system/design_system.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  final int step;

  const RegisterPage({super.key, required this.step});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   // return MultiBlocProvider(
  //   //   providers: [BlocProvider(create: (context) => getIt<RegisterCubit>())],
  //   //   child: this,
  //   // );
  // }
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
  final TextEditingController timeController = TextEditingController();

  // List<ConcernItem> listOfConcerns = [
  //   ConcernItem(
  //     title: 'Хроническая боль (спина, суставы)',
  //     subtitle:
  //         'Это чувство знакомо многим. Но главное - вы готовы это изменить! Мы помоем вам не только сбросить вес, но и обрести уверенность.',
  //   ),
  //   ConcernItem(
  //     title: 'Тревога за здоровье (давление, сахар)',
  //     subtitle:
  //         'Это чувство знакомо многим. Но главное - вы готовы это изменить! Мы помоем вам не только сбросить вес, но и обрести уверенность.',
  //   ),
  //   ConcernItem(
  //     title: 'Лишный вес и отражение в зеркале',
  //     subtitle:
  //         'Это чувство знакомо многим. Но главное - вы готовы это изменить! Мы помоем вам не только сбросить вес, но и обрести уверенность.',
  //   ),
  //   ConcernItem(
  //     title: 'Постоянный усталость и чувство разбитости',
  //     subtitle:
  //         'Это чувство знакомо многим. Но главное - вы готовы это изменить! Мы помоем вам не только сбросить вес, но и обрести уверенность.',
  //   ),
  //   ConcernItem(
  //     title: 'Другое',
  //     subtitle:
  //         'Это чувство знакомо многим. Но главное - вы готовы это изменить! Мы помоем вам не только сбросить вес, но и обрести уверенность.',
  //   ),
  // ];

  ValueNotifier<WizardOptionResponse?> selectedConcernNotifier = ValueNotifier(null);

  // List<ConcernItem> listOfProblems = [
  //   ConcernItem(
  //     title: 'Грыжи или протрузии',
  //     subtitle:
  //         'Наши Smart-тренажеры полностью исключают осевую нагрузку, позволяя безопасно укреплять мышечный корсет',
  //   ),
  //   ConcernItem(
  //     title: 'Диабет / Метаболический синдром',
  //     subtitle:
  //         'Наши Smart-тренажеры полностью исключают осевую нагрузку, позволяя безопасно укреплять мышечный корсет',
  //   ),
  //   ConcernItem(
  //     title: 'Гипертония (высокое давление)',
  //     subtitle:
  //         'Наши Smart-тренажеры полностью исключают осевую нагрузку, позволяя безопасно укреплять мышечный корсет',
  //   ),
  //   ConcernItem(
  //     title: 'Ограничения от врачей',
  //     subtitle:
  //         'Наши Smart-тренажеры полностью исключают осевую нагрузку, позволяя безопасно укреплять мышечный корсет',
  //   ),
  //   ConcernItem(
  //     title: 'Другое',
  //     subtitle:
  //         'Наши Smart-тренажеры полностью исключают осевую нагрузку, позволяя безопасно укреплять мышечный корсет',
  //   ),
  // ];

  // List<ConcernItem> listOfTargets = [
  //   ConcernItem(
  //     title: 'Укрепление здоровья',
  //     subtitle:
  //         'Иван, вы хотите снижение веса. Это отличная цель! Но давайте честно: сейчас вы в “Точке А”, где, возможно, чувствуете дискомфорт, усталость и неуверенность. Чтобы прийти в “Точку Б” - к легкости, энергии и гордости за свое отражение в зеркале - нужен точный и безопасный план. И ключ к этому плану - детальная информация о составе вашего тела.',
  //   ),
  //   ConcernItem(
  //     title: 'Снижение веса',
  //     subtitle:
  //         'Иван, вы хотите снижение веса. Это отличная цель! Но давайте честно: сейчас вы в “Точке А”, где, возможно, чувствуете дискомфорт, усталость и неуверенность. Чтобы прийти в “Точку Б” - к легкости, энергии и гордости за свое отражение в зеркале - нужен точный и безопасный план. И ключ к этому плану - детальная информация о составе вашего тела.',
  //   ),
  //   ConcernItem(
  //     title: 'Увеличение мышечной массы',
  //     subtitle:
  //         'Иван, вы хотите снижение веса. Это отличная цель! Но давайте честно: сейчас вы в “Точке А”, где, возможно, чувствуете дискомфорт, усталость и неуверенность. Чтобы прийти в “Точку Б” - к легкости, энергии и гордости за свое отражение в зеркале - нужен точный и безопасный план. И ключ к этому плану - детальная информация о составе вашего тела.',
  //   ),
  //   ConcernItem(
  //     title: 'Другое',
  //     subtitle:
  //         'Иван, вы хотите снижение веса. Это отличная цель! Но давайте честно: сейчас вы в “Точке А”, где, возможно, чувствуете дискомфорт, усталость и неуверенность. Чтобы прийти в “Точку Б” - к легкости, энергии и гордости за свое отражение в зеркале - нужен точный и безопасный план. И ключ к этому плану - детальная информация о составе вашего тела.',
  //   ),
  // ];

  ValueNotifier<WizardOptionResponse?> selectedProblemNotifier = ValueNotifier(null);
  ValueNotifier<WizardOptionResponse?> selectedTargetNotifier = ValueNotifier(null);

  // ValueNotifier<BodyDetails?> selectedBodyDetailNotifier = ValueNotifier(null);
  ValueNotifier<bool?> genderNotifier = ValueNotifier(null);
  ValueNotifier<ClubResponse?> selectedClubNotifier = ValueNotifier(null);

  bool showOtherConcern = false;
  bool showOtherProblem = false;
  bool showOtherTarget = false;

  void changeScroll({double? position}) {
    scrollController.animateTo(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    if (widget.step == 0 || widget.step == 1) {
      // context.read<RegisterCubit>().changeToInitial();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: kToolbarHeight + 10.h,
        leadingWidth: 20.w + 54.h,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).maybePop();
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 16.r, top: 10.h),
              height: 54.h,
              width: 54.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: ThemeColors.base100),
              child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black, size: 18.sp),
            ),
          ),
        ),
        actions: [
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is RegisterDiagnostics ||
                  state is RegisterSuccess ||
                  state is RegisterLoading ||
                  state is RegisterError) {
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
        // title: Text(
        //   'Регистрация',
        //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w500),
        // ),
      ),
      bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          print('object RegisterCubit state changed $state');
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: state is RegisterInitial
                ? ButtonWithScale(
                    onPressed: () {
                      final cubit = context.read<RegisterCubit>();
                      cubit.changeToName();
                    },
                    text: 'Начать диагностику',
                  )
                : ButtonWithScale(
                    // isLoading: state is RegisterLoading,
                    // width: 0.58.sw,
                    // height: 60.h,
                    text: 'Продолжить',
                    onPressed: () {
                      changeScroll();
                      final cubit = context.read<RegisterCubit>();
                      if (state is RegisterInitial) {
                        cubit.changeToName();
                      } else if (state is RegisterName) {
                        cubit.uploadName(nameController.text);
                      } else if (state is RegisterConcerns) {
                        if (selectedConcernNotifier.value != null) {
                          if (!showOtherConcern) {
                            cubit.uploadConcern(selectedConcernNotifier.value?.text ?? '');
                          } else if (showOtherConcern && otherConcernController.text.isNotEmpty) {
                            cubit.uploadConcern(otherConcernController.text);
                          } else if (showOtherConcern && otherConcernController.text.isEmpty) {
                            context.showSnackBar('Введите что вас беспокоит');
                          }
                        } else {
                          context.showSnackBar('Выберите что вас беспокоит');
                        }
                      } else if (state is RegisterProblems) {
                        if (selectedProblemNotifier.value != null) {
                          if (!showOtherProblem) {
                            cubit.uploadProblem(selectedProblemNotifier.value?.text ?? '');
                          } else if (showOtherProblem && otherProblemController.text.isNotEmpty) {
                            cubit.uploadProblem(otherProblemController.text);
                          } else if (showOtherProblem && otherProblemController.text.isEmpty) {
                            context.showSnackBar('Введите какие у вас проблемы');
                          }
                        }
                      } else if (state is RegisterBodyDetails) {
                        if (heightController.text.isEmpty) {
                          context.showSnackBar('Введите свой рост');
                        } else if (widthController.text.isEmpty) {
                          context.showSnackBar('Введите свой вес');
                        } else if (birthController.text.isEmpty) {
                          context.showSnackBar('Введите дата рождения');
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
                        cubit.getTargets();
                      } else if (state is RegisterTarget) {
                        if (selectedTargetNotifier.value != null) {
                          if (!showOtherTarget) {
                            cubit.uploadTarget(selectedTargetNotifier.value?.text ?? '');
                          } else if (showOtherTarget && otherTargetController.text.isNotEmpty) {
                            cubit.uploadTarget(otherTargetController.text);
                          } else if (showOtherTarget && otherTargetController.text.isEmpty) {
                            context.showSnackBar('Введите какие у вас цель');
                          }
                        } else {
                          context.showSnackBar('Выберите цель');
                        }
                      } else if (state is RegisterAddress) {
                        if (addressController.text.isNotEmpty) {
                          cubit.uploadAddress(addressController.text);
                        } else {
                          context.showSnackBar('Введите свой адрес');
                        }
                      } else if (state is RegisterDiagnostics) {
                        if (selectedClubNotifier.value == null) {
                          context.showSnackBar('Выберите клуб');
                        } else if (lastnameController.text.isEmpty) {
                          context.showSnackBar('Введите фамилию');
                        } else if (dateController.text.isEmpty) {
                          context.showSnackBar('Выберите дату');
                        } else if (timeController.text.isEmpty) {
                          context.showSnackBar('Выберите время');
                        } else {
                          cubit.uploadDiagnostic(
                            surname: lastnameController.text,
                            placeId: selectedClubNotifier.value?.id ?? 10,
                            date: dateController.text,
                            time: timeController.text,
                          );
                        }
                      } else if (state is RegisterSuccess) {
                        context.router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
                      }
                    },
                  ),
            // : Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ButtonWithScale(
            //         width: 0.3.sw,
            //         height: 60.h,
            //         color: ThemeColors.base100,
            //         onPressed: () {
            //           changeScroll();
            //           final cubit = context.read<RegisterCubit>();
            //           if (state is RegisterName) {
            //             cubit.changeToInitial();
            //           } else if (state is RegisterConcerns) {
            //             cubit.changeToName();
            //           } else if (state is RegisterProblems) {
            //             cubit.changeToConcerns();
            //           } else if (state is RegisterBodyDetails) {
            //             cubit.changeToProblems();
            //           } else if (state is RegisterBodyDetailsResult) {
            //             cubit.changeToBodyDetails();
            //           } else if (state is RegisterTarget) {
            //             cubit.changeToBodyDetailsResult();
            //           } else if (state is RegisterAddress) {
            //             cubit.changeToTarget();
            //           } else if (state is RegisterDiagnostics) {
            //             cubit.changeToAddress();
            //           } else if (state is RegisterSuccess) {
            //             cubit.changeToDiagnostics();
            //           } else if (state is RegisterError) {
            //             cubit.changeToInitial();
            //           }
            //         },
            //         text: 'Назад',
            //         textStyle: TextStyle(
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.w500,
            //           color: ThemeColors.baseBlack,
            //         ),
            //       ),
            //     ],
            //   ),
          );
        },
      ),

      body: BlocConsumer<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) => current is! RegisterLoading,
        listener: (context, state) {
          if (state is RegisterError) {
            print('object RegisterCubit Error state changed ${state.message}');
          } else if (state is RegisterConcerns) {
            state.options.map((e) {
              if (e.selected == true) {
                selectedConcernNotifier.value = e;
              }
            }).toList();
          } else if (state is RegisterProblems) {
            state.options.map((e) {
              if (e.selected == true) {
                selectedProblemNotifier.value = e;
              }
            }).toList();
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
                    if (state is RegisterInitial) ...[
                      Text(
                        'Фитнес, который не навредит 💚',
                        style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      10.height,
                      Text(
                        'Я помогу подобрать тренировки под твое здоровье',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                      ),
                      30.height,
                      MessageItem(text: 'Привет! Я Мила, твой AI-ассистент 😊'),
                      30.height,
                      Image.asset(AppAssets.mila),
                    ] else if (state is RegisterName) ...[
                      MessageItem(
                        text:
                            'Здраствуйте! Меня зовут Мила, я - ваш личный AI-ассистент в 35-Health Club. Для начала, давайте познакомимся. Как я могу к вам обращаться?',
                      ),
                      20.height,
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ThemeColors.base100,
                          hintText: 'Имя',
                          hintStyle: TextStyle(color: ThemeColors.base500),
                        ),
                      ),
                      20.height,
                    ] else if (state is RegisterConcerns) ...[
                      MessageItem(
                        text:
                            '${nameController.text}, Спасибо за доверие. Я понимаю, что говорить о проблемах бывает нелегко, но это первый и самый важный шаг. Чтобы я могла вам помочь, пожалуйста, отметьте что из этого списка вас беспокоит больше всего?',
                      ),
                      20.height,
                      ValueListenableBuilder(
                        valueListenable: selectedConcernNotifier,
                        builder: (context, selectedCorner, child) => Column(
                          children: [
                            if (selectedCorner != null && selectedCorner.text != 'Другое') ...[
                              MessageItem(text: selectedCorner.answer ?? ''),
                              20.height,
                            ],
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final corner = state.options[index];
                                return GestureDetector(
                                  onTap: () {
                                    selectedConcernNotifier.value = corner;
                                    showOtherConcern = corner.text == 'Другое';
                                    setState(() {});
                                  },
                                  child: ListItem(
                                    title: corner.text ?? '',
                                    selected: selectedCorner?.text == corner.text,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 10.h),
                              itemCount: state.options.length,
                            ),
                          ],
                        ),
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
                            'Спасибо за откровенность. Пожалуйста, укажите, есть ли у вас что-либо из этого списка. Эта информация полностью конфиденциальна и поможет нам подобрать решение, которое будет для вас на 100% безопасным',
                      ),
                      20.height,
                      ValueListenableBuilder(
                        valueListenable: selectedProblemNotifier,
                        builder: (context, selectedProblem, child) => Column(
                          children: [
                            if (selectedProblem != null && selectedProblem.text != 'Другое') ...[
                              MessageItem(text: selectedProblem.answer ?? ''),
                              20.height,
                            ],
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final problem = state.options[index];
                                return GestureDetector(
                                  onTap: () {
                                    selectedProblemNotifier.value = problem;
                                    showOtherProblem = problem.text == 'Другое';
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: selectedProblem?.text == problem.text
                                          ? ThemeColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(color: ThemeColors.inputBorderColor),
                                    ),
                                    child: Text(
                                      problem.text ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: selectedProblem?.text == problem.text ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 10.h),
                              itemCount: state.options.length,
                            ),
                          ],
                        ),
                      ),
                      if (showOtherProblem) ...[
                        20.height,
                        TextFormField(
                          controller: otherProblemController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.base100,
                            hintText: 'Опишите, что вас беспокоит',
                          ),
                        ),
                      ],
                    ] else if (state is RegisterBodyDetails) ...[
                      // 20.height,
                      MessageItem(
                        text:
                            'Отлично, мы почти у цели! Пожалуйста, введите ваши данные. Это поможет мне рассчитать ваш текущий Health-статус и дать более точные, персонализированные рекомендации.',
                      ),
                      20.height,
                      Text(
                        'Рост (СМ)',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
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
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
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
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
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
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: MessageItem(
                          text:
                              '''Рост: ${heightController.text}\nВес: ${widthController.text} кг\nДата рождения: ${birthController.text}\nПол: ${genderNotifier.value == true ? 'Мужчина' : 'Женшина'}''',
                          fromUser: true,
                        ),
                      ),
                      20.height,
                      MessageItem(
                        text:
                            'Спасибо, ${nameController.text}! Ваш Индекс Массы Тела (ИМТ) - 26.6. Но это лишь верхушка айсберга. По-настоящему важно то, что скрыто внутри - состав вашего тела: процент жира, мышечная масса, метаболический возраст. Именно эти данные - ключ к безопасному и эффективному плану.',
                      ),
                      20.height,
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeColors.base200),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.bodyPng),
                            20.width,
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Каков ваш уровень висцерального жира?',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Каков ваш метаболизм?',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Каков ваш метаболический возраст?',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeColors.baseBlack,
                                    ),
                                  ),
                                  10.height,
                                  Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: ThemeColors.primaryColor,
                                    ),
                                    child: Text(
                                      'Все это можно узнать во время бесплатной консультации и получить план тренировоки',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.height,
                      MessageItem(
                        text:
                            'Обычные весы этого не покажут. Нажмите “Продолжить”, и я расскажу, как получить детальный отчет о составе вашего тела и наконец-то достичь цели.',
                      ),
                    ] else if (state is RegisterTarget) ...[
                      // 20.height,
                      MessageItem(
                        text:
                            'Прекрасно! Теперь давайте определимся с главными целями. Что для вас сейчас важнее всего? К чему лежит душа?',
                      ),
                      20.height,
                      ValueListenableBuilder(
                        valueListenable: selectedTargetNotifier,
                        builder: (context, selectedTarget, child) => Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final target = state.options[index];
                                return GestureDetector(
                                  onTap: () {
                                    selectedTargetNotifier.value = target;
                                    showOtherTarget = index == 3;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: selectedTarget?.text == target.text
                                          ? ThemeColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(color: ThemeColors.inputBorderColor),
                                    ),
                                    child: Text(
                                      target.text ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: selectedTarget?.text == target.text ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 10.h),
                              itemCount: state.options.length,
                            ),
                            if (selectedTarget != null && selectedTarget.text != 'Другое') ...[
                              20.height,
                              MessageItem(text: selectedTarget.answer ?? ''),
                            ],
                          ],
                        ),
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
                        text:
                            'Спасибо! И последний вопрос, Иван: чтобы предложить вам ближайший и самый удобный клуб, пожалуйста, укажите ваш адрес.',
                      ),
                      20.height,
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ThemeColors.base100,
                          hintText: 'Например: улица Амира Темура, дом 20',
                        ),
                      ),
                    ] else if (state is RegisterDiagnostics) ...[
                      // 20.height,
                      MessageItem(
                        text:
                            'Остался всего один шаг! Выберите удобный клуб, дату и время для вашей персональной Health-диагностики. Это бесплатно и ни к чему вас не обязывает.',
                      ),
                      20.height,
                      Text(
                        'Запись на диагностику',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      20.height,
                      Text(
                        'Фамилия',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                      ),
                      5.height,
                      TextFormField(
                        controller: lastnameController,
                        decoration: InputDecoration(hintText: 'Введите фамилию'),
                      ),
                      10.height,
                      Text(
                        'Клуб',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                      ),
                      5.height,
                      // TextFormField(
                      //   controller: heightController,
                      //   decoration: InputDecoration(hintText: 'Выберите клуб'),
                      // ),
                      ValueListenableBuilder(
                        valueListenable: selectedClubNotifier,
                        builder: (context, selectedClub, child) => DropdownButtonFormField2(
                          value: selectedClub,
                          enableFeedback: true,
                          isExpanded: true,
                          onChanged: (value) {
                            selectedClubNotifier.value = value;
                          },
                          items: state.clubs
                              .map((e) => DropdownMenuItem(value: e, child: Text(e.title ?? '')))
                              .toList(),
                          // items: [
                          //   DropdownMenuItem(value: 1, child: Text('data1')),
                          //   DropdownMenuItem(value: 2, child: Text('data2')),
                          //   DropdownMenuItem(value: 3, child: Text('data3')),
                          // ],
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down, color: ThemeColors.base400),
                          ),
                          decoration: InputDecoration(
                            // hintText: 'Выберите клуб',
                            // hintStyle: TextStyle(color: ThemeColors.base300, fontSize: 16, fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.all(15.r),
                          ),
                        ),
                      ),
                      10.height,
                      Text(
                        'Дата',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                      ),
                      5.height,

                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 20)),
                          );
                          if (date != null) {
                            dateController.text = date.dateForRequest();
                          }
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
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                      ),
                      5.height,
                      GestureDetector(
                        onTap: () async {
                          final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            timeController.text = time.format(context);
                          }
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: timeController,
                          decoration: InputDecoration(
                            hintText: 'Выберите время',
                            suffixIcon: Icon(Icons.access_time_outlined, color: ThemeColors.base300, size: 22.r),
                          ),
                        ),
                      ),
                      10.height,
                    ] else if (state is RegisterSuccess) ...[
                      // 20.height,
                      Text(
                        'Готово, ${nameController.text}! Вы сделали первый шаг ✅',
                        style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                      ),
                      10.height,
                      Text(
                        'Мы с нетерпением ждем вас на бесплатную Health-диагностику',
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
                                  timeController.text,
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
                      20.height,
                      MessageItem(
                        text:
                            'Не волнуйтесь насчет специальной одежды или подготовки. Просто приходите. У нас уютная студия, где все внимание специалист уделит только вам. До встречи! 😊',
                      ),
                    ] else if (state is RegisterError) ...[
                      (1.sh / 3).toInt().height,
                      Center(
                        child: Text(
                          'Что то пошло не так',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
                        ),
                      ),
                    ],
                    SizedBox(height: 0.5.sh),
                  ],
                ),
              ),
              // if (state is! RegisterInitial)
              //   Positioned(left: 0, bottom: 0, child: SizedBox(height: 200, child: Image.asset(AppAssets.mila))),
            ],
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

class BodyDetails {
  final String height;
  final String width;
  final String birthDate;
  final bool gender;

  BodyDetails({required this.height, required this.width, required this.birthDate, required this.gender});
}

class MessageItem extends StatelessWidget {
  final String text;
  final bool fromUser;

  const MessageItem({super.key, required this.text, this.fromUser = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Color(0xff36b4ae)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        if (fromUser)
          Positioned(bottom: -1, right: -1, child: SvgPicture.asset(AppAssets.messageVector))
        else
          Positioned(bottom: -1, left: -1, child: SvgPicture.asset(AppAssets.message)),
      ],
    );
  }
}
