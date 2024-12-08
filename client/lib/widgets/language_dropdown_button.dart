import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class LanguageDropdownButton extends StatelessWidget {
  final BuildContext appContext;

  LanguageDropdownButton({super.key, required this.appContext});
  final Map<String, String> languageNames = {
    'de': 'Deutsch',
    'en': 'English',
    'es': 'Español',
    'fr': 'Français',
    'it': 'Italiano',
    'nl': 'Nederlands',
    'pl': 'Polski',
    'pt': 'Português',
    'ro': 'Română',
    'ru': 'Русский',
    'uk': 'Українська',
  };

  @override
  Widget build(BuildContext context) {
    final languages = EasyLocalization.of(context)!.supportedLocales;

    return DropdownButton<Locale>(
      value: appContext.locale,
      icon: const Icon(Icons.arrow_drop_down),
      items: languages.map((Locale locale) {
        String languageName = languageNames[locale.languageCode] ?? locale.languageCode.toUpperCase();
        return DropdownMenuItem(
          value: locale,
          child: Row(
            children: [
              Flag.fromString(locale.languageCode, height:25, width: 50, fit: BoxFit.fill),
              const SizedBox(width: 10),
              Text("${locale.languageCode.toUpperCase()} - $languageName"),
            ],
          ),
        );
      }).toList(),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          appContext.setLocale(newLocale);
        }
      },
    );
  }
}
