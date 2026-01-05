part of 'payment_history_cubit.dart';

sealed class PaymentHistoryState {
  const PaymentHistoryState();
}

final class PaymentHistoryInitial extends PaymentHistoryState {
  const PaymentHistoryInitial();
}

final class PaymentHistoryLoading extends PaymentHistoryState {
  const PaymentHistoryLoading();
}

final class PaymentHistoryLoaded extends PaymentHistoryState {
  final List<PaymentHistoryResponse> paymentHistory;
  const PaymentHistoryLoaded(this.paymentHistory);
}

final class PaymentHistoryError extends PaymentHistoryState {
  final String message;
  const PaymentHistoryError(this.message);
}
