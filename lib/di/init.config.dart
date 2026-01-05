// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../app_bloc/app_bloc.dart' as _i490;
import '../data/network/provider/auth_provider.dart' as _i552;
import '../data/network/provider/main_provider.dart' as _i903;
import '../data/storage/app_storage.dart' as _i251;
import '../domain/core/core.dart' as _i772;
import '../router/app_router.dart' as _i81;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final module = _$Module();
    gh.lazySingleton<_i81.AppRouter>(() => module.provideAppRouter());
    gh.lazySingleton<_i251.AppStorage>(() => module.provideAppStorage());
    gh.lazySingleton<_i772.NetworkWatcher>(
      () => module.provideNetworkWatcher(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => module.providePublicDio(),
      instanceName: 'public',
    );
    gh.lazySingleton<_i772.TokenService>(
      () => module.provideTokenService(
        gh<_i251.AppStorage>(),
        gh<_i361.Dio>(instanceName: 'public'),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => module.publicDio(
        gh<_i772.TokenService>(),
        gh<_i772.NetworkWatcher>(),
      ),
    );
    gh.lazySingleton<_i552.AuthProvider>(
      () => module.provideAuthProvider(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i903.MainProvider>(
      () => module.provideMainProvider(gh<_i361.Dio>()),
    );
    gh.factory<_i490.PaymentHistoryCubit>(
      () => module.providePaymentHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.FreezeHistoryCubit>(
      () => module.provideFreezeHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.CalendarCubit>(
      () => module.provideCalendarCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.BodyCompositionHistoryCubit>(
      () => module.provideBodyCompositionHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.SubscriptionHistoryCubit>(
      () => module.provideSubscriptionHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.TrainingHistoryCubit>(
      () => module.provideTrainingHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.DailyMetricsCubit>(
      () => module.provideDailyMetricsCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.DashboardMetricsCubit>(
      () => module.provideDashboardMetricsCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.MetricsHistoryCubit>(
      () => module.provideMetricsHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.NutritionHistoryCubit>(
      () => module.provideNutritionHistoryCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.NutritionDayCubit>(
      () => module.provideNutritionDayCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.NutritionAnalyzeCubit>(
      () => module.provideNutritionAnalyzeCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.ForecastCubit>(
      () => module.provideForecastCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.MapPointsCubit>(
      () => module.provideMapPointsCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.MapPointDetailCubit>(
      () => module.provideMapPointDetailCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.CheckQrCubit>(
      () => module.provideCheckQrCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.ProfileCubit>(
      () => module.provideProfileCubit(gh<_i903.MainProvider>()),
    );
    gh.factory<_i490.OtpVerifyCubit>(
      () => module.provideOtpVerifyCubit(
        gh<_i552.AuthProvider>(),
        gh<_i251.AppStorage>(),
      ),
    );
    gh.factory<_i490.RegisterCubit>(
      () => module.provideRegisterCubit(gh<_i552.AuthProvider>()),
    );
    gh.factory<_i490.LoginCubit>(
      () => module.provideLoginCubit(gh<_i552.AuthProvider>()),
    );
    gh.factory<_i490.UserDetailsCubit>(
      () => module.provideUserDetailsCubit(gh<_i552.AuthProvider>()),
    );
    return this;
  }
}

class _$Module extends _i946.Module {}
