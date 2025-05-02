import 'package:chat_app/core/database/cache/sharedpreferences_helper.dart';
Future<void> initServecesApp() async {
  await SharedPreferencesHelper.init();
}
