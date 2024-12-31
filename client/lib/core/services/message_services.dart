import 'dart:async';
import 'dart:convert';
import 'package:client/core/models/chat/conversation.dart';
import 'package:client/core/models/response.dart';
import 'package:client/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:client/core/enums/MessageType.dart';
import 'package:client/core/models/chat/messageRequest.dart';
import '../models/chat/sendMessageRequest.dart';
import 'auth_services.dart';

class MessageServices {
  static const _messageKey = 'kMessage';
  final AuthServices _authServices = AuthServices();

  static String _getApiUrl(dynamic message, MessageType type) {
    if (type == MessageType.event) {
      return '${Env.BACKEND_URL}/chats/send-message-to-event/${message.eventId}';
    } else if (type == MessageType.private) {
      return '${Env.BACKEND_URL}/chats/send-message-to-friend/${message.eventId}';
    } else {
      throw Exception('Unknown message type');
    }
  }

  Future<ResponseRequest> sendMessage(SendMessageRequest message, MessageType type) async {
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
            'message': message.content,
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

  Future<void> saveMessageOffline(SendMessageRequest message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> storedMessages = prefs.getStringList(_messageKey) ?? [];
      storedMessages.add(jsonEncode(message.toJson()));
      await prefs.setStringList(_messageKey, storedMessages);
    } catch (e) {
      print("Erreur lors de la sauvegarde du message hors ligne : $e");
    }
  }

  // Future<void> sendPendingMessages() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     List<String>? savedMessages = prefs.getStringList(_messageKey);
  //
  //     if (savedMessages == null || savedMessages.isEmpty) return;
  //
  //     var networkConnectionState = await Connectivity().checkConnectivity();
  //     if (networkConnectionState == ConnectivityResult.none) return;
  //
  //     List<String> pendingMessages = [];
  //
  //     for (String msg in savedMessages) {
  //       try {
  //         MessageRequest message = MessageRequest.fromJson(jsonDecode(msg));
  //         if (message.eventId == null && message.receiverId == null) {
  //           continue;
  //         } else if (message.eventId != null) {
  //           final response = await sendMessage(message, MessageType.event);
  //           if (!response.success) {
  //             pendingMessages.add(msg);
  //           }
  //         } else if (message.receiverId != null) {
  //           final response = await sendMessage(message, MessageType.private);
  //           if (!response.success) {
  //             pendingMessages.add(msg);
  //           }
  //         }
  //       } catch (e) {
  //         print("Erreur lors de l'envoi d'un message en attente : $e");
  //         pendingMessages.add(msg);
  //       }
  //     }
  //
  //     if (pendingMessages.isEmpty) {
  //       await prefs.remove(_messageKey);
  //     } else {
  //       await prefs.setStringList(_messageKey, pendingMessages);
  //     }
  //   } catch (e) {
  //     print("Erreur lors de l'envoi des messages en attente : $e");
  //   }
  // }

  Future<ResponseRequest> getEventMessages(String eventId) async {
    try {
      final token = await _authServices.getToken();
      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/chats/get-conversation-event/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return ResponseRequest(success: true, data: data.map((e) => MessageRequest.fromJson(e)).toList());
      } else {
        return ResponseRequest(success: false, message: 'Erreur lors de la récupération des messages de l\'événement');
      }
    } catch (e) {
      print("Erreur lors de la récupération des messages de l'événement : $e");
      return ResponseRequest(success: false, message: 'Erreur lors de la récupération des messages de l\'événement');
    }
  }

  Future<void> deleteMessage(String eventId, String messageId) async {
    try {
      final token = await _authServices.getToken();
      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/chats/delete-message-to-event/$eventId/$messageId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Erreur lors de la suppression du message');
      }
    } catch (e) {
      print("Erreur lors de la suppression du message : $e");
      throw Exception('Erreur lors de la suppression du message');
    }
  }

  Future<ResponseRequest> getConversations() async {
    try {
      final token = await _authServices.getToken();
      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/chats/conversations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final result = data.map((e) => Conversation.fromJson(e)).toList();
        result.sort((a, b) => b.lastMessageDate.compareTo(a.lastMessageDate));
        return ResponseRequest(success: true, data: result);
      } else {
        return ResponseRequest(success: false, message: 'Erreur lors de la récupération des conversations');
      }
    } catch (e) {
      print("Erreur lors de la récupération des conversations : $e");
      return ResponseRequest(success: false, message: 'Erreur lors de la récupération des conversations');
    }
  }

  Future<ResponseRequest> getPrivateMessages(String friendId) async {
    try {
      final token = await _authServices.getToken();
      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/chats/get-conversation-friend/$friendId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return ResponseRequest(success: true, data: data.map((e) => MessageRequest.fromJson(e)).toList());
      } else {
        return ResponseRequest(success: false, message: 'Erreur lors de la récupération des messages de l\'événement');
      }
    } catch (e) {
      print("Erreur lors de la récupération des messages de l'événement : $e");
      return ResponseRequest(success: false, message: 'Erreur lors de la récupération des messages de l\'événement');
    }
  }
}
