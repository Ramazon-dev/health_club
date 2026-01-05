import 'package:health_club/data/network/provider/auth_provider.dart';
import '../../app_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;

  LoginCubit(this.authProvider) : super(LoginInitial());

  Future<void> login(String phone) async {
    emit(LoginLoading());
    final res = await authProvider.login(phone);
    if (res.data != null) {
      emit(LoginSuccess(res.data?.success ?? ''));
    } else {
      emit(LoginError(res.message));
    }
  }
}
