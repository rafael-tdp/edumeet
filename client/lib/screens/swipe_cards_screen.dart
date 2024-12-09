// lib/pages/swipe_cards_page.dart

import 'package:flutter/material.dart';
import 'package:client/components/swipe_cards.dart';

class SwipeCardsPage extends StatelessWidget {
  const SwipeCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'images/logo-bold.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SwipeCardsComponent(),
      ),
    );
  }
}
