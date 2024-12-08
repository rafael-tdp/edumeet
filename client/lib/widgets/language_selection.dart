import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/utils/colors.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelection extends StatefulWidget {
  final BuildContext parentContext;

  const LanguageSelection({super.key, required this.parentContext});

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
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

  List<String> _filteredLanguages = [];
  final TextEditingController _searchController;

  String? _selectedLanguageCode;
  _LanguageSelectionState() : _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLanguages = List.from(
        AppLocaleUtils.supportedLocales.map((locale) => locale.languageCode));
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLanguages = languageNames.keys
          .where((code) => languageNames[code]!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final supportedLocales = AppLocaleUtils.supportedLocales;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for a language',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredLanguages.length,
                itemBuilder: (context, index) {
                  String languageCode = _filteredLanguages[index];
                  bool isSelected = _selectedLanguageCode == languageCode;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Flag.fromString(
                        languageCode == "en"
                            ? "gb"
                            : languageCode == "uk"
                                ? "ua"
                                : languageCode,
                        height: 25,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                          "$languageCode - ${languageNames[languageCode]!}"),
                      onTap: () {
                        final locale = AppLocale.values.firstWhere(
                            (locale) => locale.languageCode == languageCode);
                        localeProvider.setLocale(locale);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: AppColors.purple),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
