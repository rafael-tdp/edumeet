import 'dart:async';
import 'dart:convert';
import 'package:client/core/services/auth_services.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/user.dart';

class UserServices {
  final AuthServices _authServices = AuthServices();

  Future<Map<String, dynamic>?> getUserInfo() async {
    final token = await _authServices.getToken();

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(data).toJson();
    } else {
      return null;
    }
  }


}