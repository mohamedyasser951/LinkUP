import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) {
      sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      sharedPreferences.setInt(key, value);
    }

    return sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) async {
    return sharedPreferences.get(key);
  }

  static dynamic removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
