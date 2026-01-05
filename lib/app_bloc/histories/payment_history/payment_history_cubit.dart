import 'package:health_club/data/network/model/history/payment_history_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../../app_bloc.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final MainProvider _mainProvider;
  PaymentHistoryCubit(this._mainProvider) : super(PaymentHistoryInitial()) {
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    emit(PaymentHistoryLoading());
    final res = await _mainProvider.getPaymentHistory();
    final data = res.data;
    if (data != null) {
      emit(PaymentHistoryLoaded(data));
    } else {
      emit(PaymentHistoryError(res.message));
    }
  }
}
