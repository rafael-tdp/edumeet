import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';

class ParticipantServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<dynamic> joinEvent(String eventId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/participants/request/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (error) {
      log('An error occurred while joining the event', error: error);
      return null;
    }
  }
}