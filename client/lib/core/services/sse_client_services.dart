import 'dart:convert';
import 'dart:io';

import 'package:client/core/services/auth_services.dart';
import 'package:flutter/material.dart';

class SSEClient {
  final AuthServices _authServices = AuthServices();
  final String url;
  HttpClient? _httpClient;
  HttpClientRequest? _request;
  HttpClientResponse? _response;

  SSEClient(this.url);

  Stream<String> connect() async* {
    try {
      final token = await _authServices.getToken();
      _httpClient = HttpClient();
      _httpClient?.autoUncompress = false;

      _request = await _httpClient!.getUrl(Uri.parse(url));
      _request!.headers.set(HttpHeaders.acceptHeader, 'text/event-stream');
      _request!.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');

      _response = await _request!.close();

      if (_response!.statusCode == 200) {
        await for (var line in _response!.transform(utf8.decoder).transform(LineSplitter())) {
          if (line.startsWith('data: ')) {
            yield line.substring(6); // Supprime le préfixe 'data: '
          }
        }
      } else {
        throw HttpException('Erreur HTTP ${_response!.statusCode}');
      }
    } catch (e) {
      print('Erreur SSE : $e');
      rethrow;
    } finally {
      _httpClient?.close();
    }
  }

  void close() {
    _httpClient?.close(force: true);
  }
}
