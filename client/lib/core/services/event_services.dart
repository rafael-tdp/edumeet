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
        Uri.parse('${Env.BACKEND_URL}/events'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = jsonDecode(response.body) as List<dynamic>;
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving events', error: error);
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
        Uri.parse('${Env.BACKEND_URL}/events/users/current'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = jsonDecode(response.body) as List<dynamic>;
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving events', error: error);
      return [];
    }
  }

  static Future<List<Event>> getEventsCreatedByCurrentUser() async {
    try {
      final token = await getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/events/created-by/current'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = jsonDecode(response.body) as List<dynamic>;
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving events', error: error);
      return [];
    }
  }

  static Future<Event> getEventDetails(String eventId) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/events/$eventId/details'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final event = jsonDecode(response.body);
      return Event.fromJson(event);
    } catch (error) {
      log('An error occurred while retrieving event details', error: error);
      rethrow;
    }
  }

  static Future<Event> createEvent(Event event) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      print(event.toJson());

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/events'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create event');
      }

      final createdEvent = jsonDecode(response.body);
      return Event.fromJson(createdEvent);
    } catch (error) {
      log('An error occurred while creating event', error: error);
      rethrow;
    }
  }

  static Future<void> generateExo(String eventId) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final statement = "Génère moi un exercice d'algorithme niveau DUT INFORMATIQUE 1ere année";

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/ai/generate-exo/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'exercise': statement}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to generate exo');
      }
    } catch (error) {
      log('An error occurred while generating exo', error: error);
      rethrow;
    }
  }  

  static Future<void> generateCorrection(String eventId, String exercise) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/ai/generate-correction/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'exercise': exercise}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to generate correction');
      }
    } catch (error) {
      log('An error occurred while generating correction', error: error);
      rethrow;
    }
  }

}
