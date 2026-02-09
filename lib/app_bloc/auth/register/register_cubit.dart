import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_club/di/init.dart';
import 'package:health_club/domain/core/core.dart';
import 'package:health_club/router/app_router.dart';
import '../../../data/network/model/clubs_response.dart';
import '../../../data/network/model/auth/wizard_options_response.dart';
import '../../../data/network/model/auth/wizard_response.dart';
import '../../../data/network/provider/auth_provider.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthProvider authProvider;

  RegisterCubit(this.authProvider) : super(RegisterName(null));

  WizardResponse? _wizardResponse;
  List<WizardOptionResponse> concerns = [];
  List<WizardOptionResponse> problems = [];
  List<WizardOptionResponse> targets = [];
  List<ClubResponse> clubs = [];
  num bmi = 0;

  Future<void> getWizard(int step) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardGet();
    if (res.data != null) {
      _wizardResponse = res.data;
      bmi = res.data?.user?.bmi ?? 0;
      final wizardStep = res.data?.step;
      emit(RegisterName(_wizardResponse));
      initializeWizardStep(wizardStep ?? step);
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  void changeToName() {
    emit(RegisterName(_wizardResponse));
  }

  Future<void> uploadName({required String name, required String surname}) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(1, {'name': name, 'surname': surname});
    if (res.data != null) {
      final options = await getWizardOptions(2);
      if (options != null) {
        concerns = options;
        emit(RegisterConcerns(_wizardResponse, passed: true, options: options));
      }
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadConcern(List<String> concerns, String customText) async {
    emit(RegisterLoading(_wizardResponse));
    final map = <String, dynamic>{};
    if (concerns.isNotEmpty) map['selected'] = concerns;
    if (customText.isNotEmpty) map['custom_text'] = customText;
    final res = await authProvider.wizardPush(2, map);
    if (res.data != null) {
      final options = await getWizardOptions(3);
      if (options != null) {
        problems = options;
        emit(RegisterProblems(_wizardResponse, passed: true, options: options));
      }
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadProblem(List<String> problem, String customText) async {
    emit(RegisterLoading(_wizardResponse));
    final map = <String, dynamic>{};
    if (problem.isNotEmpty) map['selected'] = problem;
    if (customText.isNotEmpty) map['custom_text'] = customText;

    final res = await authProvider.wizardPush(3, map);
    if (res.data != null) {
      emit(RegisterBodyDetails(_wizardResponse));
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
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
      'gender': gender ? 'M' : 'W',
    });
    if (res.data != null) {
      final bmiRes = await authProvider.getBmi();
      final bmi = bmiRes.data;
      if (bmi != null) {
        this.bmi = bmi;
        emit(RegisterBodyDetailsResult(_wizardResponse, bmi));
      } else {
        getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      }
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  void changeToGift() {
    emit(RegisterGift(_wizardResponse));
  }

  Future<void> getTargets() async {
    emit(RegisterLoading(_wizardResponse));
    final options = await getWizardOptions(5);
    if (options != null) {
      targets = options;
      emit(RegisterTarget(_wizardResponse, passed: true, options: options));
    }
  }

  Future<void> uploadTarget(List<String> targets, String customText) async {
    emit(RegisterLoading(_wizardResponse));
    final map = <String, dynamic>{};
    if (targets.isNotEmpty) map['selected'] = targets;
    if (customText.isNotEmpty) map['custom_text'] = customText;
    final res = await authProvider.wizardPush(5, map);
    if (res.data != null) {
      emit(RegisterAddress(_wizardResponse));
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
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
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> uploadDiagnostic({required int placeId, required String date, required String time}) async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardPush(7, {'place_id': placeId, 'date': date, 'time': time});
    if (res.data != null) {
      emit(RegisterSuccess(_wizardResponse));
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<void> skip() async {
    emit(RegisterLoading(_wizardResponse));
    final res = await authProvider.wizardSkip();
    if (res.data != null) {
      final clubs = await getWizardClubs();
      if (clubs != null) {
        this.clubs = clubs;
        emit(RegisterSkipped(_wizardResponse));
      }
    } else {
      getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
      // emit(RegisterError(_wizardResponse, res.message));
    }
  }

  Future<List<ClubResponse>?> getWizardClubs() async {
    final res = await authProvider.wizardClubs();
    final clubs = res.data?.clubs;
    if (clubs != null) return clubs;
    getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(res.message);
    // emit(RegisterError(_wizardResponse, res.message));
    return null;
  }

  Future<List<WizardOptionResponse>?> getWizardOptions(int step) async {
    final wizardOptionsResponse = await authProvider.wizardGetStep(step);
    final options = wizardOptionsResponse.data?.options;
    if (options != null) return options;
    getIt<AppRouter>().navigatorKey.currentContext?.showSnackBar(wizardOptionsResponse.message);
    // emit(RegisterError(_wizardResponse, wizardOptionsResponse.message));
    return null;
  }

  //////////////////////////// back functions

  Future<void> changeToConcerns({String? name}) async {
    final options = await getWizardOptions(2);
    if (options != null) {
      concerns = options;
      emit(RegisterConcerns(_wizardResponse, passed: true, options: options));
    }
  }

  Future<void> changeToProblems() async {
    final options = await getWizardOptions(3);
    if (options != null) {
      problems = options;
      emit(RegisterProblems(_wizardResponse, passed: true, options: options));
    }
  }

  Future<void> changeToBodyDetails() async {
    emit(RegisterBodyDetails(_wizardResponse));
  }

  Future<void> changeToBodyDetailsResult() async {
    emit(RegisterBodyDetailsResult(_wizardResponse, bmi));
  }

  Future<void> changeToTarget() async {
    final options = await getWizardOptions(5);
    if (options != null) {
      targets = options;
      emit(RegisterTarget(_wizardResponse, passed: true, options: options));
    }
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
    emit(RegisterName(_wizardResponse));
    // getWizard();
  }

  Future<void> initializeWizardStep(int step) async {
    if (step == 1) {
      emit(RegisterName(_wizardResponse));
    } else if (step == 2) {
      final options = await getWizardOptions(2);
      if (options != null) {
        concerns = options;
        emit(RegisterConcerns(_wizardResponse, passed: true, options: options));
      } else {
        emit(RegisterName(_wizardResponse));
        // emit(RegisterInitial(_wizardResponse));
      }
    } else if (step == 3) {
      final options = await getWizardOptions(3);
      if (options != null) {
        problems = options;
        emit(RegisterProblems(_wizardResponse, passed: true, options: options));
      } else {
        emit(RegisterName(_wizardResponse));
        // emit(RegisterInitial(_wizardResponse));
      }
    } else if (step == 4) {
      emit(RegisterBodyDetails(_wizardResponse));
    } else if (step == 5) {
      final options = await getWizardOptions(5);
      if (options != null) {
        targets = options;
        emit(RegisterTarget(_wizardResponse, passed: true, options: options));
      } else {
        emit(RegisterName(_wizardResponse));
        // emit(RegisterInitial(_wizardResponse));
      }
    } else if (step == 6) {
      emit(RegisterAddress(_wizardResponse));
    } else if (step == 7) {
      final clubs = await getWizardClubs();
      if (clubs != null) {
        this.clubs = clubs;
        emit(RegisterDiagnostics(_wizardResponse, clubs: clubs));
      } else {
        emit(RegisterName(_wizardResponse));
        // emit(RegisterInitial(_wizardResponse));
      }
    }
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
