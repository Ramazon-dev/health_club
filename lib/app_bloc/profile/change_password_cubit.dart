import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final MainProvider _mainProvider;

  ChangePasswordCubit(this._mainProvider) : super(ChangePasswordInitial());

  Future<void> changePassword(String password, String confirmationPassword) async {
    emit(ChangePasswordLoading());
    final res = await _mainProvider.changePassword(password, confirmationPassword);
    if (res.data != null) {
      emit(ChangePasswordLoaded());
    } else {
      emit(ChangePasswordError(res.message));
    }
  }
}
