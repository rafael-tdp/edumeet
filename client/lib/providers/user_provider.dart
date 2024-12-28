import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _username;
  String? _role;

  String? get email => _email;
  String? get username => _username;
  String? get role => _role;

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('user_email');
    _username = prefs.getString('user_username');
    _role = prefs.getString('user_role');
    notifyListeners();
  }

  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.remove('user_username');
    await prefs.remove('user_role');
    _email = null;
    _username = null;
    _role = null;
    notifyListeners();
  }
}