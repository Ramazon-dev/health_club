import 'package:health_club/data/network/model/lat_long.dart';
import 'package:health_club/domain/core/services/map_setvice_utils.dart';

import '../app_bloc.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationInitial());

  Future<LatLng?> getUserLocation() async {
    final latLng = await MapServiceUtils.getUserPosition();
    if (latLng != null) {
      if (!isClosed) {
        emit(UserLocationLoaded(latLng));
      }
    } else {
      emit(UserLocationError('message'));
    }
    return latLng;
  }

  Future<LatLng?> requestLocationPermission() async {
    emit(UserLocationLoading());
    final bool? permission = await MapServiceUtils.requestLocationPermission();
    if (permission == true) {
      return getUserLocation();
    } else if (permission == false) {
      emit(UserLocationPermissionDenied());
      return null;
    } else if (permission == null) {
      emit(UserLocationPermissionDeniedForever());
      return null;
    }
    return null;
  }

  Future<void> sentUserToAppSettings() async {
    final bool canOpenSettings = await MapServiceUtils.sentUserToAppSetting();
    if (!canOpenSettings) {}
  }
}
