import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('on event ${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('on change ${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('on change ${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('on transition ${bloc.runtimeType} $transition');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("on close ${bloc.runtimeType}");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('on create ${bloc.runtimeType}');
  }
}