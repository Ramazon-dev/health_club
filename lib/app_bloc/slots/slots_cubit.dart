import 'package:health_club/data/network/model/slot_response.dart';

import '../../data/network/provider/main_provider.dart';
import '../app_bloc.dart';

part 'slots_state.dart';

class SlotsCubit extends Cubit<SlotsState> {
  final MainProvider _mainProvider;

  SlotsCubit(this._mainProvider) : super(SlotsInitial());

  Future<void> getSlots(int id, int day) async {
    emit(SlotsLoading());
    final res = await _mainProvider.getSlots(id, day);
    final data = res.data;
    if (data != null) {
      final Map<String, SlotResponse> uniqueByTime = {};
      for (final slot in data) {
        if (slot.time != null && !uniqueByTime.containsKey(slot.time)) {
          uniqueByTime[slot.time!] = slot;
        }
      }
      emit(SlotsLoaded(uniqueByTime.values.toList()));
    } else {
      emit(SlotsError(res.message));
    }
  }

  Future<void> emptySlots() async {
    emit(SlotsLoaded([]));
  }
}
