import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/extensions/dialog_ext.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/storage/app_storage.dart';
import '../../../../design_system/design_system.dart';
import '../../../../di/init.dart';
import '../widgets/profile_button.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    profileCubit = context.read<ProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Настройки',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String phone = '';
          if (state is ProfileLoaded) {
            phone = state.profile.phone ?? '';
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                10.height,
                ProfileButton(
                  title: 'Изменить профиль',
                  icon: AppAssets.edit,
                  onPressed: () {
                    context.router.push(EditProfileRoute());
                  },
                ),
                5.height,
                ProfileButton(
                  title: 'Изменить пароль',
                  icon: AppAssets.passwordBold,
                  onPressed: () {
                    context.router.push(ChangePasswordRoute());
                  },
                ),
                // 5.height,
                // ProfileButton(
                //   title: 'История платежей',
                //   icon: AppAssets.calendarMonth,
                //   onPressed: () {
                //     context.router.push(PaymentHistoryRoute());
                //   },
                // ),
                5.height,
                ProfileButton(
                  title: 'Заморозки',
                  icon: AppAssets.snow,
                  onPressed: () {
                    context.router.push(FreezeHistoryRoute());
                  },
                ),
                // 5.height,
                // ProfileButton(
                //   title: 'История договоров',
                //   icon: AppAssets.file,
                //   onPressed: () {
                //     context.router.push(ContractHistoryRoute());
                //   },
                // ),
                5.height,
                ProfileButton(
                  title: 'История состава тела',
                  icon: AppAssets.bodyHuman,
                  onPressed: () {
                    context.router.push(BodyHistoryRoute());
                  },
                ),
                5.height,
                ProfileButton(
                  title: 'История тренировок',
                  icon: AppAssets.training,
                  onPressed: () {
                    context.router.push(TrainingHistoryRoute());
                  },
                ),
                5.height,
                ProfileButton(
                  title: 'Политика конфиденциальности',
                  icon: AppAssets.question,
                  onPressed: () {
                    // UrlLauncherService.sentUserByLink('https://plus360.app/privacy-policy-ru');
                    context.router.push(PrivacyPolicyRoute());
                  },
                ),
                5.height,
                ProfileButton(
                  title: 'Публичная оферта',
                  icon: AppAssets.question,
                  onPressed: () {
                    // UrlLauncherService.sentUserByLink('https://plus360.app/privacy-policy-ru');
                    context.router.push(PublicOfferRoute());
                  },
                ),
                20.height,
                // Spacer(),
                SecondaryButton(
                  onPressed: () {
                    final router = context.router;
                    final appStorage = getIt<AppStorage>();
                    context.dialogWithSubtitle(
                      title: 'Выходить из профилья',
                      subtitle: 'Вы действительно хотите выходить из профилья',
                      onCancelled: () => Navigator.maybePop(context),
                      onConfirm: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Form(
                            key: formKey,
                            child: Container(
                              height: 0.7.sh,
                              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 5.r,
                                      width: 60.r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: ThemeColors.black100,
                                      ),
                                    ),
                                  ),
                                  20.height,
                                  Text(
                                    'Введите номер телефона что бы подтвердить выход из аккаунта',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeColors.baseBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  20.height,
                                  TextFormField(
                                    autofocus: true,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      if (profileCubit.selectedCountryUz) phoneFormatterUz else phoneFormatterKz,
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Введите номер';
                                      final number = "${profileCubit.phonePrefix}$value"
                                          .replaceAll(' ', '')
                                          .replaceAll('.', '')
                                          .replaceAll(',', '');
                                      print('object phone number ${number != phone} $phone and $number');

                                      if (number != phone) {
                                        return 'Номер не совподает с вашим номером';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefix: Text(
                                        profileCubit.phonePrefix,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                      hintText: 'Номер телефона',
                                    ),
                                  ),
                                  Spacer(),
                                  ButtonWithScale(
                                    onPressed: () async {
                                      final validate = formKey.currentState?.validate() ?? false;
                                      if (validate) {
                                        await appStorage.removeAuthentication();
                                        router.pushAndPopUntil(AuthWrapper(), predicate: (route) => false);
                                      }
                                    },
                                    text: 'Подтвердить',
                                  ),
                                  20.height,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Выход',
                ),
                20.height,
                SecondaryButton(
                  onPressed: () {
                    final router = context.router;
                    final appStorage = getIt<AppStorage>();
                    context.dialogWithSubtitle(
                      title: 'Удалить профиль',
                      subtitle: 'Вы действительно хотите удалить профиль',
                      onCancelled: () => Navigator.maybePop(context),
                      onConfirm: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Form(
                            key: formKey,
                            child: Container(
                              height: 0.7.sh,
                              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 5.r,
                                      width: 60.r,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: ThemeColors.black100,
                                      ),
                                    ),
                                  ),
                                  20.height,
                                  Text(
                                    'Введите номер телефона что бы подтвердить удалить аккаунт',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeColors.baseBlack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  40.height,
                                  TextFormField(
                                    autofocus: true,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      if (profileCubit.selectedCountryUz) phoneFormatterUz else phoneFormatterKz,
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Введите номер';
                                      final number = "${profileCubit.phonePrefix}$value"
                                          .replaceAll(' ', '')
                                          .replaceAll('.', '')
                                          .replaceAll(',', '');
                                      print('object phone number ${number != phone} $phone and $number');

                                      if (number != phone) {
                                        return 'Номер не совподает с вашим номером';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefix: Text(
                                        profileCubit.phonePrefix,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                      hintText: 'Номер телефона',
                                    ),
                                  ),
                                  // 200.height,
                                  Spacer(),
                                  ButtonWithScale(
                                    // isLoading: isLoading,
                                    onPressed: () async {
                                      final validate = formKey.currentState?.validate();
                                      print('object validate $validate');
                                      if (validate == true) {
                                        await appStorage.removeAuthentication();
                                        router.pushAndPopUntil(AuthWrapper(), predicate: (route) => false);
                                      }
                                    },
                                    text: 'Подтвердить',
                                  ),
                                  40.height,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Удалить аккаунт',
                ),
                20.height,
              ],
            ),
          );
        },
      ),
    );
  }
}
