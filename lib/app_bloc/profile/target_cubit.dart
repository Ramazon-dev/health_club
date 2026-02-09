import '../../data/network/model/auth/wizard_options_response.dart';
import '../../data/network/provider/auth_provider.dart';
import '../app_bloc.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  final AuthProvider _authProvider;

  TargetCubit(this._authProvider) : super(TargetInitial()) {
    fetchTargets();
  }

  Future<void> fetchTargets() async {
    emit(TargetLoading());
    final res = await _authProvider.wizardGetStep(5);
    final options = res.data?.options;
    if (options != null) {
      emit(TargetLoaded(options));
    } else {
      emit(TargetError(res.message));
    }
  }

  Future<void> uploadTarget({List<String>? selectedTargets, String? customText}) async {
    emit(TargetLoading());
    final map = <String, dynamic>{};
    if (selectedTargets != null) map['selected'] = selectedTargets;
    if (customText != null) map['custom_text'] = customText;

    final res = await _authProvider.wizardPush(5, map);
    if (res.data != null) {
      emit(TargetSuccess());
    } else {
      emit(TargetError(res.message));
    }
  }
}
