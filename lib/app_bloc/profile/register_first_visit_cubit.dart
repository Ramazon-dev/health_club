import '../../data/network/provider/auth_provider.dart';
import '../app_bloc.dart';

part 'register_first_visit_state.dart';

class RegisterFirstVisitCubit extends Cubit<RegisterFirstVisitState> {
  final AuthProvider _authProvider;

  RegisterFirstVisitCubit(this._authProvider) : super(RegisterFirstVisitInitial());

  Future<void> registerFirstVisit({
    required String surname,
    required int placeId,
    required String date,
    required String time,
  }) async {
    emit(RegisterFirstVisitLoading());
    final res = await _authProvider.wizardPush(7, {
      'surname': surname,
      'place_id': placeId,
      'date': date,
      'time': time,
    });
    if (res.data != null) {
      emit(RegisterFirstVisitLoaded());
    } else {
      emit(RegisterFirstVisitError(res.message));
    }
  }
}
