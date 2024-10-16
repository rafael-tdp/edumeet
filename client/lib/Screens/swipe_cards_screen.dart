// lib/pages/swipe_cards_page.dart

import 'package:flutter/material.dart';
import 'package:client/components/swipe_cards.dart';

class SwipeCardsPage extends StatelessWidget {
  const SwipeCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SwipeCardsComponent(),
      ),
    );
  }
}
