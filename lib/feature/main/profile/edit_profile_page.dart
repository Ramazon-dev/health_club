import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/design_system/widgets/network_image.dart';
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
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final ValueNotifier<File?> imageNotifier = ValueNotifier(null);
  final ValueNotifier<String?> networkImageNotifier = ValueNotifier(null);

  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    profileCubit = context.read<ProfileCubit>();
    final state = profileCubit.state;
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
    networkImageNotifier.value = profile.avatar;
  }

  void phone(String number) {
    if (number.isNotEmpty) {
      phoneNumberController.text = profileCubit.selectedCountryUz
          ? phoneFormatterUz.maskText(number.replaceAll(profileCubit.phonePrefix.replaceAll(' ', ''), ''))
          : phoneFormatterKz.maskText(number.replaceAll(profileCubit.phonePrefix.replaceAll(' ', ''), ''));
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
      phone: '${profileCubit.phonePrefix}${phoneNumberController.text}'.replaceAll(' ', ''),
      birthday: dateOfBirthController.text,
      email: emailController.text,
      file: imageNotifier.value,
    );
  }

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
                      builder: (context, image, child) => ValueListenableBuilder(
                        valueListenable: networkImageNotifier,
                        builder: (context, networkImage, child) => GestureDetector(
                          onTap: () async {
                            final image = await _pickImage(ImageSource.gallery);
                            if (image != null) {
                              imageNotifier.value = image;
                            }
                          },
                          child: networkImage != null
                              ? Center(
                                  child: AppNetworkImage(
                                    imageUrl: networkImage,
                                    height: 100.r,
                                    width: 100.r,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                )
                              : image != null
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
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 40.r,
                                      color: Color(0xffa4a4a4),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    10.height,
                    Center(
                      child: Text(
                        'Добавить фото профиля',
                        style: TextStyle(color: Color(0xffB0B0B0), fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    // 10.height,
                    // ValueListenableBuilder(
                    //   valueListenable: imageNotifier,
                    //   builder: (context, image, child) => Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       ButtonWithScale(
                    //         text: 'Загрузить Фото',
                    //         onPressed: () {},
                    //         verticalPadding: 10.h,
                    //         horizontalPadding: 20.r,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    30.height,
                    Text(
                      'Имя',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    5.height,
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
                    15.height,
                    Text(
                      'Фамилия',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    5.height,
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
                    15.height,
                    Text(
                      'Дата рождения',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    5.height,
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
                    15.height,
                    Text(
                      'Электронная почта',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    5.height,
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'example@mail.com'),
                    ),
                    15.height,
                    Text(
                      'Номер телефона',
                      style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    5.height,
                    TextFormField(
                      controller: phoneNumberController,
                      inputFormatters: [if (profileCubit.selectedCountryUz) phoneFormatterUz else phoneFormatterKz],
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefix: Text('+998 ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Введите номер телефона';
                        final digits = profileCubit.selectedCountryUz
                            ? phoneFormatterUz.maskText(value).replaceAll(' ', '')
                            : phoneFormatterKz.maskText(value).replaceAll(' ', '');
                        print('object digits $digits');
                        if (digits.isEmpty) {
                          return 'Введите номер телефона';
                        }
                        if (profileCubit.selectedCountryUz) {
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
                    // 30.height,
                    // ValueListenableBuilder(
                    //   valueListenable: loadingNotifier,
                    //   builder: (context, isLoading, child) => ButtonWithScale(
                    //     isLoading: isLoading,
                    //     onPressed: () {
                    //       uploadProfile();
                    //     },
                    //     text: 'Сохранить изменения',
                    //   ),
                    // ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, isLoading, child) => ValueListenableBuilder(
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
      ),
    );
  }
}
