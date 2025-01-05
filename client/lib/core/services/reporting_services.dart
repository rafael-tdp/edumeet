import 'dart:convert';
import 'dart:developer';
import 'package:client/core/models/reporting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';

import '../models/response.dart';

class ReportingServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<ResponseRequest> createReporting(Reporting reporting) async {
    try {
      final token = await getToken();

      if (token == null) {
        return ResponseRequest(success: false, message: 'Veillez vous connecter');
      }

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/reporting'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(reporting.toJson()),
      );

      if (response.statusCode == 201) {
        return ResponseRequest(success: true, message: "L'utilisateur a été signalé");
      } else {
        log('Failed to report user: ${response.statusCode} - ${response.body}');
        return ResponseRequest(success: false, message: 'Une  erreur est survenue lors du signalement');
      }
    } catch (error, stacktrace) {
      log('An error occurred while reportin user',
          error: error, stackTrace: stacktrace);
      return ResponseRequest(success: false, message: 'Une  erreur est survenue lors du signalement');
    }
  }
}
