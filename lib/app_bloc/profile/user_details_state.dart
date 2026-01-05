part of 'user_details_cubit.dart';

sealed class UserDetailsState {
  const UserDetailsState();
}

final class UserDetailsInitial extends UserDetailsState {
  const UserDetailsInitial();
}

final class UserDetailsLoading extends UserDetailsState {
  const UserDetailsLoading();
}

final class UserDetailsLoaded extends UserDetailsState {
  final WizardResponse wizard;
  const UserDetailsLoaded(this.wizard);
}

final class UserDetailsError extends UserDetailsState {
  final String? message;
  const UserDetailsError(this.message);
}
