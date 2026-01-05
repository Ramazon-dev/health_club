import 'package:health_club/data/network/provider/main_provider.dart';

import '../../../data/network/model/history/subscription_history_response.dart';
import '../../app_bloc.dart';

part 'subscription_history_state.dart';

class SubscriptionHistoryCubit extends Cubit<SubscriptionHistoryState> {
  final MainProvider _mainProvider;

  SubscriptionHistoryCubit(this._mainProvider) : super(SubscriptionHistoryInitial()) {
    fetSubscriptions();
  }

  Future<void> fetSubscriptions() async {
    emit(SubscriptionHistoryLoading());
    final res = await _mainProvider.getSubscriptionHistory();
    final data = res.data;
    if (data != null) {
      emit(SubscriptionHistoryLoaded(data));
    } else {
      emit(SubscriptionHistoryError(res.message));
    }
  }
}
