import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'check_qr_state.dart';

class CheckQrCubit extends Cubit<CheckQrState> {
  final MainProvider _mainProvider;

  CheckQrCubit(this._mainProvider) : super(CheckQrInitial());

  Future<void> checkQrCode(String code) async {
    emit(CheckQrLoading());
    final res = await _mainProvider.checkQr(code);
    final data = res.data;
    if (data != null) {
      emit(CheckQrLoaded(data.status ?? ''));
    } else {
      emit(CheckQrError(res.message));
    }
  }
}
