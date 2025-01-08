import 'dart:convert';
import 'dart:developer';
import 'package:client/core/models/response.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import 'package:client/core/models/event.dart';

import 'cache_service.dart';

class EventServices {
  static Future<List<Event>> getEvents(
    List<String> subjects,
    double? latitude,
    double? longitude,
    String eventType,
    double? distance,
  ) async {
    try {
      final token = await AuthServices().getToken();

      if (token == null) {
        return [];
      }

      final queryParameters = {
        if (subjects.isNotEmpty) 'subjects': subjects.join(','),
        if (latitude != null) 'latitude': latitude.toString(),
        if (longitude != null) 'longitude': longitude.toString(),
        if (eventType.isNotEmpty) 'type': eventType,
        if (distance != null) 'distance': distance.toString(),
      };

      final uri = Uri.parse('${Env.BACKEND_URL}/events')
          .replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final events = HttpUtils.decodeResponse(response) as List<dynamic>;
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
      final events = HttpUtils.decodeResponse(response) as List<dynamic>;
      await CacheService.saveDataToCache('events', jsonEncode(events.map((event) => event).toList()));
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving events', error: error);
      return [];
    }
  }

  static Future<List<Event>> getCurrentUserEventsFromCache() async {
    try {
      final events = await CacheService.getDataFromCache('events');
      if (events != null) {
        var savedEvents = (jsonDecode(events) as List)
            .map((event) => Event.fromJson(event))
            .toList();
        return savedEvents;
      }
      return [];
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
      final events = HttpUtils.decodeResponse(response) as List<dynamic>;
      await CacheService.saveDataToCache('events', jsonEncode(events.map((event) => event).toList()));
      return events.map((event) => Event.fromJson(event)).toList();
    } catch (error) {
      log('An error occurred while retrieving events', error: error);
      return [];
    }
  }

  static Future<List<Event>> getEventsCreatedByCurrentUserFromCache() async {
    try {
      final events = await CacheService.getDataFromCache('events');
      if (events != null) {
        var savedEvents =  (jsonDecode(events) as List)
            .map((event) => Event.fromJson(event))
            .toList();
        return savedEvents;
      }
      return [];
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
      final event = HttpUtils.decodeResponse(response);
      await CacheService.saveDataToCache('event_details_$eventId', jsonEncode(event));
      return Event.fromJson(event);
    } catch (error) {
      log('An error occurred while retrieving event details', error: error);
      rethrow;
    }
  }

  static Future<Event> getEventDetailsFromCache(String eventId) async {
  try {
    final event = await CacheService.getDataFromCache('event_details_$eventId');
    if (event != null) {
      return Event.fromJson(jsonDecode(event));
    }
    return Event(
      id: '',
      title: '',
      description: '',
      startDate: DateTime.now().toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      isPrivate: false,
    );
  } catch (error) {
    log('An error occurred while retrieving event details', error: error);
    rethrow;
  }
}

  static Future<Event> getEvent(String eventId) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/events/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get event');
      }

      final event = jsonDecode(response.body);
      return Event.fromJson(event);
    } catch (error) {
      log('An error occurred while getting event', error: error);
      rethrow;
    }
  }

  static Future<Event> createEvent(Event event) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

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

  static Future<void> updateEvent(Event event) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('${Env.BACKEND_URL}/events/${event.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update event');
      }
    } catch (error) {
      log('An error occurred while updating event', error: error);
      rethrow;
    }
  }

  static Future<String> generateExo(String eventId) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      const statement =
          "Génère moi un exercice d'algorithme niveau DUT INFORMATIQUE 1ere année";

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

      final responseBody = utf8.decode(response.bodyBytes);
      final decodedResponse = jsonDecode(responseBody);

      if (decodedResponse['exo'] == null) {
        throw Exception(
            'The response does not contain the expected "exo" field');
      }

      return decodedResponse['exo'];
    } catch (error) {
      log('An error occurred while generating exo', error: error);
      rethrow;
    }
  }

  static Future<String> generateCorrection(
      String eventId, String exercise) async {
    try {
      final token = await AuthServices().getToken();;

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

      final responseBody = utf8.decode(response.bodyBytes);
      final decodedResponse = jsonDecode(responseBody);

      if (decodedResponse['correction'] == null) {
        throw Exception(
            'The response does not contain the expected "correction" field');
      }

      return decodedResponse['correction'];
    } catch (error) {
      log('An error occurred while generating correction', error: error);
      rethrow;
    }
  }

  static Future<void> saveDocument(
      String eventId, String content, String docType) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      if (docType != 'EXERCISE' && docType != 'CORRECTION') {
        throw Exception('Invalid document type');
      }

      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/ai/save-document'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'content': content,
          'doc_type': docType,
          'event_id': eventId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save document');
      }
    } catch (error) {
      log('An error occurred while saving document', error: error);
      rethrow;
    }
  }

  // get document content
  static Future<String> getDocumentContent(String documentId) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/document/$documentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get document content');
      }

      final documentContent = response.body;
      return documentContent;
    } catch (error) {
      log('An error occurred while getting document content', error: error);
      rethrow;
    }
  }

  static Future<void> leaveEvent(String participantId) async {
    try {
      final token = await AuthServices().getToken();;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse('${Env.BACKEND_URL}/participants/$participantId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to leave event');
      }
    } catch (error) {
      log('An error occurred while leaving event', error: error);
      rethrow;
    }
  }

  static Future<ResponseRequest> deleteEvent(eventId) async {
    try {
      final token = await AuthServices().getToken();

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

  static Future<dynamic> joinEventWithCode(String code) async {
    try {
      final token = await AuthServices().getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/events/join/$code'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to join event');
      }

      return jsonDecode(response.body);
    } catch (error) {
      log('An error occurred while joining event', error: error);
      rethrow;
    }
  }

  static Future<ResponseRequest> updateEventAdmin(eventId, updatedEvent) async {
    try {
      final token = await AuthServices().getToken();

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
