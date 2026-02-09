part of 'slots_cubit.dart';

sealed class SlotsState {
  const SlotsState();
}

final class SlotsInitial extends SlotsState {
  const SlotsInitial();
}

final class SlotsLoading extends SlotsState {
  const SlotsLoading();
}

final class SlotsLoaded extends SlotsState {
  final List<SlotResponse> slots;
  const SlotsLoaded(this.slots);
}

final class SlotsError extends SlotsState {
  final String message;
  const SlotsError(this.message);
}
