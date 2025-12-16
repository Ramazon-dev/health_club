import 'package:health_club/app_bloc/auth/register/register_cubit.dart';
import 'package:injectable/injectable.dart';

import '../router/app_router.dart';

@module
abstract class Module {
  @lazySingleton
  AppRouter provideAppRouter() => AppRouter();

  RegisterCubit provideRegisterCubit() => RegisterCubit();
}
