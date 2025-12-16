import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainWrapper extends AutoRouter implements AutoRouteWrapper {
  const MainWrapper({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
    // final masterProfileBloc = getIt<MasterProfileBloc>();
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (context) => getIt<FilterCheckboxCubit>()),
    //     BlocProvider(
    //       create: (context) => getIt<FaqCubit>(),
    //       lazy: false,
    //     ),
    //     BlocProvider(
    //       create: (_) => masterProfileBloc..add(const GetMyProfileRequested()),
    //       lazy: false,
    //     ),
    //     BlocProvider(create: (_) => getIt<ReviewsMasterCubit>()),
    //     BlocProvider(create: (_) => getIt<AnalyticsCubit>()),
    //     BlocProvider(create: (_) => getIt<NewsCubit>()),
    //     BlocProvider(create: (_) => getIt<MasterTreatmentCubit>()..fetchTreatments(), lazy: false),
    //     BlocProvider(create: (_) => getIt<BranchesMasterCubit>(), lazy: false),
    //     BlocProvider(create: (_) => getIt<ShowBookingsCubit>(param1: masterProfileBloc), lazy: false),
    //     BlocProvider(create: (_) => getIt<BookingsCubit>()),
    //   ],
    //   child: this,
    // );
  }
}
