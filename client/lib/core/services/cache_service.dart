import 'dart:convert';

import 'package:client/core/models/user.dart';
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

  static Future<User?> getUserFromCache() async {
    final userData = await getDataFromCache('user_data');
    if (userData != null) {
      try {
        final userMap = jsonDecode(userData);
        return User.fromJson(userMap);
      } catch (e) {
        print('Erreur lors de la conversion JSON en User : $e');
        return null;
      }
    }
    return null;
  }

  static Future<void> saveUserToCache(User user) async {
    final userJson = jsonEncode(user);
    await saveDataToCache('user_data', userJson);
  }
}
