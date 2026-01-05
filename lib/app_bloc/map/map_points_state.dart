part of 'map_points_cubit.dart';

sealed class MapPointsState {
  const MapPointsState();
}

final class MapPointsInitial extends MapPointsState {
  const MapPointsInitial();
}

final class MapPointsLoading extends MapPointsState {
  const MapPointsLoading();
}

final class MapPointsLoaded extends MapPointsState {
  final List<MapPointResponse> points;
  final List<String> listOfCategories;
  const MapPointsLoaded(this.points, this.listOfCategories);
}

final class MapPointsError extends MapPointsState {
  final String? message;
  const MapPointsError(this.message);
}
