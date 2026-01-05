part of 'map_point_detail_cubit.dart';

sealed class MapPointDetailState {
  const MapPointDetailState();
}

final class MapPointDetailInitial extends MapPointDetailState {
  const MapPointDetailInitial();
}

final class MapPointDetailLoading extends MapPointDetailState {
  const MapPointDetailLoading();
}

final class MapPointDetailLoaded extends MapPointDetailState {
  final MapDetailResponse mapPoint;
  const MapPointDetailLoaded(this.mapPoint);
}

final class MapPointDetailError extends MapPointDetailState {
  final String? message;
  const MapPointDetailError(this.message);
}
