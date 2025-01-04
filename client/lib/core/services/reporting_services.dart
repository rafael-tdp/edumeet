import 'dart:convert';

import 'package:client/core/services/auth_services.dart';
import 'package:http/http.dart' as http;

import '../../env/env.dart';
import '../models/response.dart';

class ReportingServices {
  AuthServices _authServices = AuthServices();

  Future<ResponseRequest> reportUser(String userId) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/reporting'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ResponseRequest(success: true);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }
}