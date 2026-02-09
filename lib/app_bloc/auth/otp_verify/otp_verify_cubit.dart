import 'package:health_club/data/storage/app_storage.dart';
import '../../../data/network/model/auth/verify_result.dart';
import '../../../data/network/provider/auth_provider.dart';
import '../../app_bloc.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  final AuthProvider authProvider;
  final AppStorage storage;

  OtpVerifyCubit(this.authProvider, this.storage) : super(OtpVerifyInitial());

  Future<void> verify(String code) async {
    emit(OtpVerifyLoading());
    final res = await authProvider.verify(code);
    final data = res.data;
    if (data != null) {
      final token = data.token;
      storage.setAccessToken(token ?? '');
      storage.setRegister(true);
      emit(OtpVerifySuccess(data));
    } else {
      emit(OtpVerifyError(res.message));
    }
  }
}
