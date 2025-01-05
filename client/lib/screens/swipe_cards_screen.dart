import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/components/swipe_cards.dart';

class SwipeCardsPage extends StatefulWidget {
  const SwipeCardsPage({super.key});

  @override
  _SwipeCardsPageState createState() => _SwipeCardsPageState();
}

class _SwipeCardsPageState extends State<SwipeCardsPage> {
  bool _showFilters = false;

  hideFilters() {
    setState(() {
      _showFilters = false;
    });
  }

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
              'assets/images/logo-bold.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 12),
            child: IconButton(
              icon: Icon(
                _showFilters ? Icons.filter_list_off : Icons.filter_list,
              ),
              color: AppColors.purple,
              onPressed: () {
                setState(() {
                  _showFilters = !_showFilters;
                });
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SwipeCardsComponent(
            showFilters: _showFilters, hideFilters: hideFilters),
      ),
    );
  }
}
