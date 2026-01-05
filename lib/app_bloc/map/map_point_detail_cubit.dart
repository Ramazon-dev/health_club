import 'package:health_club/data/network/model/map/map_detail_response.dart';

import '../../data/network/provider/main_provider.dart';
import '../app_bloc.dart';

part 'map_point_detail_state.dart';

class MapPointDetailCubit extends Cubit<MapPointDetailState> {
  final MainProvider _mainProvider;

  MapPointDetailCubit(this._mainProvider) : super(MapPointDetailInitial());

  Future<void> getMapPointDetail(String type, int id) async {
    emit(MapPointDetailLoading());
    final res = await _mainProvider.getMapDetail(type, id);
    final data = res.data;
    if (data != null) {
      emit(MapPointDetailLoaded(data));
    } else {
      emit(MapPointDetailError(res.message));
    }
  }
}
