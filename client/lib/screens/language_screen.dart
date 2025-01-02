import 'package:flutter/material.dart';
import 'package:client/widgets/language_selection.dart';
import 'package:go_router/go_router.dart';

import '../i18n/generated/translations.g.dart';

class LanguagePage extends StatelessWidget {
  static const String routeName = '/language';
  static navigateTo(BuildContext context) {
    context.push(routeName);
  }

  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.welcome.whatLanguage),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LanguageSelection(parentContext: context),
    );
  }
}