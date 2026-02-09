import 'package:health_club/data/network/model/user_country_enum.dart';
import 'package:health_club/data/network/provider/auth_provider.dart';
import 'package:health_club/data/storage/local_storage.dart';
import '../../../data/storage/app_storage.dart';
import '../../app_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;
  final AppStorage storage;
  final LocalStorage localStorage;

  LoginCubit(this.authProvider, this.storage, this.localStorage) : super(LoginInitial());

  String get phonePrefix {
    if (localStorage.getCountry() == AppCountryEnum.uz.name) {
      return AppCountryEnum.uz.phonePrefix;
    } else {
      return AppCountryEnum.kz.phonePrefix;
    }
  }

  bool get selectedCountryUz {
    return localStorage.getCountry() == AppCountryEnum.uz.name;
  }

  Future<void> login(String phone) async {
    emit(LoginLoading());
    final res = await authProvider.login(phone, null);
    final data = res.data;
    if (data != null) {
      emit(LoginSuccess(data.success ?? ''));
    } else {
      emit(LoginError(res.message));
    }
  }

  Future<void> loginWithPassword(String phone, String password) async {
    emit(LoginLoading());
    final res = await authProvider.login(phone, password);
    final data = res.data;
    if (data != null) {
      if (data.isNew == true) return emit(LoginSuccess(''));
      if (data.hasPassword == false) return emit(LoginSuccess(''));
      final token = data.token;
      storage.setAccessToken(token ?? '');
      storage.setRegister(true);
      emit(LoginWithPasswordSuccess());
    } else {
      emit(LoginError(res.message));
    }
  }
}
