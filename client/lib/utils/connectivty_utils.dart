import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static StreamSubscription? _connectivitySubscription;

  static void listenConnectivityChanges(Function fetchData) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.wifi) || event.contains(ConnectivityResult.mobile)) {
        fetchData();
      }
    });
  }

  static void cancelSubscription() {
    _connectivitySubscription?.cancel();
  }
}