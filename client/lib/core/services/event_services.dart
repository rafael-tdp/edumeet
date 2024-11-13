import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';

class EventServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<Map<String, dynamic>>> getEvents() async {
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

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = jsonDecode(response.body);
      return decodedResponse.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
    } else {
      return [];
    }
  }
}
