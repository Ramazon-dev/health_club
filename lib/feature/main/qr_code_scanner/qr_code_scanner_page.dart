import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  final MobileScannerController controller = MobileScannerController(autoZoom: true, cameraResolution: Size(250, 250));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> checkQr(String code) async {
    await context.read<CheckQrCubit>().checkQrCode(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: controller,
              onDetect: (barcodes) async {
                print('object barcode ${barcodes.barcodes.first.displayValue}');
                final code = barcodes.barcodes.first.displayValue;
                if (code != null) {
                  controller.stop();
                  context.router.maybePop();
                  await checkQr(code);
                }
              },
            ),
          ),
          Positioned(
            bottom: 90.h,
            child: GestureDetector(
              onTap: () {
                // context.router.popAndPush(RatingRoute());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 64.r,
                    height: 64.r,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(color: Colors.white10),
                    child: Icon(Icons.flashlight_on),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(color: Colors.white10),
                  child: Text(
                    'Отсканируйте QR code',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
