import 'package:dio/dio.dart';
import 'package:health_club/data/network/model/clubs_response.dart';
import 'package:health_club/domain/core/core.dart';

import '../model/auth/login_response.dart';
import '../model/auth/verify_result.dart';
import '../model/auth/wizard_options_response.dart';
import '../model/auth/wizard_response.dart';
import 'auth_provider.dart';

class AuthProviderImpl extends AuthProvider {
  final Dio dio;

  AuthProviderImpl(this.dio);

  @override
  Future<ApiResponse<LoginResponse>> login(String phone, String? password) async {
    final map = <String, dynamic>{};
    if (password != null) map['password'] = password;
    map['phone'] = phone;

    return apiCall(dio.post(Endpoints.login, data: map), dataFromJson: (data) => LoginResponse.fromJson(data));
    // try {
    //   final res = await dio.post(Endpoints.login, data: {'phone': phone});
    //   if (res.statusCode == 200 || res.statusCode == 201) {
    //     print('object verify response is ${res.data}');
    //   }
    // } on DioException catch (e) {
    //   print('object verify DioException e response ${e.response}');
    //   print('object verify DioException e type ${e.type}');
    //   print('object verify DioException e message ${e.message}');
    // }
  }

  @override
  Future<ApiResponse<VerifyResponse>> verify(String code) async {
    return apiCall(
      dio.post(Endpoints.code, data: {'code': code}),
      dataFromJson: (data) => VerifyResponse.fromJson(data),
    );
    // try {
    //   final res = await dio.post(Endpoints.code,data: {'code': code});
    //   if (res.statusCode == 200 || res.statusCode == 201) {
    //     print('object verify response is ${res.data}');
    //     return
    //   }
    // } on DioException catch (e) {
    //   print('object verify DioException e response ${e.response}');
    //   print('object verify DioException e type ${e.type}');
    //   print('object verify DioException e message ${e.message}');
    // }
  }

  @override
  Future<ApiResponse<bool>> wizardPush(int step, Map<String, dynamic> json) {
    return apiCall(dio.post(Endpoints.wizardStep(step), data: json), dataFromJson: (data) => true);
  }

  @override
  Future<ApiResponse<bool>> wizardSkip() {
    return apiCall(dio.post(Endpoints.wizardSkip), dataFromJson: (data) => true);
  }

  // @override
  // Future<ApiResponse<bool>> wizardPushStep(int step, String text) {
  //   return apiCall(dio.post(Endpoints.wizardStep(step), data: {'text': text}), dataFromJson: (data) => true);
  // }
  //
  // @override
  // Future<ApiResponse<bool>> wizardPushAddress(int step, String address) {
  //   return apiCall(dio.post(Endpoints.wizardStep(step), data: {'address': address}), dataFromJson: (data) => true);
  // }
  //
  // @override
  // Future<ApiResponse<bool>> wizardPushDetail(int step, String height, String width, String birthDate, String gender) {
  //   return apiCall(
  //     dio.post(
  //       Endpoints.wizardStep(step),
  //       data: {'height': height, 'width': width, 'birthday': birthDate, 'gender': gender},
  //     ),
  //     dataFromJson: (data) => true,
  //   );
  // }

  @override
  Future<ApiResponse<WizardResponse>> wizardGet() {
    return apiCall(dio.get(Endpoints.wizard), dataFromJson: (data) => WizardResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<WizardOptionsResponse>> wizardGetStep(int step) {
    return apiCall(dio.get(Endpoints.wizardStep(step)), dataFromJson: (data) => WizardOptionsResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<ClubsResponse>> wizardClubs() {
    return apiCall(dio.get(Endpoints.wizardStep(7)), dataFromJson: (data) => ClubsResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<List<String>>> wizardSlots(int placeId, String day) {
    return apiCall(
      dio.get(Endpoints.wizardSlots, data: {'place_id': placeId, 'date': day}),
      dataFromJson: (data) {
        print('object dataFromJson ${data["slots"].runtimeType}');
        return (data['slots'] as List).map((e) => e.toString()).toList();
      },
    );
  }

  @override
  Future<ApiResponse<num?>> getBmi() {
    return apiCall(dio.get(Endpoints.wizardStep(4)), dataFromJson: (data) => (data['data']['bmi'] as num));
  }
}
