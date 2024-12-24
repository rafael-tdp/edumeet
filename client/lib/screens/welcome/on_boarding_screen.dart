import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSkip;
  final Widget? additionalWidget;
  static void _emptyCallback() {}

  const OnboardingPage({
    super.key,
    required this.title,
    required this.onNext,
    this.onPrevious = _emptyCallback,
    this.onSkip = _emptyCallback,
    this.imagePath = '',
    this.description = '',
    this.isLastPage = false,
    this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.go(RegisterPage.routeName);
                    },
                    child: Text(
                      t.app.signup,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    context.go(LoginPage.routeName);
                  },
                  child: Text(
                    t.app.login,
                    style: const TextStyle(color: AppColors.purple, fontSize: 20),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onPrevious != _emptyCallback)
                      FloatingActionButton(
                        onPressed: onPrevious,
                        backgroundColor: AppColors.purple,
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: onNext,
                      backgroundColor: AppColors.purple,
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
                if (onSkip != _emptyCallback)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      TextButton(
                        onPressed: onSkip,
                        child: Text(
                          t.app.skip,
                          style:
                              const TextStyle(color: AppColors.purple, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
