import 'package:health_club/data/network/provider/main_provider.dart';

import '../../data/network/model/map/map_point_response.dart';
import '../app_bloc.dart';

part 'partners_state.dart';

class PartnersCubit extends Cubit<PartnersState> {
  final MainProvider _mainProvider;

  PartnersCubit(this._mainProvider) : super(PartnersInitial()) {
    fetchPartners();
  }

  Future<void> fetchPartners() async {
    emit(PartnersLoading());
    final res = await _mainProvider.getMapPoints();
    final data = res.data;
    if (data != null) {
      final partners = data.where((element) => element.type == 'partner' || element.type == 'bonus_partner').toList();
      emit(PartnersLoaded(partners));
    } else {
      emit(PartnersError(res.message));
    }
  }
}
