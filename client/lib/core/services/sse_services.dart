import 'dart:async';
import 'dart:convert';
import 'package:client/core/services/auth_services.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import '../../env/env.dart';
import '../models/chat/messageEvent.dart';
import '../models/chat/messagePrivate.dart';
import 'package:http/http.dart' as http;

class SseServices {
  final AuthServices _authServices = AuthServices();
  final StreamController<dynamic> _messageStreamController = StreamController.broadcast();
  late bool shouldConnect = true;
  late StreamSubscription _sseSubscription;

  Stream<dynamic> get messageStream => _messageStreamController.stream;

  Future<void> connectToSse() async {
    final token = await _authServices.getToken();
    _sseSubscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: '${Env.BACKEND_URL}/chats/connect',
      header: {
        'Authorization': 'Bearer $token',
        'Accept': 'text/event-stream',
        'Cache-Control': 'no-cache',
      },
    ).listen(
          (event) {
        if (event.data!.contains('eventId')) {
          final eventMessage = MessageEvent.fromJson(jsonDecode(event.data!));
          _messageStreamController.add(eventMessage);
        } else {
          final friendMessage = MessagePrivate.fromJson(jsonDecode(event.data!));
          _messageStreamController.add(friendMessage);
        }
      },
      onError: (error, stackTrace) {
        _messageStreamController.close();
      },
    );
  }

  Future<void> disonnect() async {
    final token = await _authServices.getToken();
    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/chats/disconnect'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  void dispose() {
    _sseSubscription.cancel();
    _messageStreamController.close();
    disonnect();
  }
}