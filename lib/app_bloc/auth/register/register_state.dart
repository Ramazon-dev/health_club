part of 'register_cubit.dart';

sealed class RegisterState {
  final WizardResponse? wizard;
  const RegisterState(this.wizard);
}

// class RegisterInitial extends RegisterState {
//   const RegisterInitial(super.wizard);
// }

class RegisterLoading extends RegisterState {
  const RegisterLoading(super.wizard);
}

class RegisterName extends RegisterState {
  final bool passed;
  const RegisterName(super.wizard, {this.passed = false});
}

class RegisterConcerns extends RegisterState {
  final bool passed;
  final List<WizardOptionResponse> options;
  const RegisterConcerns(super.wizard, {this.passed = false, required this.options});
}

class RegisterProblems extends RegisterState {
  final bool passed;
  final List<WizardOptionResponse> options;
  const RegisterProblems(super.wizard, {this.passed = false, required this.options});
}

class RegisterBodyDetails extends RegisterState {
  final bool passed;
  const RegisterBodyDetails(super.wizard, {this.passed = false});
}

class RegisterBodyDetailsResult extends RegisterState {
  final bool passed;
  final num bmi;
  const RegisterBodyDetailsResult(super.wizard, this.bmi, {this.passed = false});
}

class RegisterGift extends RegisterState {
  const RegisterGift(super.wizard);
}

class RegisterTarget extends RegisterState {
  final bool passed;
  final List<WizardOptionResponse> options;
  const RegisterTarget(super.wizard, {this.passed = false, required this.options});
}

class RegisterAddress extends RegisterState {
  final bool passed;
  const RegisterAddress(super.wizard, {this.passed = false});
}

class RegisterDiagnostics extends RegisterState {
  final bool passed;
  final List<ClubResponse> clubs;
  const RegisterDiagnostics(super.wizard, {this.passed = false, required this.clubs});
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess(super.wizard);
}

class RegisterSkipped extends RegisterState {
  const RegisterSkipped(super.wizard);
}
//
// class RegisterError extends RegisterState {
//   final String message;
//   const RegisterError(super.wizard, this.message);
// }
