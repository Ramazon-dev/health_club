part of 'change_password_cubit.dart';

sealed class ChangePasswordState {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

final class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

final class ChangePasswordLoaded extends ChangePasswordState {
  const ChangePasswordLoaded();
}

final class ChangePasswordError extends ChangePasswordState {
  final String? message;
  const ChangePasswordError(this.message);
}
