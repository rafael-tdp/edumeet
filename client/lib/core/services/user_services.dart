import 'dart:async';
import 'dart:convert';
import 'package:client/core/models/response.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/core/services/cache_service.dart';
import 'package:client/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/subject.dart';
import '../models/user.dart';

class UserServices {
  final AuthServices _authServices = AuthServices();

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
      final data = HttpUtils.decodeResponse(response);
      final User user = User.fromJson(data);
      await CacheService.saveDataToCache("user_username", user.username);
      await CacheService.saveDataToCache("user_email", user.email!);
      await CacheService.saveDataToCache("user_role", user.role!);
      return ResponseRequest(success: true, data: user);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }

  Future<ResponseRequest> getUserById(String? id) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'User not authenticated');

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/user/information/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = HttpUtils.decodeResponse(response);
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

  Future<ResponseRequest> getUserSubjects() async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/user/subjects'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<Subject> subjects = data.map((subject) => Subject.fromJson(subject)).toList();
      return ResponseRequest(success: true, data: subjects);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }
}