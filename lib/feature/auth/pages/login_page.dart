import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final phoneNumberController = TextEditingController();
  final checkboxNotifier = ValueNotifier<bool>(false);
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        print('object login listener $state');
        if (state is LoginSuccess) {
          // context.showSnackBar(state.verifyCode, backgroundColor: ThemeColors.primaryColor);
          context.router.push(PinPutRoute(phoneNumber: '+998 ${phoneNumberController.text}'));
        } else if (state is LoginError) {
          context.showSnackBar(state.message ?? 'error');
        }
      },
      builder: (context, state) => Scaffold(
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
                SizedBox(height: 35),
                Text(
                  'Номер телефона',
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  'Введите свой номер телефона — мы отправим СМС с кодом подтверждения',
                  style: TextStyle(color: Color(0xffa4a4a4), fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40),
                Text(
                  'Номер телефона',
                  style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: phoneNumberController,
                  inputFormatters: [phoneFormatter],
                  keyboardType: TextInputType.phone,
                  // было number
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefix: Text('+998 ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  validator: (value) {
                    final digits = phoneFormatter.getUnmaskedText();
                    if (digits.isEmpty) {
                      return 'context.lang.phoneNumberCanNotBeEmpty';
                    }
                    if (digits.length != 9) {
                      return 'context.lang.enterYourPhone(9)';
                    }
                    return null;
                  },
                ),
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
                      // onPressed: () {},
                      onPressed: isAgree
                          ? () async {
                              final validator = globalKey.currentState?.validate();
                              if (validator == true && phoneNumberController.text.length == 12) {
                                print('object phone number is +998${phoneNumberController.text.replaceAll(' ', '')}');
                                await context.read<LoginCubit>().login('+998${phoneNumberController.text.replaceAll(' ', '')}');
                                // context.router.push(PinPutRoute(phoneNumber: phoneNumber, verificationId: verificationId))
                                // GoogleSignUpConfigure.sendPhone(context, '+998${phoneNumberController.text.replaceAll(' ', '')}');
                              }
                            }
                          : null,
                      text: 'Отправить код',
                    ),
                  ),
                ),
                20.height,
                // Row(
                //   children: [
                //     const Expanded(child: Divider(thickness: 0.5, color: ThemeColors.primaryColor)),
                //     SizedBox(width: 10.r),
                //     Text('или'),
                //     SizedBox(width: 10.r),
                //     const Expanded(child: Divider(thickness: 0.5, color: ThemeColors.primaryColor)),
                //   ],
                // ),
                // 20.height,
                // SecondaryButton(
                //   onPressed: () async {
                //     // final google = await GoogleSignUpConfigure.googleSignUp(context);
                //     // print('object google sign in ${google?.email}');
                //     context.router.push(MainWrapper());
                //   },
                //   text: 'Войти',
                //   // icon: SvgPicture.asset(AppAssets.google),
                // ),
                // if (Platform.isIOS) ...[
                //   20.height,
                //   SecondaryButton.icon(
                //     onPressed: () async {
                //       // final apple = await GoogleSignUpConfigure.signInWithApple();
                //       // print('object apple sign in ${apple?.email}');
                //       context.router.push(RegisterRoute());
                //     },
                //     text: 'Войти через Apple ID',
                //     icon: SvgPicture.asset(AppAssets.apple),
                //   ),
                // ],
              ],
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: ,
      ),
    );
  }
}
