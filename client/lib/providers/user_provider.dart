import 'package:client/core/models/user.dart';
import 'package:client/core/services/cache_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    CacheService.saveUserToCache(user);
    notifyListeners();
  }

  Future<void> loadUserFromCache() async {
    final user = await CacheService.getUserFromCache();
    if (user != null) {
      _currentUser = user;
      notifyListeners();
    }
  }

  Future<User?> getUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }
    final user = await CacheService.getUserFromCache();
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return user;
    }
    return null;
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

}
