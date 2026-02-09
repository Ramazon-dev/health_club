// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i36;
import 'package:flutter/material.dart' as _i37;
import 'package:health_club/data/network/model/dashboard_metrics_response.dart'
    as _i38;
import 'package:health_club/data/network/model/lat_long.dart' as _i39;
import 'package:health_club/feature/auth/auth_wrapper.dart' as _i1;
import 'package:health_club/feature/auth/pages/login_page.dart' as _i16;
import 'package:health_club/feature/auth/pages/on_boarding_page.dart' as _i22;
import 'package:health_club/feature/auth/pages/pin_put_page.dart' as _i24;
import 'package:health_club/feature/auth/pages/register_page.dart' as _i31;
import 'package:health_club/feature/auth/pages/splash_screen.dart' as _i34;
import 'package:health_club/feature/main/awards/awards_history_page.dart'
    as _i2;
import 'package:health_club/feature/main/awards/awards_page.dart' as _i3;
import 'package:health_club/feature/main/calendar/calendar_page.dart' as _i5;
import 'package:health_club/feature/main/main_page.dart' as _i17;
import 'package:health_club/feature/main/main_wrapper.dart' as _i18;
import 'package:health_club/feature/main/notifications/notifications_detail_page.dart'
    as _i20;
import 'package:health_club/feature/main/notifications/notifications_page.dart'
    as _i21;
import 'package:health_club/feature/main/profile/edit_profile_page.dart'
    as _i12;
import 'package:health_club/feature/main/profile/pages/body_history_page.dart'
    as _i4;
import 'package:health_club/feature/main/profile/pages/change_password_page.dart'
    as _i6;
import 'package:health_club/feature/main/profile/pages/contract_history_page.dart'
    as _i9;
import 'package:health_club/feature/main/profile/pages/daily_report_page.dart'
    as _i10;
import 'package:health_club/feature/main/profile/pages/daily_report_result_page.dart'
    as _i11;
import 'package:health_club/feature/main/profile/pages/freeze_history_page.dart'
    as _i15;
import 'package:health_club/feature/main/profile/pages/payment_history_page.dart'
    as _i23;
import 'package:health_club/feature/main/profile/pages/privacy_policy_page.dart'
    as _i25;
import 'package:health_club/feature/main/profile/pages/process_in_month_page.dart'
    as _i26;
import 'package:health_club/feature/main/profile/pages/public_offer_page.dart'
    as _i28;
import 'package:health_club/feature/main/profile/pages/settings_page.dart'
    as _i33;
import 'package:health_club/feature/main/profile/pages/training_history_page.dart'
    as _i35;
import 'package:health_club/feature/main/profile/profile_page.dart' as _i27;
import 'package:health_club/feature/main/qr_code_scanner/comment_page.dart'
    as _i7;
import 'package:health_club/feature/main/qr_code_scanner/congratulations_page.dart'
    as _i8;
import 'package:health_club/feature/main/qr_code_scanner/feedback_page.dart'
    as _i13;
import 'package:health_club/feature/main/qr_code_scanner/qr_code_scanner_page.dart'
    as _i29;
import 'package:health_club/feature/main/qr_code_scanner/rating_page.dart'
    as _i30;
import 'package:health_club/feature/main/search/fitnes_page.dart' as _i14;
import 'package:health_club/feature/main/search/map_page.dart' as _i19;
import 'package:health_club/feature/main/search/search_page.dart' as _i32;

/// generated route for
/// [_i1.AuthWrapper]
class AuthWrapper extends _i36.PageRouteInfo<void> {
  const AuthWrapper({List<_i36.PageRouteInfo>? children})
    : super(AuthWrapper.name, initialChildren: children);

  static const String name = 'AuthWrapper';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i1.AuthWrapper());
    },
  );
}

