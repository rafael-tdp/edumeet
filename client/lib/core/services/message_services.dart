import 'dart:async';
import 'dart:convert';
import 'package:client/core/enums/MessageType.dart';
import 'package:client/core/models/messageEvent.dart';
import 'package:client/core/models/messageRequest.dart';
import 'package:client/core/models/response.dart';
import 'package:client/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../models/messagePrivate.dart';
import 'auth_services.dart';

class MessageServices {
  static const _messageKey = 'kMessage';
  final AuthServices _authServices = AuthServices();

  static String _getApiUrl(dynamic message, MessageType type) {
    if (type == MessageType.event) {
      return '${Env.BACKEND_URL}/chats/send-message-to-event/${message.eventId}';
    } else if (type == MessageType.private) {
      return '${Env.BACKEND_URL}/chats/send-message-to-friend/${message.receiverId}';
    } else {
      throw Exception('Unknown message type');
    }
  }

  Future<ResponseRequest> sendMessage(MessageRequest message, MessageType type) async {
    try {
      final token = await _authServices.getToken();
      var networkConnectionState = await Connectivity().checkConnectivity();
      if (networkConnectionState != ConnectivityResult.none) {
        final response = await http.post(
          Uri.parse(_getApiUrl(message, type)),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'message': message.message,
          }),
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

  Future<void> saveMessageOffline(MessageRequest message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> storedMessages = prefs.getStringList(_messageKey) ?? [];
      storedMessages.add(jsonEncode(message.toJson()));
      await prefs.setStringList(_messageKey, storedMessages);
    } catch (e) {
      print("Erreur lors de la sauvegarde du message hors ligne : $e");
    }
  }

  Future<void> sendPendingMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? savedMessages = prefs.getStringList(_messageKey);

      if (savedMessages == null || savedMessages.isEmpty) return;

      var networkConnectionState = await Connectivity().checkConnectivity();
      if (networkConnectionState == ConnectivityResult.none) return;

      List<String> pendingMessages = [];

      for (String msg in savedMessages) {
        try {
          MessageRequest message = MessageRequest.fromJson(jsonDecode(msg));
          if (message.eventId == null && message.receiverId == null) {
            continue;
          } else if (message.eventId != null) {
            final response = await sendMessage(message, MessageType.event);
            if (!response.success) {
              pendingMessages.add(msg);
            }
          } else if (message.receiverId != null) {
            final response = await sendMessage(message, MessageType.private);
            if (!response.success) {
              pendingMessages.add(msg);
            }
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
