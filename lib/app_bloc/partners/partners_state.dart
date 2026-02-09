part of 'partners_cubit.dart';

sealed class PartnersState {
  const PartnersState();
}

final class PartnersInitial extends PartnersState {
  const PartnersInitial();
}

final class PartnersLoading extends PartnersState {
  const PartnersLoading();
}

final class PartnersLoaded extends PartnersState {
  final List<MapPointResponse> points;

  const PartnersLoaded(this.points);
}

final class PartnersError extends PartnersState {
  final String? message;

  const PartnersError(this.message);
}
