import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:health_club/data/network/provider/auth_provider_impl.dart';
import 'package:health_club/data/storage/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app_bloc/app_bloc.dart';
import '../data/storage/app_storage.dart';
import '../data/network/provider/main_provider.dart';
import '../data/network/provider/main_provider_impl.dart';
import '../domain/core/alice_factory.dart';
import '../domain/core/core.dart';
import '../router/app_router.dart';
import '../data/network/provider/auth_provider.dart';

@module
abstract class Module {
  @lazySingleton
  AppRouter provideAppRouter() => AppRouter();

  @lazySingleton
  AppStorage provideAppStorage() => AppStorage();

  @lazySingleton
  TokenService provideTokenService(AppStorage appStorage, @Named('public') Dio publicDio) =>
      TokenService(appStorage, publicDio);

  @lazySingleton
  @Named('public')
  Dio providePublicDio(LocalStorage localStorage) {
    final baseOptions = BaseOptions(baseUrl: localStorage.getBaseUrl());
    final dio = Dio(baseOptions);

    dio.interceptors.addAll([
      AliceFactory().aliceDioAdapter,
      if (!kReleaseMode)
        PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: true),
    ]);
    return dio;
  }

  @lazySingleton
  Dio publicDio(TokenService tokenService, NetworkWatcher watcher, LocalStorage localStorage) {
    final baseOptions = BaseOptions(baseUrl: localStorage.getBaseUrl());
    final dio = Dio(baseOptions);

    dio.interceptors.addAll([
      RetryInterceptor(
        dio: dio,
        watcher: watcher,
        logPrint: () => print('Network error occurred'),
        toNoInternetPageNavigator: () async {
          print('No internet connection');
          // final router = getIt<AppRouter>();
          // if (router.current.name != NoInternetRoute.name) {
          //   router.push(NoInternetRoute());
          // }
        },
        accessTokenGetter: () => tokenService.accessToken,
        forbiddenFunction: () async {
          // print('object module forbiddenFunction');
          // getIt<AppBloc>().add(AppLogOutEvent());
        },
        refreshTokenFunction: () async {
          // print('object module refreshTokenFunction');
          return tokenService.refreshAccessToken();
        },
      ),
      AliceFactory().aliceDioAdapter,
      if (!kReleaseMode)
        PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: true),
    ]);
    return dio;
  }

  @lazySingleton
  NetworkWatcher provideNetworkWatcher(LocalStorage localStorage) {
    final dio = Dio(BaseOptions(baseUrl: localStorage.getBaseUrl(), connectTimeout: const Duration(seconds: 3)));
    final w = NetworkWatcher(dio, Endpoints.faq);
    w.init();
    return w;
  }

  @lazySingleton
  AuthProvider provideAuthProvider(Dio dio) => AuthProviderImpl(dio);

  @lazySingleton
  MainProvider provideMainProvider(Dio dio) => MainProviderImpl(dio);

  // @lazySingleton
  // Future<LocalStorage> provideLocalStorage() async {
  //   Hive.init((await getApplicationDocumentsDirectory()).path);
  //   final rawBox = await Hive.openBox('AppBox');
  //   return LocalStorage(rawBox);
  // }

  RegisterCubit provideRegisterCubit(AuthProvider authProvider) => RegisterCubit(authProvider);

  WizardSlotsCubit provideWizardSlotsCubit(AuthProvider authProvider) => WizardSlotsCubit(authProvider);

  WizardClubsCubit provideWizardClubsCubit(AuthProvider authProvider) => WizardClubsCubit(authProvider);

  RegisterFirstVisitCubit provideRegisterFirstVisitCubit(AuthProvider authProvider) =>
      RegisterFirstVisitCubit(authProvider);

  LoginCubit provideLoginCubit(AuthProvider authProvider, AppStorage storage, LocalStorage localStorage) =>
      LoginCubit(authProvider, storage, localStorage);

  OtpVerifyCubit provideOtpVerifyCubit(AuthProvider authProvider, AppStorage storage) =>
      OtpVerifyCubit(authProvider, storage);

  PaymentHistoryCubit providePaymentHistoryCubit(MainProvider mainProvider) => PaymentHistoryCubit(mainProvider);

  FreezeHistoryCubit provideFreezeHistoryCubit(MainProvider mainProvider) => FreezeHistoryCubit(mainProvider);

  CalendarCubit provideCalendarCubit(MainProvider mainProvider) => CalendarCubit(mainProvider);

  BodyCompositionHistoryCubit provideBodyCompositionHistoryCubit(MainProvider mainProvider) =>
      BodyCompositionHistoryCubit(mainProvider);

  SubscriptionHistoryCubit provideSubscriptionHistoryCubit(MainProvider mainProvider) =>
      SubscriptionHistoryCubit(mainProvider);

  TrainingHistoryCubit provideTrainingHistoryCubit(MainProvider mainProvider) => TrainingHistoryCubit(mainProvider);

  DailyMetricsCubit provideDailyMetricsCubit(MainProvider mainProvider) => DailyMetricsCubit(mainProvider);

  DashboardMetricsCubit provideDashboardMetricsCubit(MainProvider mainProvider) => DashboardMetricsCubit(mainProvider);

  MetricsHistoryCubit provideMetricsHistoryCubit(MainProvider mainProvider) => MetricsHistoryCubit(mainProvider);

  NutritionHistoryCubit provideNutritionHistoryCubit(MainProvider mainProvider) => NutritionHistoryCubit(mainProvider);

  NutritionDayCubit provideNutritionDayCubit(MainProvider mainProvider) => NutritionDayCubit(mainProvider);

  NutritionAnalyzeCubit provideNutritionAnalyzeCubit(MainProvider mainProvider) => NutritionAnalyzeCubit(mainProvider);

  ForecastCubit provideForecastCubit(MainProvider mainProvider) => ForecastCubit(mainProvider);

  MapPointsCubit provideMapPointsCubit(MainProvider mainProvider, @factoryParam UserLocationCubit userLocationCubit) =>
      MapPointsCubit(mainProvider, userLocationCubit);

  MapPointDetailCubit provideMapPointDetailCubit(MainProvider mainProvider) => MapPointDetailCubit(mainProvider);

  UserLocationCubit provideUserLocationCubit() => UserLocationCubit();

  CheckQrCubit provideCheckQrCubit(MainProvider mainProvider) => CheckQrCubit(mainProvider);

  UserDetailsCubit provideUserDetailsCubit(AuthProvider authProvider) => UserDetailsCubit(authProvider);

  ProfileCubit provideProfileCubit(MainProvider mainProvider, LocalStorage localStorage) =>
      ProfileCubit(mainProvider, localStorage);

  UserMeCubit provideUserMeCubit(MainProvider mainProvider) => UserMeCubit(mainProvider);

  ChangePasswordCubit provideChangePasswordCubit(MainProvider mainProvider) => ChangePasswordCubit(mainProvider);

  FirstTrainingsCubit provideFirstTrainingsCubit(MainProvider mainProvider) => FirstTrainingsCubit(mainProvider);

  TargetCubit provideTargetCubit(AuthProvider authProvider) => TargetCubit(authProvider);

  SlotsCubit provideSlotsCubit(MainProvider mainProvider) => SlotsCubit(mainProvider);

  PartnersCubit providePartnersCubit(MainProvider mainProvider) => PartnersCubit(mainProvider);

  BookSlotCubit provideBookSlotCubit(MainProvider mainProvider) => BookSlotCubit(mainProvider);
}
