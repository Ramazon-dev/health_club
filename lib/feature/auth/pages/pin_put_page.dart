import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/domain/core/services/google_sign_up_configure.dart';
import 'package:health_club/feature/auth/widgets/count_down_timer.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:pinput/pinput.dart';

import '../../../design_system/design_system.dart';

@RoutePage()
class PinPutPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const PinPutPage({super.key, required this.phoneNumber, required this.verificationId});

  @override
  State<PinPutPage> createState() => _PinPutPageState();
}

class _PinPutPageState extends State<PinPutPage> {
  final loadingNotifier = ValueNotifier<bool>(false);
  final controller = TextEditingController();
  final timerController = ResendTimerController(initialSeconds: 60);
  final enableNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'Код подтверждения',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Text(
              'Код подтверждения',
              style: TextStyle(color: ThemeColors.baseBlack, fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Мы отправили 4-значный СМС код на номер ${widget.phoneNumber}',
              style: TextStyle(color: ThemeColors.base400, fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 40),
            Pinput(
              autofocus: true,
              controller: controller,
              onChanged: (value) {
                if (value.length == 4) {
                  FocusScope.of(context).unfocus();
                  enableNotifier.value = true;

                  return;
                }

                enableNotifier.value = false;
              },
              onCompleted: (value) {},
              length: 4,
              submittedPinTheme: PinTheme(
                width: 82,
                height: 90,
                textStyle: TextStyle(color: ThemeColors.baseBlack, fontWeight: FontWeight.w500, fontSize: 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff11d564)),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 82,
                height: 90,
                textStyle: TextStyle(color: ThemeColors.baseBlack, fontWeight: FontWeight.w500, fontSize: 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ThemeColors.base400),
                ),
              ),
              errorPinTheme: PinTheme(
                width: 82,
                height: 90,
                textStyle: TextStyle(color: ThemeColors.baseBlack, fontWeight: FontWeight.w500, fontSize: 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ThemeColors.errorColor),
                ),
              ),
              defaultPinTheme: PinTheme(
                width: 82,
                height: 90,
                textStyle: TextStyle(color: ThemeColors.baseBlack, fontWeight: FontWeight.w500, fontSize: 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ThemeColors.inputBorderColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ResendCodeTimer(
                controller: timerController,
                onTap: () {
                  // timerController.start();
                  // final lang = Localizations.localeOf(context).languageCode;
                  // context.read<AuthBloc>().add(
                  //   SendOtpEvent(
                  //     phone: widget.phone,
                  //     lang: lang,
                  //     genericError: context.lang!.genericError,
                  //     noInternetError: context.lang!.noInternetError,
                  //     unexpectedError: context.lang!.unexpectedError,
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, isLoading, child) => ValueListenableBuilder(
            valueListenable: enableNotifier,
            builder: (context, isEnable, child) => ButtonWithScale(
              isLoading: isLoading,
              onPressed: isEnable
                  ? () async {
                      timerController.stop();
                      // loadingNotifier.value = true;

                      final cred = await GoogleSignUpConfigure.verifyCode(
                        widget.verificationId,
                        '111111',
                      );
                      print('object cred phone is ${cred?.user?.phoneNumber}');
                      print('object cred uid is ${cred?.user?.uid}');
                      context.router.push(RegisterRoute());
                      // context.router.push(MainWrapper());
                    }
                  : null,
              text: 'Подтвердить',
            ),
          ),
        ),
      ),
    );
  }
}
