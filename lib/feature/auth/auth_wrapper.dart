import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app_bloc/app_bloc.dart';
import '../../di/init.dart';

@RoutePage()
class AuthWrapper extends AutoRouter implements AutoRouteWrapper {
  const AuthWrapper({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    // return this;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<OtpVerifyCubit>()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        // BlocProvider(create: (context) => getIt<AuthBloc>()),
        // BlocProvider(create: (_) => getIt<MasterProfileBloc>()),
      ],
      child: this,
    );
  }
}
