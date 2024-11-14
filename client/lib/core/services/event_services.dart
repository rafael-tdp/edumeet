import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

class EventServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<Event>> getEvents() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/api/events'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = jsonDecode(response.body) as List<dynamic>;
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving recipes', error: error);
      return [];
    }
  }

  static Future<List<Event>> getCurrentUserEvents() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/api/events/current'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = jsonDecode(response.body) as List<dynamic>;
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving recipes', error: error);
      return [];
    }
  }
}
