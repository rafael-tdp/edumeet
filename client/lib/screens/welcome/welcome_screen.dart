import 'package:client/screens/login_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/widgets/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  void _previousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    context.go(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome.png',
          title: t.welcome.welcome,
          description: t.welcome.setup,
          onNext: _nextPage,
        ),
        OnboardingPage(
          title: t.welcome.whatLanguage,
          additionalWidget: LanguageSelection(parentContext: context),
          onNext: _nextPage,
          onPrevious: _previousPage,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome2.png',
          title: t.welcome.title1,
          description: t.welcome.description1,
          onNext: _nextPage,
          onPrevious: _previousPage,
          onSkip: _skip,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome3.png',
          title: t.welcome.title2,
          description: t.welcome.description2,
          onNext: _nextPage,
          onPrevious: _previousPage,
          onSkip: _skip,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome5.png',
          title: t.welcome.title3,
          description: t.welcome.description3,
          onNext: _nextPage,
          onPrevious: _previousPage,
          onSkip: _skip,
        ),
        OnboardingPage(
          imagePath: 'assets/images/welcome/welcome1.png',
          title: t.welcome.title4,
          description: t.welcome.description4,
          onNext: () {
            context.go(RegisterPage.routeName);
          },
          isLastPage: true,
        ),
      ],
    );
  }
}
