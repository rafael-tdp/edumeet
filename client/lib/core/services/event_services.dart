import 'dart:convert';
import 'dart:developer';
import 'package:client/core/services/auth_services.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

class EventServices {

  static Future<List<Event>> getEvents() async {
    try {
      final token = await AuthServices().getToken();

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
      final token = await AuthServices().getToken();

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
      final token = await AuthServices().getToken();

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
      final token = await AuthServices().getToken();

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
}
