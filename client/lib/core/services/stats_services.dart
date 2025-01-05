import 'dart:convert';
import 'dart:developer';
import 'package:client/core/models/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';

class StatsServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Stat> getStats() async {
    try {
      final token = await getToken();

      if (token == null) {
        return Stat(
          userByMonth: [],
          eventByMonth: [],
          topSubjects: [TopSubject(name: "", currentYearCount: 0, previousYearCount: 0)],
          averageParticipantsByEvent: AverageParticipants(previousYear: 0, currentYear: 0),
        );
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/stats'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final stats = jsonDecode(responseBody) as dynamic;
        return Stat.fromJson(stats);
      } else {
        log('Failed to load stats: ${response.statusCode} - ${response.body}');
        return Stat(
          userByMonth: [],
          eventByMonth: [],
          topSubjects: [TopSubject(name: "", currentYearCount: 0, previousYearCount: 0)],
          averageParticipantsByEvent: AverageParticipants(previousYear: 0, currentYear: 0),
        );
      }
    } catch (error, stacktrace) {
      log('An error occurred while retrieving stats',
          error: error, stackTrace: stacktrace);
      return Stat(
        userByMonth: [],
        eventByMonth: [],
        topSubjects: [TopSubject(name: "", currentYearCount: 0, previousYearCount: 0)],
        averageParticipantsByEvent: AverageParticipants(previousYear: 0, currentYear: 0),
      );
    }
  }
}
