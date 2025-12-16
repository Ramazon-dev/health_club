import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/extensions/date_format.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final phoneFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Личные данные',
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
              Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xffe7e7e7),
                  radius: 50.r,
                  child: Icon(Icons.add_photo_alternate_outlined, size: 40.r, color: Color(0xffa4a4a4)),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Добавить фото профиля',
                  style: TextStyle(color: Color(0xffB0B0B0), fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Имя',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: firstnameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Введите ваше имя'),
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
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: lastnameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Введите вашу фамилию'),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'context.lang.phoneNumberCanNotBeEmpty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Дата рождения',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final date = await
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: now.subtract(Duration(days: 4380)),
                    initialDate: DateTime(2000, now.month, now.day),
                  );
                  if (date != null) {
                    dateOfBirthController.text = date.dateFormat();
                  }

                },
                child: TextFormField(
                  controller: dateOfBirthController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'ДД.ММ.ГГГГ'),
                  enabled: false,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Электронная почта',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'example@mail.com'),
              ),
              SizedBox(height: 15),
              Text(
                'Номер телефона',
                style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
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
              SizedBox(height: 135),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonWithScale(
          // isLoading: isLoading,
          // onPressed: () {},
          onPressed: () {
            context.router.maybePop();
          },
          text: 'Сохранить изменения',
        ),
      ),
    );
  }
}
