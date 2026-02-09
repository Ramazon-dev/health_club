import 'dart:io';
import 'package:health_club/data/network/model/profile_request.dart';
import 'package:health_club/data/network/model/profile_response.dart';

import '../../data/network/model/user_country_enum.dart';
import '../../data/network/provider/main_provider.dart';
import '../../data/storage/local_storage.dart';
import '../app_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MainProvider _mainProvider;
  final LocalStorage localStorage;

  ProfileCubit(this._mainProvider, this.localStorage) : super(ProfileInitial()) {
    fetchProfile();
  }

  String get phonePrefix {
    if (localStorage.getCountry() == AppCountryEnum.uz.name) {
      return AppCountryEnum.uz.phonePrefix;
    } else {
      return AppCountryEnum.kz.phonePrefix;
    }
  }

  bool get selectedCountryUz {
    return localStorage.getCountry() == AppCountryEnum.uz.name;
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
