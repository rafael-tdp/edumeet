import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static StreamSubscription? _connectivitySubscription;

  static Future<void> listenConnectivityChanges({required Function onConnected, Function? onDisconnected}) async {
    if (await isConnected()) {
      onConnected();
    } else if (onDisconnected != null) {
      onDisconnected();
    }

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((event) {
      if ((event.contains(ConnectivityResult.wifi) || event.contains(ConnectivityResult.mobile))) {
        onConnected();
      } else if (onDisconnected != null) {
        onDisconnected();
      }
    });
  }

  static void cancelSubscription() {
    _connectivitySubscription?.cancel();
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}