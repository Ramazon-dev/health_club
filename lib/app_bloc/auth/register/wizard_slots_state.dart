part of 'wizard_slots_cubit.dart';

sealed class WizardSlotsState {
  const WizardSlotsState();
}

final class WizardSlotsInitial extends WizardSlotsState {
  const WizardSlotsInitial();
}

final class WizardSlotsLoading extends WizardSlotsState {
  const WizardSlotsLoading();
}

final class WizardSlotsLoaded extends WizardSlotsState {
  final List<String> slots;
  const WizardSlotsLoaded(this.slots);
}

final class WizardSlotsError extends WizardSlotsState {
  final String? message;
  const WizardSlotsError(this.message);
}
