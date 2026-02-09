import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:health_club/data/network/model/calendar_response.dart';
import 'package:health_club/data/network/model/daily_metrics_response.dart';
import 'package:health_club/data/network/model/dashboard_metrics_response.dart';
import 'package:health_club/data/network/model/forecast_response.dart';
import 'package:health_club/data/network/model/history/body_composition_response.dart';
import 'package:health_club/data/network/model/history/freeze_history_response.dart';
import 'package:health_club/data/network/model/history/metric_history_response.dart';
import 'package:health_club/data/network/model/history/payment_history_response.dart';
import 'package:health_club/data/network/model/history/subscription_history_response.dart';
import 'package:health_club/data/network/model/history/training_history_response.dart';
import 'package:health_club/data/network/model/map/map_detail_response.dart';
import 'package:health_club/data/network/model/map/map_point_response.dart';
import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import 'package:health_club/data/network/model/profile_response.dart';
import 'package:health_club/data/network/model/slot_response.dart';
import 'package:health_club/data/network/model/user_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../../../domain/core/core.dart';
import '../model/check_qr_response.dart';
import '../model/first_training_response.dart';
import '../model/profile_request.dart';

class MainProviderImpl extends MainProvider {
  final Dio dio;

  MainProviderImpl(this.dio);

  @override
  Future<ApiResponse<bool>> updateProfile(ProfileRequest profileRequest, File? avatar) async {
    if (avatar != null) {
      String fileName = avatar.path.split('/').last;
      final file = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(avatar.path, filename: fileName),
        ...profileRequest.toJson(),
      });
      return apiCall(dio.post(Endpoints.profile, data: file), dataFromJson: (data) => true);
    }
    return apiCall(dio.post(Endpoints.profile, data: profileRequest.toJson()), dataFromJson: (data) => true);
  }

  @override
  Future<ApiResponse<ProfileResponse>> getProfile() {
    return apiCall(dio.get(Endpoints.profile), dataFromJson: (data) => ProfileResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<UserMeResponse>> getUser() async {
    return apiCall(dio.get(Endpoints.userMe), dataFromJson: (data) => UserMeResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<bool>> changePassword(String password, String confirmationPassword) {
    return apiCall(
      dio.put(Endpoints.password, data: {'password': password, 'password_confirmation': confirmationPassword}),
      dataFromJson: (data) => true,
    );
  }

  @override
  Future<ApiResponse<List<FirstTrainingResponse>>> getPlanedFirstTrainings() {
    return apiCall(
      dio.get(Endpoints.trainings),
      dataFromJson: (data) => (data['data'] as List).map((e) => FirstTrainingResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<List<PaymentHistoryResponse>>> getPaymentHistory() {
    return apiCall(
      dio.get(Endpoints.paymentsHistory),
      dataFromJson: (data) => (data as List).map((e) => PaymentHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<List<FreezeHistoryResponse>>> getFreezeHistory() {
    return apiCall(
      dio.get(Endpoints.freezesHistory),
      dataFromJson: (data) => (data as List).map((e) => FreezeHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<bool>> freezeSubscription(int days, String startDate) {
    return apiCall(
      dio.post(Endpoints.freeze, data: {'days': days, 'start_date': startDate}),
      dataFromJson: (data) => true,
    );
  }

  @override
  Future<ApiResponse<List<SubscriptionHistoryResponse>>> getSubscriptionHistory() {
    return apiCall(
      dio.get(Endpoints.subscriptionsHistory),
      dataFromJson: (data) => (data as List).map((e) => SubscriptionHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<List<BodyCompositionHistoryResponse>>> getBodyCompositionHistory() {
    return apiCall(
      dio.get(Endpoints.measuresHistory),
      dataFromJson: (data) => (data as List).map((e) => BodyCompositionHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<List<TrainingHistoryResponse>>> getTrainingHistory() {
    return apiCall(
      dio.get(Endpoints.trainingHistory),
      dataFromJson: (data) => (data as List).map((e) => TrainingHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<CalendarResponse>> getCalendar() {
    return apiCall(dio.get(Endpoints.calendar), dataFromJson: (data) => CalendarResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<DailyMetricsResponse>> getDailyMetrics() {
    return apiCall(dio.get(Endpoints.dailyMetrics), dataFromJson: (data) => DailyMetricsResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<bool>> updateMetrics({
    int? water,
    double? sleepHours,
    String? sleepStart,
    String? sleepEnd,
    int? steps,
  }) {
    final map = <String, dynamic>{};
    if (water != null) map['water_ml'] = water;
    if (sleepHours != null) map['sleep_hours'] = sleepHours;
    if (sleepStart != null) map['sleep_start'] = sleepStart;
    if (sleepEnd != null) map['sleep_end'] = sleepEnd;
    if (steps != null) map['steps'] = steps;
    return apiCall(dio.post(Endpoints.metrics, data: map), dataFromJson: (data) => true);
  }

  @override
  Future<ApiResponse<DashboardMetricsResponse>> getDashboardMetrics() {
    return apiCall(
      dio.get(Endpoints.dashboardMetrics),
      dataFromJson: (data) => DashboardMetricsResponse.fromJson(data),
    );
  }

  @override
  Future<ApiResponse<List<MetricHistoryResponse>>> getMetricsHistory(String type) {
    return apiCall(
      dio.get(Endpoints.metricsHistory, queryParameters: {'type': type}),
      dataFromJson: (data) => (data as List).map((e) => MetricHistoryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<NutritionDiaryResponse>> getNutritionDay() {
    return apiCall(dio.get(Endpoints.nutritionDiary), dataFromJson: (data) => NutritionDiaryResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<bool>> uploadNutrition({
    required File image,
    required String type,
    required String title,
    required String text,
  }) async {
    final map = <String, dynamic>{};
    if (title.isNotEmpty) map['title'] = title;
    if (text.isNotEmpty) map['text'] = text;
    String fileName = image.path.split('/').last;
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: fileName),
      'type': type,
      ...map,
      // 'title': title,
      // 'text': text,
    });
    return apiCall(
      dio.post(
        Endpoints.nutritionUploadAnalyze,
        // data: {'image': image, 'type': type},
        data: formData,
      ),
      dataFromJson: (data) => true,
    );
  }

  @override
  Future<ApiResponse<bool>> getNutritionAnalyze() {
    return apiCall(dio.post(Endpoints.nutritionAnalyze), dataFromJson: (data) => true);
  }

  @override
  Future<ApiResponse<List<NutritionDiaryResponse>>> getNutritionHistory() {
    return apiCall(
      dio.get(Endpoints.nutritionHistory),
      dataFromJson: (data) => (data as List).map((e) => NutritionDiaryResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<List<MapPointResponse>>> getMapPoints() {
    return apiCall(
      dio.get(Endpoints.map),
      dataFromJson: (data) => (data['data'] as List).map((e) => MapPointResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<MapDetailResponse>> getMapDetail(String type, int id) {
    return apiCall(
      dio.get(Endpoints.mapDetail, queryParameters: {'type': type, 'id': id}),
      dataFromJson: (data) => MapDetailResponse.fromJson(data),
    );
  }

  @override
  Future<ApiResponse<List<SlotResponse>>> getSlots(int id, int day) {
    return apiCall(
      dio.get(Endpoints.slots(id), queryParameters: {'day': day}),
      dataFromJson: (data) => (data as List).map((e) => SlotResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<bool>> bookSlot(int reservationId) {
    return apiCall(
      dio.post(Endpoints.slotReserve, data: {'reservation_id': reservationId}),
      dataFromJson: (data) => true,
    );
  }

  @override
  Future<ApiResponse<bool>> cancelBook(int clientReservationId) {
    return apiCall(
      dio.post(Endpoints.cancelReserve, data: {'client_reservation_id': clientReservationId}),
      dataFromJson: (data) => true,
    );
  }

  @override
  Future<ApiResponse<ForecastResponse>> getForecast() {
    return apiCall(dio.get(Endpoints.forecast), dataFromJson: (data) => ForecastResponse.fromJson(data));
  }

  @override
  Future<ApiResponse<CheckQrResponse>> checkQr(String code) {
    return apiCall(dio.post(Endpoints.checkCode(code)), dataFromJson: (data) => CheckQrResponse.fromJson(data));
  }

  @override
  Future<Uint8List?> downloadImage(String url) async {
    try {
      final res = await dio.get(url, options: Options(responseType: ResponseType.bytes));
      final data = res.data;
      if (data != null) {
        return Uint8List.fromList(data);
      }
      return null;
    } catch (e) {
      print('Ошибка загрузки изображения: $e');
      return null;
    }
  }
}