/// generated route for
/// [_i2.AwardsHistoryPage]
class AwardsHistoryRoute extends _i36.PageRouteInfo<AwardsHistoryRouteArgs> {
  AwardsHistoryRoute({
    _i37.Key? key,
    required _i38.MetricsEnum metricsEnum,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         AwardsHistoryRoute.name,
         args: AwardsHistoryRouteArgs(key: key, metricsEnum: metricsEnum),
         initialChildren: children,
       );

  static const String name = 'AwardsHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AwardsHistoryRouteArgs>();
      return _i2.AwardsHistoryPage(
        key: args.key,
        metricsEnum: args.metricsEnum,
      );
    },
  );
}

class AwardsHistoryRouteArgs {
  const AwardsHistoryRouteArgs({this.key, required this.metricsEnum});

  final _i37.Key? key;

  final _i38.MetricsEnum metricsEnum;

  @override
  String toString() {
    return 'AwardsHistoryRouteArgs{key: $key, metricsEnum: $metricsEnum}';
  }
}

/// generated route for
/// [_i3.AwardsPage]
class AwardsRoute extends _i36.PageRouteInfo<void> {
  const AwardsRoute({List<_i36.PageRouteInfo>? children})
    : super(AwardsRoute.name, initialChildren: children);

  static const String name = 'AwardsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i3.AwardsPage();
    },
  );
}

/// generated route for
/// [_i4.BodyHistoryPage]
class BodyHistoryRoute extends _i36.PageRouteInfo<void> {
  const BodyHistoryRoute({List<_i36.PageRouteInfo>? children})
    : super(BodyHistoryRoute.name, initialChildren: children);

  static const String name = 'BodyHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i4.BodyHistoryPage();
    },
  );
}

/// generated route for
/// [_i5.CalendarPage]
class CalendarRoute extends _i36.PageRouteInfo<void> {
  const CalendarRoute({List<_i36.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i5.CalendarPage();
    },
  );
}

/// generated route for
/// [_i6.ChangePasswordPage]
class ChangePasswordRoute extends _i36.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i36.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i6.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i7.CommentPage]
class CommentRoute extends _i36.PageRouteInfo<void> {
  const CommentRoute({List<_i36.PageRouteInfo>? children})
    : super(CommentRoute.name, initialChildren: children);

  static const String name = 'CommentRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i7.CommentPage();
    },
  );
}

/// generated route for
/// [_i8.CongratulationsPage]
class CongratulationsRoute extends _i36.PageRouteInfo<void> {
  const CongratulationsRoute({List<_i36.PageRouteInfo>? children})
    : super(CongratulationsRoute.name, initialChildren: children);

  static const String name = 'CongratulationsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i8.CongratulationsPage();
    },
  );
}

/// generated route for
/// [_i9.ContractHistoryPage]
class ContractHistoryRoute extends _i36.PageRouteInfo<void> {
  const ContractHistoryRoute({List<_i36.PageRouteInfo>? children})
    : super(ContractHistoryRoute.name, initialChildren: children);

  static const String name = 'ContractHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContractHistoryPage();
    },
  );
}

/// generated route for
/// [_i10.DailyReportPage]
class DailyReportRoute extends _i36.PageRouteInfo<void> {
  const DailyReportRoute({List<_i36.PageRouteInfo>? children})
    : super(DailyReportRoute.name, initialChildren: children);

  static const String name = 'DailyReportRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i10.DailyReportPage();
    },
  );
}

/// generated route for
/// [_i11.DailyReportResultPage]
class DailyReportResultRoute extends _i36.PageRouteInfo<void> {
  const DailyReportResultRoute({List<_i36.PageRouteInfo>? children})
    : super(DailyReportResultRoute.name, initialChildren: children);

  static const String name = 'DailyReportResultRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i11.DailyReportResultPage();
    },
  );
}

/// generated route for
/// [_i12.EditProfilePage]
class EditProfileRoute extends _i36.PageRouteInfo<void> {
  const EditProfileRoute({List<_i36.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i12.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i13.FeedbackPage]
class FeedbackRoute extends _i36.PageRouteInfo<void> {
  const FeedbackRoute({List<_i36.PageRouteInfo>? children})
    : super(FeedbackRoute.name, initialChildren: children);

  static const String name = 'FeedbackRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i13.FeedbackPage();
    },
  );
}

