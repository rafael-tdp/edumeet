import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

import '../models/response.dart';

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

  static Future<void> createEvent(Event event) async {
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
    } catch (error) {
      log('An error occurred while creating event', error: error);
      rethrow;
    }
  }

  static Future<ResponseRequest> deleteEvent(eventId) async {
    try {
      final token = await getToken();

      if (token == null) {
        return ResponseRequest(success: false, message: 'Utilisateur non authentifié');
      }

      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/events/' + eventId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        return ResponseRequest(success: true, message: "Evenement supprimé avec succes.");
      } else {
        return ResponseRequest(success: true, message: json.decode(response.body)['error']);
      }
    } catch (error, stacktrace) {
      log('An error occurred while deleting subject',
          error: error, stackTrace: stacktrace);
      return ResponseRequest(success: false, message: "Une erreur s'est produite.");
    }
  }

  static Future<ResponseRequest> updateEventAdmin(eventId, updatedEvent) async {
    try {
      final token = await getToken();

      print(updatedEvent);

      if (token == null) {
        return ResponseRequest(success: false, message: 'Utilisateur non authentifié');
      }

      final response = await http.put(
          Uri.parse('${Env.BACKEND_URL}/events/update/admin/' + eventId),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "title": updatedEvent["title"],
            "isPrivate": updatedEvent["isPrivate"],
          })
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseRequest(success: true, message: 'Event mis a jour');
      } else {
        return ResponseRequest(success: false, message: json.decode(response.body)['error']);
      }
    } catch (error, stacktrace) {
      log('An error occurred while updating event',
          error: error, stackTrace: stacktrace);
      return ResponseRequest(success: false, message: 'Erreur lors de la mise a jour.');
    }
  }

}
