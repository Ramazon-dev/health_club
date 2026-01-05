import 'dart:io';
import 'package:health_club/data/network/model/profile_request.dart';
import 'package:health_club/data/network/model/profile_response.dart';

import '../../data/network/provider/main_provider.dart';
import '../app_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MainProvider _mainProvider;

  ProfileCubit(this._mainProvider) : super(ProfileInitial()) {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final res = await _mainProvider.getProfile();
    final profile = res.data;
    if (profile != null) {
      emit(ProfileLoaded(profile));
    } else {
      emit(ProfileError(res.message));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String surname,
    required String phone,
    String? birthday,
    String? email,
    File? file,
  }) async {
    final res = await _mainProvider.updateProfile(
      ProfileRequest(name: name, surname: surname, phone: phone, birthday: birthday, email: email),
      file,
    );
    final profile = res.data;
    if (profile != null) {
      fetchProfile();
    } else {
      emit(ProfileError(res.message));
    }
  }
}
