import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/locale_provider.dart';

class LanguageDropdown extends StatelessWidget {
  final BuildContext parentContext;
  const LanguageDropdown({Key? key, required this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.currentLocale;

    return DropdownButton<AppLocale>(
      value: currentLocale,
      onChanged: (AppLocale? newLocale) {
        if (newLocale != null) {
          localeProvider.setLocale(newLocale);
        }
      },
      items: AppLocale.values.map((locale) {
        return DropdownMenuItem(
          value: locale,
          child: Text("${t.hello} ${locale.languageTag}"),
        );
      }).toList(),
    );
  }
}
