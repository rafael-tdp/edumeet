import 'dart:async';
import 'dart:convert';
import 'package:client/core/enums/FriendStatus.dart';
import 'package:client/core/models/friendship/friendRequest.dart';
import 'package:client/core/models/response.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/core/services/cache_service.dart';
import 'package:client/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/subject.dart';
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

  static Future<ResponseRequest> updateAdminUserInfo(User user) async {
    final token = await getToken();

    if (token == null) return ResponseRequest(success: false, message: 'User not authenticated');

    final response = await http.patch(
      Uri.parse('${Env.BACKEND_URL}/user/admin/${user.id}'),
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
  static Future<ResponseRequest> createUser(dynamic user) async {
    try {
      final token = await getToken();

      if (token == null) {
        return ResponseRequest(success: false, message: 'User not authenticated');
      }

      final response = await http.post(
          Uri.parse('${Env.BACKEND_URL}/user/create'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "email": user['email'],
            "password": user['password'],
            "firstname": user['firstname'],
            "lastname": user['lastname'],
            "username": user['username'],
            "birthdate": user['birthdate'],
            "role": user['role'],
          })
      );

      if (response.statusCode == 201) {
        return ResponseRequest(success: true, message: 'Utilisateur crée avec succes.');
      } else {
        return ResponseRequest(success: false, message: json.decode(response.body)['error']);
      }
    } catch (error, stacktrace) {
      log('An error occurred while creating user',
          error: error, stackTrace: stacktrace);
      return ResponseRequest(success: true, message: 'Erreur lors de la création.');
    }
  }

  static Future<ResponseRequest> deleteUser(userId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return ResponseRequest(success: false, message: 'Utilisateur non authentifié');
      }

      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/user/' + userId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        return ResponseRequest(success: true, message: "Utilisateur supprimé avec succes.");
      } else {
        return ResponseRequest(success: true, message: json.decode(response.body)['error']);
      }
    } catch (error, stacktrace) {
      log('An error occurred while deleting user',
          error: error, stackTrace: stacktrace);
      return ResponseRequest(success: false, message: "Une erreur s'est produite.");
    }
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

  Future<ResponseRequest> getUserFriends([FriendStatus status = FriendStatus.all]) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/user/friendship?status=${status.name.toUpperCase()}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<FriendRequest> friends = data.map((friend) => FriendRequest.fromJson(friend)).toList();
      return ResponseRequest(success: true, data: friends);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }
}
