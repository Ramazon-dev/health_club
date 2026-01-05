part of 'register_cubit.dart';

sealed class RegisterState {
  final WizardResponse? wizard;
  const RegisterState(this.wizard);
}

class RegisterInitial extends RegisterState {
  const RegisterInitial(super.wizard);
}

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
  const RegisterBodyDetailsResult(super.wizard, {this.passed = false});
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

class RegisterError extends RegisterState {
  final String message;
  const RegisterError(super.wizard, this.message);
}


// final bool loading;
// final String? name;
// final String? concern;
// final String? problem;
// final DateTime? birthDate;
// final bool? isMale;
// final bool scrollDown;
// final BodyDetails? bodyDetails;
//
// RegisterState({
//   this.loading = false,
//   this.name,
//   this.concern,
//   this.problem,
//   this.birthDate,
//   this.isMale,
//   this.scrollDown = false,
//   this.bodyDetails,
// });
//
// RegisterState copyWith({
//   bool? loading,
//   String? name,
//   String? concern,
//   String? problem,
//   DateTime? birthDate,
//   bool? isMale,
//   bool? scrollDown,
//   BodyDetails? bodyDetails,
// }) {
//   return RegisterState(
//     loading: loading ?? this.loading,
//     birthDate: birthDate ?? this.birthDate,
//     isMale: isMale ?? this.isMale,
//     name: name ?? this.name,
//     concern: concern ?? this.concern,
//     problem: problem ?? this.problem,
//     scrollDown: scrollDown ?? this.scrollDown,
//     bodyDetails: bodyDetails ?? this.bodyDetails,
//   );
// }