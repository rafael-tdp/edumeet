import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/badge.dart';

class BadgeServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<Badge>> getBadges() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/badge'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final subjects = jsonDecode(responseBody) as List<dynamic>; 
        return subjects.map((subject) => Badge.fromJson(subject)).toList();
      } else {
        log('Failed to load subjects: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (error, stacktrace) {
      log('An error occurred while retrieving subjects',
          error: error, stackTrace: stacktrace);
      return [];
    }
  }

  static Future<bool> deleteBadge(badgeId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return false;
      }

      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/badge/' + badgeId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      log('An error occurred while deleting badge',
          error: error, stackTrace: stacktrace);
      return false;
    }
  }

  static Future<bool> createBadge(newBadge) async {
    try {
      final token = await getToken();

      if (token == null) {
        return false;
      }

      final response = await http.post(
          Uri.parse('${Env.BACKEND_URL}/badge'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "name": newBadge.name,
            "type": newBadge.type,
            "nbRequirementEvent": newBadge.nbRequirementEvent,
            "svg": newBadge.svg
          })
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      log('An error occurred while retrieving subjects',
          error: error, stackTrace: stacktrace);
      return false;
    }
  }

  static Future<bool> updateBadge(badge, newBadge) async {
    try {
      final token = await getToken();

      if (token == null) {
        return false;
      }

      final response = await http.put(
          Uri.parse('${Env.BACKEND_URL}/badge/' + badge.id),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "name": newBadge.name,
            "type": newBadge.type,
            "nbRequirementEvent": newBadge.nbRequirementEvent,
            "svg": newBadge.svg
          })
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      log('An error occurred while retrieving subjects',
          error: error, stackTrace: stacktrace);
      return false;
    }
  }
}


