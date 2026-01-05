part of 'training_history_cubit.dart';

sealed class TrainingHistoryState {
  const TrainingHistoryState();
}

final class TrainingHistoryInitial extends TrainingHistoryState {
  const TrainingHistoryInitial();
}

final class TrainingHistoryLoading extends TrainingHistoryState {
  const TrainingHistoryLoading();
}

final class TrainingHistoryLoaded extends TrainingHistoryState {
  final List<TrainingHistoryResponse> trainingHistory;
  const TrainingHistoryLoaded(this.trainingHistory);
}

final class TrainingHistoryError extends TrainingHistoryState {
  final String? message;
  const TrainingHistoryError(this.message);
}
