import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterInitial());

  void changeToName() {
    emit(RegisterName());
  }

  void changeToConcerns() {
    emit(RegisterConcerns());
  }

  void changeToProblems() {
    emit(RegisterProblems());
  }

  void changeToBodyDetails() {
    emit(RegisterBodyDetails());
  }

  void changeToBodyDetailsResult() {
    emit(RegisterBodyDetailsResult());
  }

  void changeToTarget() {
    emit(RegisterTarget());
  }

  void changeToAddress() {
    emit(RegisterAddress());
  }

  void changeToDiagnostics() {
    emit(RegisterDiagnostics());
  }

  void changeToSuccess() {
    emit(RegisterSuccess());
  }

  void changeToInitial() {
    emit(RegisterInitial());
  }

  // void changeName(String name) {
  //   emit(state.copyWith(name: name));
  // }
  //
  // void changeGender(bool isMale) {
  //   emit(state.copyWith(isMale: isMale));
  // }
  //
  // void changeConcern(String concern) {
  //   emit(state.copyWith(concern: concern));
  // }
  //
  // void changeProblem(String problem) {
  //   emit(state.copyWith(problem: problem));
  // }
  //
  // void changeBodyDetail(BodyDetails body) {
  //   emit(
  //     state.copyWith(
  //       bodyDetails: BodyDetails(
  //         height: body.height,
  //         width: body.width,
  //         birthDate: body.birthDate,
  //         gender: body.gender,
  //       ),
  //     ),
  //   );
  // }
  //
  // void changeBirthDate(DateTime birthDate) {
  //   emit(state.copyWith(birthDate: birthDate));
  // }
  //
  // void scrollDown(bool scrollDown) {
  //   emit(state.copyWith(scrollDown: scrollDown));
  // }
}
