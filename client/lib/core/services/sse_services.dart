import 'dart:convert';
import 'dart:developer';
import 'package:client/core/services/auth_services.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

class SseServices {
  final AuthServices _authServices = AuthServices();
  final sseUrl = "http://localhost:3000/chats/connect";

  Future<void> connectToSse() async {
    final token = await _authServices.getToken();
    SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: sseUrl,
      header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'text/event-stream',
        'Cache-Control': 'no-cache',
      },
    ).listen((event) {
      print('Message reçu');
      print('Received event: ${event.data}');
      // Handle the event data here
        }, onError: (error) {
      print('Error: $error');
    });
  }

  Future<void> connectToSseV2() async {
    final token = await _authServices.getToken();
    final client = http.Client();

    final request = http.Request('GET', Uri.parse(sseUrl))
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'text/event-stream',
        'Cache-Control': 'no-cache',
      });

    final streamSubscription = client.send(request).asStream().listen((response) {
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((event) {
          log('Received raw event: $event');
          try {
            final eventData = jsonDecode(event);
            log('Decoded event data: $eventData');
            print('Received event: $eventData');
          } catch (e) {
            log('Error decoding event: $e');
          }
        }, onError: (error) {
          log('Error receiving event: $error');
        });
      } else {
        log('Error establishing connection: ${response.reasonPhrase}');
      }
    }, onError: (error) {
      log('Error establishing connection: $error');
    });
  }



  Future<void> sendMessage() async {
    final token = await _authServices.getToken();
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/chats/send-message-to-event/01JFTS4BDYEAGGS6FGSQSNFV5A'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'message': 'Hello',
      }),
    );
    if (response.statusCode == 200) {
      print('Message envoyé');
    } else {
      print('Message non envoyé');
    }
  }
}