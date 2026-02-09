part of 'user_location_cubit.dart';

sealed class UserLocationState {
  const UserLocationState();
}

final class UserLocationInitial extends UserLocationState {
  const UserLocationInitial();
}

final class UserLocationLoading extends UserLocationState {
  const UserLocationLoading();
}

final class UserLocationLoaded extends UserLocationState {
  final LatLng latLng;
  const UserLocationLoaded(this.latLng);
}

final class UserLocationError extends UserLocationState {
  final String? message;
  const UserLocationError(this.message);
}

final class UserLocationPermissionDenied extends UserLocationState {
  const UserLocationPermissionDenied();
}

final class UserLocationPermissionDeniedForever extends UserLocationState {
  const UserLocationPermissionDeniedForever();
}
