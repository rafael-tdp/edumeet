import 'dart:async';
import 'dart:convert';
import 'package:client/core/models/message.dart';
import 'package:client/core/models/response.dart';
import 'package:client/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class MessageServices {
  static const _messageKey = 'kMessage';
  static const String _apiUrl = "http://localhost:3000/messages";

  static Future<ResponseRequest> sendMessage(Message message) async {
    try {
      var networkConnectionState = await Connectivity().checkConnectivity();
      if (networkConnectionState != ConnectivityResult.none) {
        final response = await http.post(
          Uri.parse(_apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(message.toJson()),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return ResponseRequest(success: true, message: 'Message envoyé');
        } else {
          await saveMessageOffline(message);
          return ResponseRequest(
              success: false, message: 'Message non envoyé (Erreur serveur)');
        }
      } else {
        await saveMessageOffline(message);
        return ResponseRequest(
            success: false,
            message: 'Veuillez vérifier votre connexion internet');
      }
    } catch (e) {
      print("Erreur lors de l'envoi du message : $e");
      await saveMessageOffline(message);
      return ResponseRequest(
          success: false, message: 'Erreur lors de l\'envoi du message');
    }
  }

  static Future<void> saveMessageOffline(Message message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> storedMessages = prefs.getStringList(_messageKey) ?? [];
      storedMessages.add(jsonEncode(message.toJson()));
      await prefs.setStringList(_messageKey, storedMessages);
    } catch (e) {
      print("Erreur lors de la sauvegarde du message hors ligne : $e");
    }
  }

  static Future<void> sendPendingMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? savedMessages = prefs.getStringList(_messageKey);

      if (savedMessages == null || savedMessages.isEmpty) return;

      var networkConnectionState = await Connectivity().checkConnectivity();
      if (networkConnectionState == ConnectivityResult.none) return;

      List<String> pendingMessages = [];

      for (String msg in savedMessages) {
        try {
          Message message = Message.fromJson(jsonDecode(msg));
          final response = await sendMessage(message);
          if (!response.success) {
            pendingMessages.add(msg);
          }
        } catch (e) {
          print("Erreur lors de l'envoi d'un message en attente : $e");
          pendingMessages.add(msg);
        }
      }

      if (pendingMessages.isEmpty) {
        await prefs.remove(_messageKey);
      } else {
        await prefs.setStringList(_messageKey, pendingMessages);
      }
    } catch (e) {
      print("Erreur lors de l'envoi des messages en attente : $e");
    }
  }
}
