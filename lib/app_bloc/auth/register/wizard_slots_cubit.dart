import 'package:health_club/data/network/provider/auth_provider.dart';
import '../../app_bloc.dart';
part 'wizard_slots_state.dart';

class WizardSlotsCubit extends Cubit<WizardSlotsState> {
  final AuthProvider _authProvider;
  WizardSlotsCubit(this._authProvider) : super(WizardSlotsInitial());

  Future<void> fetchSlots(int id, String day) async {
    emit(WizardSlotsLoading());
    final res = await _authProvider.wizardSlots(id, day);
    final data = res.data;
    if (data != null) {
      emit(WizardSlotsLoaded(data));
    } else {
      emit(WizardSlotsError(res.message));
    }
  }
}
