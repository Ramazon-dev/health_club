import 'package:health_club/data/network/model/user_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'user_me_state.dart';

class UserMeCubit extends Cubit<UserMeState> {
  final MainProvider _mainProvider;

  UserMeCubit(this._mainProvider) : super(UserMeInitial()) {
    getUser();
  }

  Future<void> getUser() async {
    emit(UserMeLoading());
    final res = await _mainProvider.getUser();
    final user = res.data;
    if (user != null) {
      emit(UserMeLoaded(user));
    } else {
      emit(UserMeError(res.message));
    }
  }
}
