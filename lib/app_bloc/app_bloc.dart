import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'auth/register/register_cubit.dart';

class AppBloc {
  AppBloc._();

  AppBloc.init() {
    _init();
  }

  void _init() {
    if (kDebugMode) {
      Bloc.observer = AppBlocObserver();
    }
  }
}
