part of 'first_trainings_cubit.dart';

sealed class FirstTrainingsState {
  const FirstTrainingsState();
}

final class FirstTrainingsInitial extends FirstTrainingsState {
  const FirstTrainingsInitial();
}

final class FirstTrainingsLoading extends FirstTrainingsState {
  const FirstTrainingsLoading();
}

final class FirstTrainingsLoaded extends FirstTrainingsState {
  final List<FirstTrainingResponse> trainings;
  const FirstTrainingsLoaded(this.trainings);
}

final class FirstTrainingsError extends FirstTrainingsState {
  final String? message;
  const FirstTrainingsError(this.message);
}
