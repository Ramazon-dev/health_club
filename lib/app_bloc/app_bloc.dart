import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'auth/register/register_cubit.dart';
export 'auth/login/login_cubit.dart';
export 'auth/otp_verify/otp_verify_cubit.dart';
export 'bloc_observer.dart';

export 'histories/body_composition/body_composition_history_cubit.dart';
export 'histories/freeze_history/freeze_history_cubit.dart';
export 'histories/payment_history/payment_history_cubit.dart';
export 'histories/subscription_history/subscription_history_cubit.dart';
export 'histories/training_history/training_history_cubit.dart';
export 'metrics/daily_metrics/daily_metrics_cubit.dart';
export 'metrics/dashboard_metrics/dashboard_metrics_cubit.dart';
export 'metrics/metrics_history/metrics_history_cubit.dart';
export 'map/map_points_cubit.dart';
export 'map/map_point_detail_cubit.dart';
export 'nutritions/nutrition_analyze/nutrition_analyze_cubit.dart';
export 'nutritions/nutrition_history/nutrition_history_cubit.dart';
export 'nutritions/nutrition_day/nutrition_day_cubit.dart';
export 'profile/profile_cubit.dart';
export 'profile/user_details_cubit.dart';
export 'calendar/calendar_cubit.dart';
export 'check_qr/check_qr_cubit.dart';
export 'forecast/forecast_cubit.dart';

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
