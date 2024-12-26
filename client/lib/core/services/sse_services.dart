import 'dart:convert';
import 'dart:developer';
import 'package:client/core/models/messageEvent.dart';
import 'package:client/core/models/messagePrivate.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

class SseServices {
  final AuthServices _authServices = AuthServices();

  Future<void> connectToSse() async {
    final token = await _authServices.getToken();
    SSEClient.subscribeToSSE(
        method: SSERequestType.GET,
        url:
        '${Env.BACKEND_URL}/chats/connect',
        header: {
          'Authorization': 'Bearer $token',
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
        }).listen((event) {
          if (event.data!.contains('eventId')) {
            final eventMessage = MessageEvent.fromJson(jsonDecode(event.data!));
            print('Event: ' + eventMessage.eventId!);
            print('Message: ' + eventMessage.content!);
          } else {
            final friendMessage = MessagePrivate.fromJson(jsonDecode(event.data!));
            print('Sender: ' + friendMessage.senderId!);
            print('Receiver: ' + friendMessage.receiverId!);
            print('Message: ' + friendMessage.content!);
          }
        },
    );
  }
}