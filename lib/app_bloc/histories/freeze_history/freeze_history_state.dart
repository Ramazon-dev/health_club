part of 'freeze_history_cubit.dart';

sealed class FreezeHistoryState {
  const FreezeHistoryState();
}

final class FreezeHistoryInitial extends FreezeHistoryState {
  const FreezeHistoryInitial();
}

final class FreezeHistoryLoading extends FreezeHistoryState {
  const FreezeHistoryLoading();
}

final class FreezeHistoryLoaded extends FreezeHistoryState {
  final List<FreezeHistoryResponse> freezeHistory;
  const FreezeHistoryLoaded(this.freezeHistory);
}

final class FreezeHistoryError extends FreezeHistoryState {
  final String? message;
  const FreezeHistoryError(this.message);
}
