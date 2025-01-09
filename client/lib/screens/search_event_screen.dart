import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/events_maps_screen.dart';
import 'package:client/widgets/no_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/connectivty_utils.dart';
import 'swipe_cards_screen.dart';

class SearchEventPage extends StatefulWidget {
  const SearchEventPage({super.key});

  @override
  _SearchEventPageState createState() => _SearchEventPageState();
}

class _SearchEventPageState extends State<SearchEventPage> {
  bool _isConnected = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ConnectivityUtils.listenConnectivityChanges(
        onConnected: () { setState(() {
          _isConnected = true;
          _isLoading = false;
        }); },
        onDisconnected: () { setState(() {
          _isConnected = false;
          _isLoading = false;
        }); }
    );
  }

  Future<void> _checkConnectivityAndLoadData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _isConnected = false;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isConnected = true;
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }  else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            leadingWidth: 150,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 100,
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: t.app.list),
                Tab(text: t.app.map),
              ],
            ),
          ),
          body: !_isConnected ?
            const NoInternetConnectionWidget()
              :
            const TabBarView(
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
}