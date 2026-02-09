import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../design_system/design_system.dart';
import '../../../../domain/core/core.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordVisibleNotifier = ValueNotifier<bool>(true);
  final repeatPasswordVisibleNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Изменить пароль',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) async {
          if (state is ChangePasswordLoaded) {
            final router = context.router;
            await CustomSneakBar.show(
              context: context,
              status: SneakBarStatus.success,
              title: 'Пароль успешно изменен',
            );
            router.maybePop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15.r),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (kBottomNavigationBarHeight).height,
                  Text(
                    'Новый пароль',
                    style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  5.height,
                  ValueListenableBuilder(
                    valueListenable: passwordVisibleNotifier,
                    builder: (context, passwordVisible, child) => TextFormField(
                      autofocus: true,
                      controller: passwordController,
                      obscureText: passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Введите новый пароль',
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
                        if (value == null || value.isEmpty) return 'Пароль не может быть пустым';
                        if (value.length < 8) return 'Пожалуйста, увеличьте длину этого текста до 8 символов или более';
                        if (value != repeatPasswordController.text) return 'Пароли не совпадают';
                        return null;
                      },
                    ),
                  ),
                  15.height,
                  Text(
                    'Подтвеждение пароля',
                    style: TextStyle(color: ThemeColors.baseBlack, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  5.height,
                  ValueListenableBuilder(
                    valueListenable: repeatPasswordVisibleNotifier,
                    builder: (context, passwordVisible, child) => TextFormField(
                      autofocus: true,
                      controller: repeatPasswordController,
                      obscureText: passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Повторите пароль',
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            repeatPasswordVisibleNotifier.value = !passwordVisible;
                          },
                          child: passwordVisible
                              ? Icon(Icons.visibility_outlined, color: ThemeColors.inputBorderColor)
                              : Icon(Icons.visibility_off_outlined, color: ThemeColors.inputBorderColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Пароль не может быть пустым';
                        if (value.length < 8) return 'Пожалуйста, увеличьте длину этого текста до 8 символов или более';
                        if (value != passwordController.text) return 'Пароли не совпадают';
                        return null;
                      },
                    ),
                  ),
                  20.height,
                  ButtonWithScale(
                    isLoading: state is ChangePasswordLoading,
                    onPressed: () {
                      final validate = formKey.currentState?.validate() ?? false;
                      if (validate) {
                        context.read<ChangePasswordCubit>().changePassword(
                          passwordController.text,
                          repeatPasswordController.text,
                        );
                      }
                    },
                    text: 'Сохранить изменения',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
