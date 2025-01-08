import 'package:flutter/material.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Une connexion internet est nécessaire pour afficher la page',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}