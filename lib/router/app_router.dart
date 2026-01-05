import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: AuthWrapper.page,
      children: [
        AutoRoute(page: OnBoardingRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: PinPutRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: GenderRoute.page),
      ],
    ),
    AutoRoute(
      page: MainWrapper.page,
      // initial: true,
      children: [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(page: MapRoute.page),
            AutoRoute(page: AwardsRoute.page),
            AutoRoute(page: ProfileRoute.page, initial: true),
            AutoRoute(page: CalendarRoute.page),
          ],
        ),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: FreezeHistoryRoute.page),
        AutoRoute(page: PaymentHistoryRoute.page),
        AutoRoute(page: ContractHistoryRoute.page),
        AutoRoute(page: BodyHistoryRoute.page),
        AutoRoute(page: TrainingHistoryRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: FitnessRoute.page),
        AutoRoute(page: QrCodeScannerRoute.page),
        AutoRoute(page: NotificationsRoute.page),
        AutoRoute(page: NotificationsDetailRoute.page),
        AutoRoute(page: RatingRoute.page),
        AutoRoute(page: CommentRoute.page),
        AutoRoute(page: FeedbackRoute.page),
        AutoRoute(page: CongratulationsRoute.page),
        AutoRoute(page: DailyReportRoute.page),
        AutoRoute(page: DailyReportResultRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
