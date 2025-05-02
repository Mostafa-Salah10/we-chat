import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesHelper {
  static late SharedPreferences _sharedPreferences;

  //Initialiaze of ShardPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //Set Of Data
  static Future<bool> set({required String key, required dynamic value}) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    return await _sharedPreferences.setBool(key, value);
  }

  //Get Of Data
  static dynamic get({required String key}) {
    return _sharedPreferences.get(key);
  }

  //Clear Of Specific Key
  static Future<bool> remove({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  //Remove All Data
  static Future<bool> clear() async {
    return _sharedPreferences.clear();
  }
}
