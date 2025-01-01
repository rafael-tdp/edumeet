import 'package:client/core/services/cache_service.dart';
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
    'sv': 'Svenska',
  };

  List<String> _filteredLanguages = [];
  final TextEditingController _searchController;

  String? _selectedLanguageCode;
  _LanguageSelectionState() : _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLanguages = List.from(languageNames.keys);
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
    final localeProvider = Provider.of<LocaleProvider>(widget.parentContext);

    return Container(
      padding: const EdgeInsets.only(left:20, right: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/welcome/flags_banner.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 5,
                  childAspectRatio: 3,
                ),
                itemCount: _filteredLanguages.length,
                itemBuilder: (context, index) {
                  String languageCode = _filteredLanguages[index];
                  bool isSelected = _selectedLanguageCode == languageCode ||
                      localeProvider.currentLocale.languageCode == languageCode;
                  return Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.purple.withOpacity(0.5)
                            : AppColors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Column(
                            children: [
                              Flag.fromString(
                                languageCode == "en"
                                    ? "gb"
                                    : languageCode == "uk"
                                    ? "ua"
                                    : languageCode,
                                height: 20,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(height: 4),
                              Text(languageNames[languageCode]!),
                            ],
                          ),
                          onTap: () {
                            final locale = AppLocale.values.firstWhere(
                                    (locale) =>
                                locale.languageCode == languageCode);
                            localeProvider.setLocale(locale);
                            _selectedLanguageCode = languageCode;
                            CacheService.saveDataToCache('locale', languageCode);
                          },
                        ),
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}