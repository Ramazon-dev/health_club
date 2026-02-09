import '../../data/network/model/clubs_response.dart';
import '../../data/network/provider/auth_provider.dart';
import '../app_bloc.dart';

part 'wizard_clubs_state.dart';

class WizardClubsCubit extends Cubit<WizardClubsState> {
  final AuthProvider _authProvider;

  WizardClubsCubit(this._authProvider) : super(WizardClubsInitial()){
    fetchClubs();
  }

  Future<void> fetchClubs() async {
    emit(WizardClubsLoading());
    final res = await _authProvider.wizardClubs();
    final data = res.data?.clubs;
    if (data != null) {
      emit(WizardClubsLoaded(data));
    } else {
      emit(WizardClubsError(res.message));
    }
  }
}
