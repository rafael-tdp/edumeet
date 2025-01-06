import 'package:client/screens/events_maps_screen.dart';
import 'package:flutter/material.dart';
import 'swipe_cards_screen.dart';

class SearchEventPage extends StatefulWidget {
  const SearchEventPage({super.key});

  @override
  _SearchEventPageState createState() => _SearchEventPageState();
}

class _SearchEventPageState extends State<SearchEventPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Liste'),
              Tab(text: 'Carte'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SwipeCardsPage(),
            EventsMapsScreen(),
          ],
        ),
      ),
    );
  }
}