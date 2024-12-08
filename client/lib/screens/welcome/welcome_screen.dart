import 'package:client/screens/register_screen.dart';
import 'package:client/widgets/language_selection.dart';
import 'package:flutter/material.dart';

import '../../widgets/language_dropdown.dart';
import 'on_boarding_screen.dart';
import 'package:client/i18n/generated/translations.g.dart';

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
          title: t.welcome.chooseLanguage,
          additionalWidget: LanguageSelection(parentContext: context),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome.png',
          title: t.welcome.welcome,
          description: t.welcome.setup,
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome2.png',
          title: t.welcome.chooseLanguage,
          onNext: _nextPage,
        ),
        OnboardingPage(
          title: t.welcome.chooseLanguage,
          additionalWidget: LanguageSelection(parentContext: context),
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome2.png',
          title: 'Retrouve tes fiches de révision',
          description: 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants',
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome3.png',
          title: t.welcome.title2,
          description: t.welcome.description2,
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome5.png',
          title: t.welcome.title3,
          description: t.welcome.description3,
          onNext: _nextPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome1.png',
          title: t.welcome.title4,
          description: t.welcome.description4,
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