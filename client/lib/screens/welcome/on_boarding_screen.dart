import 'package:client/screens/register_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
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
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
