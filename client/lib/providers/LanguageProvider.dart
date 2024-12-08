import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale;

  LanguageProvider(this._currentLocale);

  Locale get currentLocale => _currentLocale;

  // Méthode pour changer la langue
  void setLocale(Locale newLocale) {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      notifyListeners(); // Notifie les écouteurs de la modification
    }
  }
}
