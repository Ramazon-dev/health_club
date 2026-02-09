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
  final String verifyCode;
  const LoginSuccess(this.verifyCode);
}

final class LoginWithPasswordSuccess extends LoginState {
  const LoginWithPasswordSuccess();
}

final class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}
