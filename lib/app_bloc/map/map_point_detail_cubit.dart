import 'package:health_club/data/network/model/lat_long.dart';
import 'package:health_club/data/network/model/map/map_detail_response.dart';
import 'package:health_club/domain/core/services/map_setvice_utils.dart';

import '../../data/network/provider/main_provider.dart';
import '../app_bloc.dart';

part 'map_point_detail_state.dart';

class MapPointDetailCubit extends Cubit<MapPointDetailState> {
  final MainProvider _mainProvider;

  MapPointDetailCubit(this._mainProvider) : super(MapPointDetailInitial());

  Future<void> getMapPointDetail(String type, int id, LatLng? latLng) async {
    emit(MapPointDetailLoading());
    final res = await _mainProvider.getMapDetail(type, id);
    final data = res.data;
    if (data != null) {
      if (latLng != null) {
        checkDistance(data, latLng);
      } else {
        emit(MapPointDetailLoaded(data));
      }
    } else {
      emit(MapPointDetailError(res.message));
    }
  }

  void checkDistance(MapDetailResponse data, LatLng latLng) {
    final lat = data.data?.lat;
    final long = data.data?.long;
    late MapDetailResponse mapDetailResponse;
    if (lat != null && long != null) {
      mapDetailResponse = MapDetailResponse(
        success: true,
        data: data.data?.copyWith(
          distance: MapServiceUtils.distanceBetween(latLng, LatLng(lat: double.parse(lat), lng: double.parse(long))),
          otherBranches: data.data?.otherBranches.map((e) {
            final lat = e.lat;
            final long = e.long;
            if (lat != null && long != null) {
              return e.copyWith(
                distance: MapServiceUtils.distanceBetween(
                  latLng,
                  LatLng(lat: double.parse(lat), lng: double.parse(long)),
                ),
              );
            } else {
              return e;
            }
          }).toList(),
        ),
      );
    } else {
      mapDetailResponse = data;
    }
    emit(MapPointDetailLoaded(mapDetailResponse));
  }
}
