import 'package:health_club/data/network/model/map/map_point_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'map_points_state.dart';

class MapPointsCubit extends Cubit<MapPointsState> {
  final MainProvider _mainProvider;

  MapPointsCubit(this._mainProvider) : super(MapPointsInitial()) {
    fetchPoints();
  }

  final List<String> listOfCategories = ['Все'];
  List<MapPointResponse> mapPoints = [];

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
      emit(MapPointsLoaded(data, listOfCategories));
    } else {
      MapPointsError(res.message);
    }
  }

  Future<void> onSearch(String query) async {
    print('object onSearch $query map points ${mapPoints.length}');
    if (query.isEmpty) {
      emit(MapPointsLoaded(mapPoints, listOfCategories));
      return;
    } else {
      emit(MapPointsLoaded([], listOfCategories));
      final result = mapPoints
          .where((element) => element.title?.toLowerCase().contains(query.toLowerCase()) == true)
          .toList();
      await Future.delayed(Duration(seconds: 1));
      print('object onSearch result $query map points ${result.length}');
      emit(MapPointsLoaded(result, listOfCategories));
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
    emit(MapPointsLoaded(points, listOfCategories));
  }
}
