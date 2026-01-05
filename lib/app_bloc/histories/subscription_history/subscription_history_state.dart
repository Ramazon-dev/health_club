part of 'subscription_history_cubit.dart';

sealed class SubscriptionHistoryState {
  const SubscriptionHistoryState();
}

final class SubscriptionHistoryInitial extends SubscriptionHistoryState {
  const SubscriptionHistoryInitial();
}

final class SubscriptionHistoryLoading extends SubscriptionHistoryState {
  const SubscriptionHistoryLoading();
}

final class SubscriptionHistoryLoaded extends SubscriptionHistoryState {
  final List<SubscriptionHistoryResponse> subscriptionHistory;
  const SubscriptionHistoryLoaded(this.subscriptionHistory);
}

final class SubscriptionHistoryError extends SubscriptionHistoryState {
  final String? message;
  const SubscriptionHistoryError(this.message);
}
