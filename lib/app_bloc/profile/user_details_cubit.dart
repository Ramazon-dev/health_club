import '../../data/network/model/auth/wizard_response.dart';
import '../../data/network/provider/auth_provider.dart';
import '../app_bloc.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final AuthProvider _authProvider;

  UserDetailsCubit(this._authProvider) : super(UserDetailsInitial()) {
    fetchWizard();
  }

  Future<void> fetchWizard() async {
    emit(UserDetailsLoading());
    final res = await _authProvider.wizardGet();
    final data = res.data;
    if (data != null) {
      emit(UserDetailsLoaded(data));
    } else {
      emit(UserDetailsError(res.message));
    }
  }
}
