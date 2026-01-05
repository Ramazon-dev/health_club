import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../data/network/model/profile_response.dart';

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
  final ValueNotifier<File?> imageNotifier = ValueNotifier(null);

  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);

  @override
  void initState() {
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded) {
      initializeProfile(state.profile);
    }
    super.initState();
  }

  void initializeProfile(ProfileResponse profile) {
    firstnameController.text = profile.name ?? '';
    lastnameController.text = profile.surname ?? '';
    phone(profile.phone ?? '');
    emailController.text = profile.email ?? '';
    dateOfBirthController.text = profile.birthday ?? '';
  }

  void phone(String number) {
    if (number.isNotEmpty) {
      phoneNumberController.text = phoneFormatter.maskText(number.replaceAll('+998', ''));
    }
  }

  void uploadProfile() {
    final validate = globalKey.currentState?.validate();
    if (validate == false) return;
    loadingNotifier.value = true;
    // final file = FormData(imageNotifier.value);
    context.read<ProfileCubit>().updateProfile(
      name: firstnameController.text,
      surname: lastnameController.text,
      phone: '+998${phoneNumberController.text.replaceAll(' ', '')}',
      birthday: dateOfBirthController.text,
      email: emailController.text,
      file: imageNotifier.value,
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final img = File(image.path);
        // final img = await compress(await image.readAsBytes(), image.path);
        // final list = List<File?>.from(imageNotifier.value)
        //   ..insert(index, img)
        //   ..removeLast();
        // imageNotifier.value = list;
        return img;
      }
      return null;
    } catch (e) {
      debugPrint('object something went wrong catch $e');
      return null;
    }
  }

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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) async {
          if (state is ProfileLoaded) {
            final router = context.router;
            await CustomSneakBar.show(context: context, status: SneakBarStatus.success, title: 'Успешно');
            initializeProfile(state.profile);
            loadingNotifier.value = false;
            router.maybePop();
          } else if (state is ProfileError) {
            loadingNotifier.value = false;
            await CustomSneakBar.show(context: context, status: SneakBarStatus.error, title: state.message ?? '');
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message ?? ''));
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: imageNotifier,
                      builder: (context, image, child) => GestureDetector(
                        onTap: () async {
                          final image = await _pickImage(ImageSource.gallery);
                          if (image != null) {
                            imageNotifier.value = image;
                          }
                        },
                        child: image != null
                            ? Center(
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffe7e7e7),
                                  radius: 50.r,
                                  backgroundImage: FileImage(image),
                                ),
                              )
                            : Center(
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffe7e7e7),
                                  radius: 50.r,
                                  child: Icon(Icons.add_photo_alternate_outlined, size: 40.r, color: Color(0xffa4a4a4)),
                                ),
                              ),
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
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: now.subtract(Duration(days: 4380)),
                          initialDate: DateTime(2000, now.month, now.day),
                        );
                        if (date != null) {
                          dateOfBirthController.text = date.dateForRequest();
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
                        if (value?.isEmpty == true) {
                          return 'context.lang.phoneNumberCanNotBeEmpty';
                        }
                        if (value?.length != 12) {
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
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, isLoading, child) => ButtonWithScale(
            isLoading: isLoading,
            onPressed: () {
              uploadProfile();
            },
            text: 'Сохранить изменения',
          ),
        ),
      ),
    );
  }
}
