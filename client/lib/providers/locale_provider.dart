import 'package:flutter/material.dart';
import 'package:client/i18n/generated/translations.g.dart';

class LocaleProvider extends ChangeNotifier {
  AppLocale _currentLocale = LocaleSettings.currentLocale;

  AppLocale get currentLocale => _currentLocale;

  void setLocale(AppLocale locale) {
    _currentLocale = locale;
    LocaleSettings.setLocale(locale);
    notifyListeners();
  }
}