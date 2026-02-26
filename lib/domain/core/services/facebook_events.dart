import 'package:facebook_app_events/facebook_app_events.dart';

class FacebookEventsService {
  static final _fb = FacebookAppEvents();

  static Future<void> init({
    bool autoLog = true,
    bool advertiserTracking = true,
}) async {
    await _fb.setAutoLogAppEventsEnabled(autoLog);

    await _fb.setAdvertiserTracking(enabled: advertiserTracking);

    _fb.logEvent(name: 'Великолепная работа Рамазона');

    final applicationId = await _fb.getApplicationId();
    final anonymousId = await _fb.getAnonymousId();
    print('object FacebookEventsService init $applicationId anonymousId $anonymousId');

    if (!autoLog) {
      await _fb.activateApp();
    }
}
}
