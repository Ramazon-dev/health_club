part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final String verificationId;
  const LoginSuccess(this.verificationId);
}

final class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}
