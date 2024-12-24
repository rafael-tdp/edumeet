import 'package:flutter/material.dart';
import 'package:client/i18n/generated/translations.g.dart';

class LanguageProvider extends ChangeNotifier {
  AppLocale _currentLocale = LocaleSettings.currentLocale;

  AppLocale get currentLocale => _currentLocale;

  // Changer la langue
  Future<void> changeLanguage(AppLocale newLocale) async {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      await LocaleSettings.setLocale(newLocale);
      notifyListeners();
    }
  }
}

