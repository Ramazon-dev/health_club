import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/network/model/clubs_response.dart';
import '../../../data/network/model/auth/wizard_options_response.dart';
import '../../../data/network/model/auth/wizard_response.dart';
import '../../../data/network/provider/auth_provider.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthProvider authProvider;

  RegisterCubit(this.authProvider) : super(RegisterInitial(null)) {
    getWizard();
  }

  WizardResponse? _wizardResponse;
  List<WizardOptionResponse> concerns = [];
  List<WizardOptionResponse> problems = [];
  List<WizardOptionResponse> targets = [];
  List<ClubResponse> clubs = [];

  Future<void> getWizard() async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardGet();
    if (res.data != null) {
      _wizardResponse = res.data;
      emit(RegisterInitial(_wizardResponse));
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  void changeToName() {
    emit(RegisterName(_wizardResponse));
  }

  Future<void> uploadName(String name) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(1, {'name': name});
    if (res.data != null) {
      final options = await getWizardOptions(2);
      if (options != null) {
        concerns = options;
        emit(RegisterConcerns(_wizardResponse, passed: true, options: options));
      }
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadConcern(String concern) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(2, {'text': concern});
    if (res.data != null) {
      final options = await getWizardOptions(3);
      if (options != null) {
        problems = options;
        emit(RegisterProblems(_wizardResponse, passed: true, options: options));
      }
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadProblem(String problem) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(3, {'text': problem});
    if (res.data != null) {
      emit(RegisterBodyDetails(_wizardResponse));
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadBodyDetails({
    required String height,
    required String width,
    required String birthday,
    required bool gender,
  }) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(4, {
      'height': int.parse(height),
      'weight': int.parse(width),
      'birthday': birthday,
      'gender': gender ? 'M' : 'F',
    });
    if (res.data != null) {
      emit(RegisterBodyDetailsResult(_wizardResponse));
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> getTargets() async {
    emit(RegisterLoading(_wizardResponse));
    final options = await getWizardOptions(5);
    if (options != null) {
      targets = options;
      emit(RegisterTarget(_wizardResponse, passed: true, options: options));
    }
  }

  Future<void> uploadTarget(String target) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(5, {'text': target});
    if (res.data != null) {
      emit(RegisterAddress(_wizardResponse));
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadAddress(String address) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(6, {'address': address});
    if (res.data != null) {
      final clubs = await getWizardClubs();
      if (clubs != null) {
        this.clubs = clubs;
        emit(RegisterDiagnostics(_wizardResponse, clubs: clubs));
      }
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadDiagnostic({
    required String surname,
    required int placeId,
    required String date,
    required String time,
  }) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(7, {
      'surname': surname,
      'place_id': placeId,
      'date': date,
      'time': time,
    });
    if (res.data != null) {
      emit(RegisterSuccess(_wizardResponse));
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> skip() async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardSkip();
    if (res.data != null) {
      final clubs = await getWizardClubs();
      if (clubs != null) {
        this.clubs = clubs;
        emit(RegisterDiagnostics(_wizardResponse, clubs: clubs));
      }
    } else {
      emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<List<ClubResponse>?> getWizardClubs() async {
    final res = await authProvider.wizardClubs();
    final clubs = res.data?.clubs;
    if (clubs != null) return clubs;
    emit(RegisterError(_wizardResponse, res.message));
    return null;
  }

  Future<List<WizardOptionResponse>?> getWizardOptions(int step) async {
    final wizardOptionsResponse = await authProvider.wizardGetStep(step);
    final options = wizardOptionsResponse.data?.options;
    if (options != null) return options;
    emit(RegisterError(_wizardResponse, wizardOptionsResponse.message));
    return null;
  }

  //////////////////////////// back functions

  Future<void> changeToConcerns({String? name}) async {
    emit(RegisterConcerns(_wizardResponse, options: concerns));
  }

  Future<void> changeToProblems() async {
      emit(RegisterProblems(_wizardResponse, options: problems));
  }

  Future<void> changeToBodyDetails() async {
      emit(RegisterBodyDetails(_wizardResponse));
  }

  Future<void> changeToBodyDetailsResult() async {
    emit(RegisterBodyDetailsResult(_wizardResponse));
  }

  void changeToTarget() {
    emit(RegisterTarget(_wizardResponse, options: targets));
  }

  Future<void> changeToAddress({String? target}) async {
    emit(RegisterAddress(_wizardResponse));
  }

  Future<void> changeToDiagnostics({String? address}) async {
      emit(RegisterDiagnostics(_wizardResponse, clubs: clubs));
  }

  // void changeToSuccess() {
  //   emit(RegisterSuccess(_wizardResponse));
  // }
  //
  void changeToInitial() {
    emit(RegisterInitial(_wizardResponse));
    // getWizard();
  }

  // Future<void> registerName(String name) async {
  //   emit(RegisterLoading(_verifyResponse));
  //   final res = await authProvider.wizardPushName(1, name);
  //   if (res.data != null) {
  //     emit(RegisterConcerns(_verifyResponse,passed: true));
  //   } else {
  //     emit(RegisterError(_verifyResponse, res.message));
  //   }
  //
  // }
}
