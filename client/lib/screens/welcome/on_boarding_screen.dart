import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:client/utils/colors.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/login_screen.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback onNext;
  final Widget? additionalWidget;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.onNext,
    this.imagePath = '',
    this.description = '',
    this.isLastPage = false,
    this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          if (imagePath.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset(imagePath),
            ),
          const SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (description.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          if (additionalWidget != null)
            Column(
              children: [
                const SizedBox(height: 20),
                additionalWidget!,
              ],
            ),
          const SizedBox(height: 50),
          if (isLastPage)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    backgroundColor: AppColors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(color: AppColors.purple, fontSize: 20),
                  ),
                ),
              ],
            )
          else
            FloatingActionButton(
              onPressed: onNext,
              backgroundColor: AppColors.purple,
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
        ],
      ),
    );
  }
}

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
    _filteredLanguages = List.from(languageNames.keys);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLanguages = languageNames.keys
          .where((code) =>
          languageNames[code]!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportedLocales = EasyLocalization.of(widget.parentContext)!.supportedLocales;

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
                        languageCode == "en" ? "gb" : languageCode == "uk" ? "ua" : languageCode,
                        height: 25,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      title: Text(languageNames[languageCode]!),
                      onTap: () {
                        final locale = Locale(languageCode);
                        context.setLocale(locale);
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

