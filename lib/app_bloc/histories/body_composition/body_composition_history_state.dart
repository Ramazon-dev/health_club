part of 'body_composition_history_cubit.dart';

sealed class BodyCompositionHistoryState {
  const BodyCompositionHistoryState();
}

final class BodyCompositionHistoryInitial extends BodyCompositionHistoryState {
  const BodyCompositionHistoryInitial();
}

final class BodyCompositionHistoryLoading extends BodyCompositionHistoryState {
  const BodyCompositionHistoryLoading();
}

final class BodyCompositionHistoryLoaded extends BodyCompositionHistoryState {
  final List<BodyCompositionHistoryResponse> bodyCompositionHistory;
  const BodyCompositionHistoryLoaded(this.bodyCompositionHistory);
}

final class BodyCompositionHistoryError extends BodyCompositionHistoryState {
  final String? message;
  const BodyCompositionHistoryError(this.message);
}
