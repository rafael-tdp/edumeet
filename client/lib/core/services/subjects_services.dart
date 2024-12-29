import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/subject.dart';

class SubjectServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<Subject>> getSubjects() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/subjects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final subjects = jsonDecode(responseBody) as List<dynamic>; 
        return subjects.map((subject) => Subject.fromJson(subject)).toList();
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

  static Future<bool> deleteSubject(subjectId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return false;
      }

      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/subjects/' + subjectId),
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
      log('An error occurred while retrieving subjects',
          error: error, stackTrace: stacktrace);
      return false;
    }
  }

  static Future<bool> updateSubject(subject, newName) async {
    try {
      final token = await getToken();

      if (token == null) {
        return false;
      }

      final response = await http.put(
        Uri.parse('${Env.BACKEND_URL}/subjects/' + subject.id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
            "name": newName
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

  static Future<void> subscribeToSubject(String subjectId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return;
      }

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/subjects/$subjectId/subscribe'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        log('Failed to subscribe to subject: ${response.statusCode} - ${response.body}');
      }
    } catch (error, stacktrace) {
      log('An error occurred while subscribing to subject',
          error: error, stackTrace: stacktrace);
    }
  }
}
