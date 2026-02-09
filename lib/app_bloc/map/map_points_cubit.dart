import 'package:health_club/data/network/model/lat_long.dart';
import 'package:health_club/data/network/model/map/map_point_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../../domain/core/services/map_setvice_utils.dart';
import '../app_bloc.dart';

part 'map_points_state.dart';

class MapPointsCubit extends Cubit<MapPointsState> {
  final MainProvider _mainProvider;
  final UserLocationCubit userLocationCubit;

  MapPointsCubit(this._mainProvider, this.userLocationCubit) : super(MapPointsInitial()) {
    fetchPoints();
    userLocationCubit.stream.listen((UserLocationState state) {
      if (state is UserLocationLoaded) {
        onUserLocationFetch(state.latLng);
      }
    });
  }

  final List<String> listOfCategories = ['Все'];
  String searchQuery = '';
  List<MapPointResponse> mapPoints = [];
  LatLng? latLng;

  void onUserLocationFetch(LatLng latLng) {
    if (!isClosed) {
      emit(MapPointsLoading());
    }
    this.latLng = latLng;
    emit(MapPointsLoaded(checkUserLocationIsNull(mapPoints), listOfCategories));
  }

  List<MapPointResponse> checkUserLocationIsNull(List<MapPointResponse> points) {
    final list = checkSearch(points);
    final latLng = this.latLng;
    return latLng != null ? sortByLocation(latLng, list) : list;
  }

  List<MapPointResponse> checkSearch(List<MapPointResponse> points) {
    if (searchQuery.isNotEmpty) {
      return points
          .where((element) => element.title?.toLowerCase().contains(searchQuery.toLowerCase()) == true)
          .toList();
    }
    return points;
  }

  List<MapPointResponse> sortByLocation(LatLng latLng, List<MapPointResponse> points) {
    return points.map((e) {
      final lat = e.lat;
      final long = e.long;
      if (lat != null && long != null) {
        return e.copyWith(
          distance: MapServiceUtils.distanceBetween(latLng, LatLng(lat: double.parse(lat), lng: double.parse(long))),
        );
      } else {
        return e;
      }
    }).toList()..sort((a, b) {
      final d1 = a.distance;
      final d2 = b.distance;
      if (d1 == null && d2 == null) return 0;
      if (d1 == null) return 1;
      if (d2 == null) return -1;
      return d1.compareTo(d2);
      // return a.distance?.compareTo(b.distance ?? 0) ?? 0;
    });
  }

  Future<void> fetchPoints() async {
    emit(MapPointsLoading());
    final res = await _mainProvider.getMapPoints();
    final data = res.data;
    if (data != null) {
      for (final item in data) {
        final contains = listOfCategories.contains(item.type);
        if (!contains) listOfCategories.add(item.type ?? '');
      }
      mapPoints = data;
      emit(MapPointsLoaded(checkUserLocationIsNull(data), listOfCategories));
    } else {
      MapPointsError(res.message);
    }
  }

  Future<void> onSearch(String query) async {
    searchQuery = query;
    print('object onSearch $query map points ${mapPoints.length}');
    if (query.isEmpty) {
      emit(MapPointsLoaded(checkUserLocationIsNull(mapPoints), listOfCategories));
      return;
    } else {
      emit(MapPointsLoaded([], listOfCategories));
      // final result = mapPoints
      //     .where((element) => element.title?.toLowerCase().contains(query.toLowerCase()) == true)
      //     .toList();
      await Future.delayed(Duration(seconds: 1));
      emit(MapPointsLoaded(checkUserLocationIsNull(mapPoints), listOfCategories));
    }
  }

  void onCategoryChanged(String category) {
    print('object onCategoryChanged $category mapPoints ${mapPoints.length}');
    emit(MapPointsLoading());
    final List<MapPointResponse> points = [];
    for (final item in mapPoints) {
      print('object onCategoryChanged $category item.type ${item.type}');
      if (category == 'Все') {
        points.add(item);
      } else if (item.type == category) {
        points.add(item);
      }
    }
    print('object onCategoryChanged $category points ${points.length}');
    emit(MapPointsLoaded(checkUserLocationIsNull(points), listOfCategories));
  }
}
