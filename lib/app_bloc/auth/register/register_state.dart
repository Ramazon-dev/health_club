part of 'register_cubit.dart';

sealed class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterName extends RegisterState {
  const RegisterName();
}

class RegisterConcerns extends RegisterState {
  const RegisterConcerns();
}

class RegisterProblems extends RegisterState {
  const RegisterProblems();
}

class RegisterBodyDetails extends RegisterState {
  const RegisterBodyDetails();
}

class RegisterBodyDetailsResult extends RegisterState {
  const RegisterBodyDetailsResult();
}

class RegisterTarget extends RegisterState {
  const RegisterTarget();
}

class RegisterAddress extends RegisterState {
  const RegisterAddress();
}

class RegisterDiagnostics extends RegisterState {
  const RegisterDiagnostics();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);
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