import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
   static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) {
     return await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
    return await  sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }

    return sharedPreferences.setDouble(key, value);
  }



 static dynamic getData(String key){
    return sharedPreferences.get(key);
  }

  static dynamic removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
