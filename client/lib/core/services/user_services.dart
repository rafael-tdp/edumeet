import 'dart:async';
import 'dart:convert';
import 'package:client/core/models/response.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserServices {
  final AuthServices _authServices = AuthServices();

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<ResponseRequest> getUserInfo() async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'User not authenticated');

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/me'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final User user = User.fromJson(data);
      return ResponseRequest(success: true, data: user);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }

  Future<ResponseRequest> updateUserInfo(User user) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'User not authenticated');

    final response = await http.put(
      Uri.parse('${Env.BACKEND_URL}/user/${user.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final User user = User.fromJson(data);
      return ResponseRequest(success: true, message: 'User updated', data: user);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }

  static Future<List<User>> getUsers() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final users = jsonDecode(responseBody) as List<dynamic>;
        return users.map((user) => User.fromJson(user)).toList();
      } else {
        log('Failed to load users: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (error, stacktrace) {
      log('An error occurred while retrieving users',
          error: error, stackTrace: stacktrace);
      return [];
    }
  }


}