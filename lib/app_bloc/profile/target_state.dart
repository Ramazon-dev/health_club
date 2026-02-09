part of 'target_cubit.dart';

sealed class TargetState {
  const TargetState();
}

final class TargetInitial extends TargetState {
  const TargetInitial();
}

final class TargetLoading extends TargetState {
  const TargetLoading();
}

final class TargetLoaded extends TargetState {
  final List<WizardOptionResponse> targets;
  const TargetLoaded(this.targets);
}

final class TargetSuccess extends TargetState {
  const TargetSuccess();
}

final class TargetError extends TargetState {
  final String? message;
  const TargetError(this.message);
}
