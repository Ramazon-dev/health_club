part of 'user_me_cubit.dart';

sealed class UserMeState {
  const UserMeState();
}

final class UserMeInitial extends UserMeState {
  const UserMeInitial();
}

final class UserMeLoading extends UserMeState {
  const UserMeLoading();
}

final class UserMeLoaded extends UserMeState {
  final UserMeResponse userMe;
  const UserMeLoaded(this.userMe);
}

final class UserMeError extends UserMeState {
  final String? message;
  const UserMeError(this.message);
}