/// generated route for
/// [_i14.FitnessPage]
class FitnessRoute extends _i36.PageRouteInfo<FitnessRouteArgs> {
  FitnessRoute({
    _i37.Key? key,
    required _i39.LatLng<dynamic>? latLng,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         FitnessRoute.name,
         args: FitnessRouteArgs(key: key, latLng: latLng),
         initialChildren: children,
       );

  static const String name = 'FitnessRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FitnessRouteArgs>();
      return _i14.FitnessPage(key: args.key, latLng: args.latLng);
    },
  );
}

class FitnessRouteArgs {
  const FitnessRouteArgs({this.key, required this.latLng});

  final _i37.Key? key;

  final _i39.LatLng<dynamic>? latLng;

  @override
  String toString() {
    return 'FitnessRouteArgs{key: $key, latLng: $latLng}';
  }
}

/// generated route for
/// [_i15.FreezeHistoryPage]
class FreezeHistoryRoute extends _i36.PageRouteInfo<void> {
  const FreezeHistoryRoute({List<_i36.PageRouteInfo>? children})
    : super(FreezeHistoryRoute.name, initialChildren: children);

  static const String name = 'FreezeHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i15.FreezeHistoryPage();
    },
  );
}

/// generated route for
/// [_i16.LoginPage]
class LoginRoute extends _i36.PageRouteInfo<void> {
  const LoginRoute({List<_i36.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i16.LoginPage();
    },
  );
}

/// generated route for
/// [_i17.MainPage]
class MainRoute extends _i36.PageRouteInfo<void> {
  const MainRoute({List<_i36.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i17.MainPage();
    },
  );
}

/// generated route for
/// [_i18.MainWrapper]
class MainWrapper extends _i36.PageRouteInfo<void> {
  const MainWrapper({List<_i36.PageRouteInfo>? children})
    : super(MainWrapper.name, initialChildren: children);

  static const String name = 'MainWrapper';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return _i36.WrappedRoute(child: const _i18.MainWrapper());
    },
  );
}

/// generated route for
/// [_i19.MapPage]
class MapRoute extends _i36.PageRouteInfo<void> {
  const MapRoute({List<_i36.PageRouteInfo>? children})
    : super(MapRoute.name, initialChildren: children);

  static const String name = 'MapRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i19.MapPage();
    },
  );
}

/// generated route for
/// [_i20.NotificationsDetailPage]
class NotificationsDetailRoute extends _i36.PageRouteInfo<void> {
  const NotificationsDetailRoute({List<_i36.PageRouteInfo>? children})
    : super(NotificationsDetailRoute.name, initialChildren: children);

  static const String name = 'NotificationsDetailRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i20.NotificationsDetailPage();
    },
  );
}

/// generated route for
/// [_i21.NotificationsPage]
class NotificationsRoute extends _i36.PageRouteInfo<void> {
  const NotificationsRoute({List<_i36.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i21.NotificationsPage();
    },
  );
}

/// generated route for
/// [_i22.OnBoardingPage]
class OnBoardingRoute extends _i36.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i36.PageRouteInfo>? children})
    : super(OnBoardingRoute.name, initialChildren: children);

  static const String name = 'OnBoardingRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i22.OnBoardingPage();
    },
  );
}

/// generated route for
/// [_i23.PaymentHistoryPage]
class PaymentHistoryRoute extends _i36.PageRouteInfo<void> {
  const PaymentHistoryRoute({List<_i36.PageRouteInfo>? children})
    : super(PaymentHistoryRoute.name, initialChildren: children);

  static const String name = 'PaymentHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i23.PaymentHistoryPage();
    },
  );
}

