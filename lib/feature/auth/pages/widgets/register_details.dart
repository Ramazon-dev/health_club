import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../design_system/design_system.dart';
import '../../../../router/app_router.gr.dart';

class RegisterDetails extends StatefulWidget {
  const RegisterDetails({super.key});

  @override
  State<RegisterDetails> createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  final phoneFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final checkboxNotifier = ValueNotifier<bool>(false);
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: Text(
          'Регистрация',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Text(
                'Создайте свой аккаунт',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'Заполните данные, чтобы продолжить',
                style: TextStyle(color: Color(0xffa4a4a4), fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 40),
              Text(
                'Имя',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: firstnameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Введите ваше имя',
                ),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'context.lang.phoneNumberCanNotBeEmpty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Фамилия',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: lastnameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Введите вашу фамилию',
                ),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'context.lang.phoneNumberCanNotBeEmpty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Номер телефона',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: phoneNumberController,
                inputFormatters: [phoneFormatter],
                keyboardType: TextInputType.phone,
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
              SizedBox(height: 15),
              Text(
                'Электронная почта (не обязательно)',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'example@mail.com',
                ),
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
              SizedBox(height: 135),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: checkboxNotifier,
        builder: (context, isAgree, child) => Padding(
          padding: const EdgeInsets.all(15),
          child: ButtonWithScale(
            // isLoading: isLoading,
            // onPressed: () {},
            onPressed: isAgree
                ? () {
              final validator = globalKey.currentState?.validate();
              if (validator == true && phoneNumberController.text.length == 12) {
                context.router.push(GenderRoute());
              }
            }
                : null,
            text: 'Продолжить',
          ),
        ),
      ),
    );
  }
}
