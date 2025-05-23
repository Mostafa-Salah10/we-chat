import 'package:chat_app/core/database/cache/sharedpreferences_helper.dart';
import 'package:chat_app/core/notifications/push_notification_service.dart';

Future<void> initServecesApp() async {
  await Future.wait([
    SharedPreferencesHelper.init(),
    PushNotificationService.init(),
  ]);
}