/// generated route for
/// [_i24.PinPutPage]
class PinPutRoute extends _i36.PageRouteInfo<PinPutRouteArgs> {
  PinPutRoute({
    _i37.Key? key,
    required String phoneNumber,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         PinPutRoute.name,
         args: PinPutRouteArgs(key: key, phoneNumber: phoneNumber),
         initialChildren: children,
       );

  static const String name = 'PinPutRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinPutRouteArgs>();
      return _i24.PinPutPage(key: args.key, phoneNumber: args.phoneNumber);
    },
  );
}

class PinPutRouteArgs {
  const PinPutRouteArgs({this.key, required this.phoneNumber});

  final _i37.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'PinPutRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i25.PrivacyPolicyPage]
class PrivacyPolicyRoute extends _i36.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i36.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i25.PrivacyPolicyPage();
    },
  );
}

/// generated route for
/// [_i26.ProcessInMonthPage]
class ProcessInMonthRoute extends _i36.PageRouteInfo<void> {
  const ProcessInMonthRoute({List<_i36.PageRouteInfo>? children})
    : super(ProcessInMonthRoute.name, initialChildren: children);

  static const String name = 'ProcessInMonthRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i26.ProcessInMonthPage();
    },
  );
}

/// generated route for
/// [_i27.ProfilePage]
class ProfileRoute extends _i36.PageRouteInfo<void> {
  const ProfileRoute({List<_i36.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i27.ProfilePage();
    },
  );
}

/// generated route for
/// [_i28.PublicOfferPage]
class PublicOfferRoute extends _i36.PageRouteInfo<void> {
  const PublicOfferRoute({List<_i36.PageRouteInfo>? children})
    : super(PublicOfferRoute.name, initialChildren: children);

  static const String name = 'PublicOfferRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i28.PublicOfferPage();
    },
  );
}

/// generated route for
/// [_i29.QrCodeScannerPage]
class QrCodeScannerRoute extends _i36.PageRouteInfo<void> {
  const QrCodeScannerRoute({List<_i36.PageRouteInfo>? children})
    : super(QrCodeScannerRoute.name, initialChildren: children);

  static const String name = 'QrCodeScannerRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i29.QrCodeScannerPage();
    },
  );
}

/// generated route for
/// [_i30.RatingPage]
class RatingRoute extends _i36.PageRouteInfo<void> {
  const RatingRoute({List<_i36.PageRouteInfo>? children})
    : super(RatingRoute.name, initialChildren: children);

  static const String name = 'RatingRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i30.RatingPage();
    },
  );
}

/// generated route for
/// [_i31.RegisterPage]
class RegisterRoute extends _i36.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i37.Key? key,
    required int step,
    List<_i36.PageRouteInfo>? children,
  }) : super(
         RegisterRoute.name,
         args: RegisterRouteArgs(key: key, step: step),
         initialChildren: children,
       );

  static const String name = 'RegisterRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>();
      return _i31.RegisterPage(key: args.key, step: args.step);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key, required this.step});

  final _i37.Key? key;

  final int step;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, step: $step}';
  }
}

/// generated route for
/// [_i32.SearchPage]
class SearchRoute extends _i36.PageRouteInfo<void> {
  const SearchRoute({List<_i36.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i32.SearchPage();
    },
  );
}

/// generated route for
/// [_i33.SettingsPage]
class SettingsRoute extends _i36.PageRouteInfo<void> {
  const SettingsRoute({List<_i36.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i33.SettingsPage();
    },
  );
}

/// generated route for
/// [_i34.SplashScreen]
class SplashRoute extends _i36.PageRouteInfo<void> {
  const SplashRoute({List<_i36.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i34.SplashScreen();
    },
  );
}

/// generated route for
/// [_i35.TrainingHistoryPage]
class TrainingHistoryRoute extends _i36.PageRouteInfo<void> {
  const TrainingHistoryRoute({List<_i36.PageRouteInfo>? children})
    : super(TrainingHistoryRoute.name, initialChildren: children);

  static const String name = 'TrainingHistoryRoute';

  static _i36.PageInfo page = _i36.PageInfo(
    name,
    builder: (data) {
      return const _i35.TrainingHistoryPage();
    },
  );
}
