import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../data/storage/app_storage.dart';
import '../../../design_system/design_system.dart';
import '../../../di/init.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneFormatterUz = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final phoneFormatterKz = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final checkboxNotifier = ValueNotifier<bool>(false);
  final selectedSmsMethodNotifier = ValueNotifier<bool>(true);
  final passwordVisibleNotifier = ValueNotifier<bool>(true);
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // context.showSnackBar(state.verifyCode, backgroundColor: ThemeColors.primaryColor);
          context.router.push(PinPutRoute(phoneNumber: '${loginCubit.phonePrefix}${phoneNumberController.text}'));
        } else if (state is LoginWithPasswordSuccess) {
          getIt<AppStorage>().setRegister(true);
          context.router.pushAndPopUntil(MainWrapper(), predicate: (route) => false);
        } else if (state is LoginError) {
          context.showSnackBar(state.message ?? 'error');
        }
      },
      builder: (context, state) => ValueListenableBuilder(
        valueListenable: selectedSmsMethodNotifier,
        builder: (context, selectedSms, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppbarWidget(
            title: Text(
              'Вход в профиль',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            showDivider: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(15.r),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 35),
                  // Text(
                  //   'Номер телефона',
                  //   style: TextStyle(color: ThemeColors.baseBlack, fontSize: 30, fontWeight: FontWeight.w500),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   'Введите свой номер телефона — мы отправим СМС с кодом подтверждения',
                  //   style: TextStyle(color: Color(0xffa4a4a4), fontSize: 18, fontWeight: FontWeight.w400),
                  // ),
                  40.height,
                  Center(child: Image.asset('assets/images/logo.png', height: 80, width: 130)),
                  40.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          selectedSmsMethodNotifier.value = true;
                        },
                        child: Container(
                          height: 50.h,
                          width: 0.43.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: selectedSms ? ThemeColors.greenColor : ThemeColors.inputBorderColor,
                              width: 2,
                            ),
                            color: selectedSms ? Colors.green.shade50 : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'SMS код',
                            style: TextStyle(
                              color: ThemeColors.baseBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedSmsMethodNotifier.value = false;
                        },
                        child: Container(
                          height: 50.h,
                          width: 0.43.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: !selectedSms ? ThemeColors.greenColor : ThemeColors.inputBorderColor,
                              width: 2,
                            ),
                            color: !selectedSms ? Colors.green.shade50 : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Пароль',
                            style: TextStyle(
                              color: ThemeColors.baseBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Номер телефона',
                    style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: phoneNumberController,
                    inputFormatters: [if (loginCubit.selectedCountryUz) phoneFormatterUz else phoneFormatterKz],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefix: Text(loginCubit.phonePrefix, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    ),
                    validator: (value) {
                      final digits = loginCubit.selectedCountryUz
                          ? phoneFormatterUz.getUnmaskedText()
                          : phoneFormatterKz.getUnmaskedText();
                      if (digits.isEmpty) {
                        return 'Введите номер телефона';
                      }
                      if (loginCubit.selectedCountryUz) {
                        if (digits.length != 9) {
                          return 'Не правильный формат';
                        }
                      } else {
                        if (digits.length != 10) {
                          return 'Не правильный формат';
                        }
                      }
                      return null;
                    },
                  ),
                  if (!selectedSms) ...[
                    SizedBox(height: 20.h),
                    Text(
                      'Пароль',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 5),
                    ValueListenableBuilder(
                      valueListenable: passwordVisibleNotifier,
                      builder: (context, passwordVisible, child) => TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordVisible,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Введите пароль',
                          suffixIcon: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              passwordVisibleNotifier.value = !passwordVisible;
                            },
                            child: passwordVisible
                                ? Icon(Icons.visibility_outlined, color: ThemeColors.inputBorderColor)
                                : Icon(Icons.visibility_off_outlined, color: ThemeColors.inputBorderColor),
                          ),
                        ),
                        validator: (value) {
                          if ((value?.length ?? 0) < 6) {
                            return 'Пароль не может содержать меньше 6 символов';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                  SizedBox(height: 25),
                  ValueListenableBuilder(
                    valueListenable: checkboxNotifier,
                    builder: (context, checkbox, child) => CheckboxListTile(
                      value: checkbox,
                      dense: true,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(width: 1, color: ThemeColors.inputBorderColor),
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.comfortable,
                      onChanged: (value) {
                        checkboxNotifier.value = !checkbox;
                      },
                      title: Text.rich(
                        TextSpan(
                          text:
                              'Я предоставляю согласие на обработку персональных данных, а также подтверждаю ознакомление и согласие c ',
                          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 8.sp, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Политикой конфиденциальности и Пользовательским соглашением',
                              style: TextStyle(color: Color(0xff737373), fontSize: 8.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  30.height,
                  ValueListenableBuilder(
                    valueListenable: checkboxNotifier,
                    builder: (context, isAgree, child) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: ButtonWithScale(
                        isLoading: state is LoginLoading,
                        onPressed: isAgree
                            ? () async {
                                if (selectedSms) {
                                  final validator = globalKey.currentState?.validate();
                                  if (validator == true && phoneNumberController.text.length == 12) {
                                    await loginCubit.login(
                                      '${loginCubit.phonePrefix}${phoneNumberController.text}'.replaceAll(' ', ''),
                                    );
                                  }
                                } else {
                                  final validator = globalKey.currentState?.validate();
                                  if (validator == true) {
                                    await loginCubit.loginWithPassword(
                                      '${loginCubit.phonePrefix}${phoneNumberController.text}'.replaceAll(' ', ''),
                                      passwordController.text,
                                    );
                                  }
                                }
                              }
                            : null,
                        text: 'Зайти',
                      ),
                    ),
                  ),
                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
