import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app_bloc/app_bloc.dart';
import '../../di/init.dart';

@RoutePage()
class MainWrapper extends AutoRouter implements AutoRouteWrapper {
  const MainWrapper({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    print('object MainWrapper wrappedRoute');
    // return this;
    final userLocationCubit = getIt<UserLocationCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => userLocationCubit),
        BlocProvider(create: (context) => getIt<ProfileCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<UserMeCubit>(), lazy: false),
        // BlocProvider(create: (context) => getIt<UserDetailsCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<ForecastCubit>(), lazy: false),
        BlocProvider(
          create: (context) => getIt<MapPointsCubit>(param1: context.read<UserLocationCubit>()),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<FreezeHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<PaymentHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<CalendarCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<BodyCompositionHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<SubscriptionHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<TrainingHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<DailyMetricsCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<DashboardMetricsCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<MetricsHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<NutritionHistoryCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<NutritionDayCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<TargetCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<NutritionAnalyzeCubit>()),
        BlocProvider(create: (context) => getIt<MapPointDetailCubit>()),
        BlocProvider(create: (context) => getIt<CheckQrCubit>()),
        BlocProvider(create: (context) => getIt<SlotsCubit>()),
        BlocProvider(create: (context) => getIt<BookSlotCubit>()),
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<WizardSlotsCubit>()),
        BlocProvider(create: (context) => getIt<ChangePasswordCubit>()),
        BlocProvider(create: (context) => getIt<WizardClubsCubit>()),
        BlocProvider(create: (context) => getIt<FirstTrainingsCubit>()),
        BlocProvider(create: (context) => getIt<PartnersCubit>()),
        // BlocProvider(
        //   create: (context) => getIt<FaqCubit>(),
        //   lazy: false,
        // ),
        // BlocProvider(
        //   create: (_) => masterProfileBloc..add(const GetMyProfileRequested()),
        //   lazy: false,
        // ),
        // BlocProvider(create: (_) => getIt<ReviewsMasterCubit>()),
        // BlocProvider(create: (_) => getIt<AnalyticsCubit>()),
        // BlocProvider(create: (_) => getIt<NewsCubit>()),
        // BlocProvider(create: (_) => getIt<MasterTreatmentCubit>()..fetchTreatments(), lazy: false),
        // BlocProvider(create: (_) => getIt<BranchesMasterCubit>(), lazy: false),
        // BlocProvider(create: (_) => getIt<ShowBookingsCubit>(param1: masterProfileBloc), lazy: false),
        // BlocProvider(create: (_) => getIt<BookingsCubit>()),
      ],
      child: this,
    );
  }
}
