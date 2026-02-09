class Endpoints {
  static const String baseUrl = "https://api.crm1.35minut.club/api/v2/client";

  static const faq = '/api/v1/faq/';

  /// auth
  static const login = '/login';
  static const loginWithPassword = '/login-password';
  static const code = '/code';
  static const wizard = '/wizard';
  static const wizardSkip = '/wizard/skip';
  static const wizardSlots = '/wizard/slots';

  static wizardStep(int step) => '/wizard/$step';

  /// histories
  static const paymentsHistory = '/history/payments';
  static const freezesHistory = '/history/freezes';
  static const subscriptionsHistory = '/history/subscriptions';
  static const measuresHistory = '/history/measures';
  static const trainingHistory = '/history/trainings';
  static const metricsHistory = '$metrics/history';

  static const freeze = '/freeze';
  static const profile = '/profile';
  static const userMe = '/me';
  static const trainings = '/trainings/first';
  static const password = '/password';
  static const calendar = '/calendar';
  static const metrics = '/metrics';
  static const dailyMetrics = '$metrics/today';
  static const dashboardMetrics = '$metrics/dashboard';
  static const map = '/map';
  static const mapDetail = '/map/detail';
  static const forecast = '/forecast';
  static checkCode(String code) => '/check-code/$code';
  static slots(int id) => '/partners/$id/slots';
  static const slotReserve = '/partners/reserve';
  static const cancelReserve = '/partners/cancel';

  static const nutritionDiary = '/nutrition/day';
  static const nutritionUpload = '/nutrition/upload';
  static const nutritionUploadAnalyze = '/nutrition/upload-analyze';
  static const nutritionAnalyze = '/nutrition/analyze';
  static const nutritionHistory = '/nutrition/history';
}
