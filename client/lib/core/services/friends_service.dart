import 'dart:convert';

import 'package:client/core/services/auth_services.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../enums/FriendStatus.dart';
import '../models/friendship/friendRequest.dart';
import '../models/response.dart';

class FriendsServices {
  AuthServices _authServices = AuthServices();

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

    print(Uri.parse('${Env.BACKEND_URL}/user/friendship?status=${status.name.toUpperCase()}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<FriendRequest> friends = data.map((friend) => FriendRequest.fromJson(friend)).toList();
      return ResponseRequest(success: true, data: friends);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }

  Future<ResponseRequest> sendFriendRequest(String friendId) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/friendship/$friendId'),
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

  Future<ResponseRequest> acceptFriendRequest(String friendId) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.put(
      Uri.parse('${Env.BACKEND_URL}/user/friendship/$friendId'),
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

  Future<ResponseRequest> declineFriendRequest(String friendId) async {
    final token = await _authServices.getToken();

    if (token == null) return ResponseRequest(success: false, message: 'Veuillez vous connecter');

    final response = await http.delete(
      Uri.parse('${Env.BACKEND_URL}/user/friendship/$friendId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 204) {
      return ResponseRequest(success: true);
    } else {
      return ResponseRequest(success: false, message: json.decode(response.body)['error']);
    }
  }
}