import 'package:shared_preferences/shared_preferences.dart';

class CacheService {

  static Future<String?> getDataFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      print("$key : ${prefs.getString(key)}");
      return prefs.getString(key);
    } else {
      print("$key : Data not found");
      return null;
    }
  }

  static Future<void> saveDataToCache(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> removeDataFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

}

