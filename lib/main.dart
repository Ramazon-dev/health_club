import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:health_club/firebase_options.dart';
import 'package:health_club/router/app_router.dart';
import '../../design_system/design_system.dart';
import 'di/init.dart';
import 'domain/core/alice_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const MyApp());
}
// 49bc56a3-1943-4c80-b687-9e92e5859053
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I.get<AppRouter>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(375, 812),
        child: MaterialApp.router(
          routerConfig: router.config(),
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: ThemeColors.base100,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            inputDecorationTheme:  InputDecorationTheme(
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.all(18),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.errorColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.inputBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.inputBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.inputBorderColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.inputBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: ThemeColors.errorColor),
              ),
              // filled: true,
              isDense: true,
              // fillColor: LightThemeColors.textFieldColor,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(color: ThemeColors.base300, fontSize: 16, fontWeight: FontWeight.w400),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              prefixStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              suffixStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            dividerColor: ThemeColors.base200,
          ),
          builder: (context, child) {
            final aliceFactory = AliceFactory();
            aliceFactory.initializeWithNavigator(router.navigatorKey);
            // GetIt.I.get<Alice>().setNavigatorKey(router.navigatorKey);

            return child ?? SizedBox();
            // return FlavorBanner(
            //   name: 'Beauty Business',
            //   show: false,
            //   child: DraggableAliceButton(
            //     child: child ?? const SizedBox.shrink(),
            //     onPressed: () => aliceFactory.alice.isInspectorOpened
            //         ? aliceFactory.alice.getNavigatorKey()?.currentContext?.maybePop()
            //         : aliceFactory.alice.showInspector(),
            //   ),
            // );

          },
        ),
      ),
    );
  }
}


// --- Draggable Alice button widget ---
class DraggableAliceButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const DraggableAliceButton({super.key, required this.child, required this.onPressed});

  @override
  State<DraggableAliceButton> createState() => _DraggableAliceButtonState();
}

class _DraggableAliceButtonState extends State<DraggableAliceButton> {
  double top = 100;
  double right = 20;
  double? startDy;
  double? startDx;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          top: top,
          right: right,
          child: GestureDetector(
            onPanStart: (details) {
              startDy = details.globalPosition.dy;
              startDx = details.globalPosition.dx;
            },
            onPanUpdate: (details) {
              setState(() {
                // Вычисляем смещение
                double dy = details.globalPosition.dy - (startDy ?? 0);
                double dx = details.globalPosition.dx - (startDx ?? 0);
                top += dy;
                right -= dx;
                // Обновляем стартовые координаты
                startDy = details.globalPosition.dy;
                startDx = details.globalPosition.dx;
                // Ограничиваем область экрана: сверху 50, снизу 100
                top = top.clamp(50.0, MediaQuery.of(context).size.height - 100);
                right = right.clamp(0, MediaQuery.of(context).size.width - 56);
              });
            },
            child: FloatingActionButton.small(
              heroTag: "alice_btn",
              onPressed: widget.onPressed,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.bug_report, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}


class FlavorBanner extends StatelessWidget {
  final String name;
  final bool show;
  final Widget? child;

  const FlavorBanner({
    super.key,
    required this.name,
    required this.show,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
      location: BannerLocation.topStart,
      message: name,
      color: Colors.green.withValues(alpha: 0.6),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        letterSpacing: 1.0,
      ),
      child: child,
    )
        : child!;
  }
}
