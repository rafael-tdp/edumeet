import 'package:client/screens/register_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:client/generated/locale_keys.g.dart';
import '../../widgets/language_dropdown_button.dart';
import 'on_boarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: OnboardingPager(),
      ),
    );
  }
}

class OnboardingPager extends StatefulWidget {
  const OnboardingPager({super.key});

  @override
  _OnboardingPagerState createState() => _OnboardingPagerState();
}

class _OnboardingPagerState extends State<OnboardingPager> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        OnboardingPage(
          title: LocaleKeys.welcome_chooseLanguage.tr(),
          additionalWidget: LanguageSelection(parentContext: context),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome.png',
          title: LocaleKeys.welcome_welcome.tr(),
          description: LocaleKeys.welcome_setup.tr(),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome2.png',
          title: LocaleKeys.welcome_title1.tr(),
          description: LocaleKeys.welcome_description1.tr(),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome3.png',
          title: LocaleKeys.welcome_title2.tr(),
          description: LocaleKeys.welcome_description2.tr(),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome5.png',
          title: LocaleKeys.welcome_title3.tr(),
          description: LocaleKeys.welcome_description3.tr(),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome1.png',
          title: LocaleKeys.welcome_title4.tr(),
          description: LocaleKeys.welcome_description4.tr(),
          onNext: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          isLastPage: true,
        ),
      ],
    );
  }
}