import 'dart:io';
import 'dart:typed_data';
import 'package:health_club/data/network/model/calendar_response.dart';
import 'package:health_club/data/network/model/daily_metrics_response.dart';
import 'package:health_club/data/network/model/dashboard_metrics_response.dart';
import 'package:health_club/data/network/model/forecast_response.dart';
import 'package:health_club/data/network/model/history/body_composition_response.dart';
import 'package:health_club/data/network/model/history/metric_history_response.dart';
import 'package:health_club/data/network/model/history/payment_history_response.dart';
import 'package:health_club/data/network/model/history/subscription_history_response.dart';
import 'package:health_club/data/network/model/map/map_detail_response.dart';
import 'package:health_club/data/network/model/map/map_point_response.dart';
import 'package:health_club/data/network/model/nutrition_diary_response.dart';
import 'package:health_club/data/network/model/profile_response.dart';
import 'package:health_club/data/network/model/user_response.dart';

import '../../../domain/core/core.dart';
import '../model/check_qr_response.dart';
import '../model/first_training_response.dart';
import '../model/history/freeze_history_response.dart';
import '../model/history/training_history_response.dart';
import '../model/profile_request.dart';
import '../model/slot_response.dart';

abstract class MainProvider extends BaseProvider {
  Future<ApiResponse<ProfileResponse>> getProfile();

  Future<ApiResponse<UserMeResponse>> getUser();

  Future<ApiResponse<bool>> updateProfile(ProfileRequest profileRequest, File? avatar);

  Future<ApiResponse<bool>> changePassword(String password, String confirmationPassword);

  Future<ApiResponse<List<FirstTrainingResponse>>> getPlanedFirstTrainings();

  Future<ApiResponse<List<PaymentHistoryResponse>>> getPaymentHistory();

  Future<ApiResponse<List<FreezeHistoryResponse>>> getFreezeHistory();

  Future<ApiResponse<bool>> freezeSubscription(int days, String startDate);

  Future<ApiResponse<List<SubscriptionHistoryResponse>>> getSubscriptionHistory();

  Future<ApiResponse<List<BodyCompositionHistoryResponse>>> getBodyCompositionHistory();

  Future<ApiResponse<List<TrainingHistoryResponse>>> getTrainingHistory();

  Future<ApiResponse<CalendarResponse>> getCalendar();

  Future<ApiResponse<DailyMetricsResponse>> getDailyMetrics();

  Future<ApiResponse<bool>> updateMetrics({
    int? water,
    double? sleepHours,
    String? sleepStart,
    String? sleepEnd,
    int? steps,
  });

  Future<ApiResponse<DashboardMetricsResponse>> getDashboardMetrics();

  Future<ApiResponse<List<MetricHistoryResponse>>> getMetricsHistory(String type);

  Future<ApiResponse<NutritionDiaryResponse>> getNutritionDay();

  Future<ApiResponse<bool>> uploadNutrition({
    required File image,
    required String type,
    required String title,
    required String text,
  });

  Future<ApiResponse<bool>> getNutritionAnalyze();

  Future<ApiResponse<List<NutritionDiaryResponse>>> getNutritionHistory();

  Future<ApiResponse<List<MapPointResponse>>> getMapPoints();

  Future<ApiResponse<List<SlotResponse>>> getSlots(int id, int day);

  Future<ApiResponse<bool>> bookSlot(int reservationId);

  Future<ApiResponse<bool>> cancelBook(int clientReservationId);

  Future<ApiResponse<MapDetailResponse>> getMapDetail(String type, int id);

  Future<ApiResponse<ForecastResponse>> getForecast();

  Future<ApiResponse<CheckQrResponse>> checkQr(String code);

  Future<Uint8List?> downloadImage(String url);
}
