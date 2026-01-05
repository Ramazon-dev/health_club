import 'package:health_club/data/network/model/clubs_response.dart';
import 'package:health_club/data/network/model/auth/verify_result.dart';
import '../../../domain/core/core.dart';
import '../model/auth/login_response.dart';
import '../model/auth/wizard_options_response.dart';
import '../model/auth/wizard_response.dart';

abstract class AuthProvider extends BaseProvider {
  Future<ApiResponse<LoginResponse>> login(String phone);

  Future<ApiResponse<VerifyResponse>> verify(String code);

  Future<ApiResponse<WizardResponse>> wizardGet();

  Future<ApiResponse<bool>> wizardPush(int step, Map<String, dynamic> json);

  Future<ApiResponse<WizardOptionsResponse>> wizardGetStep(int step);

  Future<ApiResponse<ClubsResponse>> wizardClubs();

  Future<ApiResponse<bool>> wizardSkip();

  // Future<ApiResponse<bool>> wizardPushStep(int step, String text);
  //
  // Future<ApiResponse<bool>> wizardPushAddress(int step, String address);
  //
  // Future<ApiResponse<bool>> wizardPushDetail(int step, String height, String width, String birthDate, String gender);
}
