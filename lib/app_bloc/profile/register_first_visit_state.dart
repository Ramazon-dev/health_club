part of 'register_first_visit_cubit.dart';

sealed class RegisterFirstVisitState {
  const RegisterFirstVisitState();
}

final class RegisterFirstVisitInitial extends RegisterFirstVisitState {
  const RegisterFirstVisitInitial();
}

final class RegisterFirstVisitLoading extends RegisterFirstVisitState {
  const RegisterFirstVisitLoading();
}

final class RegisterFirstVisitLoaded extends RegisterFirstVisitState {
  const RegisterFirstVisitLoaded();
}

final class RegisterFirstVisitError extends RegisterFirstVisitState {
  final String? message;
  const RegisterFirstVisitError(this.message);
}
