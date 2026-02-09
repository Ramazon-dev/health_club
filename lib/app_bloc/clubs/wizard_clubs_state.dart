part of 'wizard_clubs_cubit.dart';

sealed class WizardClubsState {
  const WizardClubsState();
}

final class WizardClubsInitial extends WizardClubsState {
  const WizardClubsInitial();
}

final class WizardClubsLoading extends WizardClubsState {
  const  WizardClubsLoading();
}

final class WizardClubsLoaded extends WizardClubsState {
  final List<ClubResponse> wizardClubs;
  const WizardClubsLoaded(this.wizardClubs);
}

final class WizardClubsError extends WizardClubsState {
  final String? message;
  const WizardClubsError(this.message);
}
