import "dart:convert";
import 'dart:developer';

import "package:client/core/services/auth_services.dart";
import 'package:client/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:client/core/models/document.dart';

class DocumentServices {
  static Future<String> generateExo(String eventId) async {
    try {
      final token = await AuthServices().getToken();
      ;

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
      final token = await AuthServices().getToken();
      ;

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
      final token = await AuthServices().getToken();
      ;

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
      final token = await AuthServices().getToken();
      ;

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

  static Future<void> likeDocument(String documentId) async {
    try {
      final token = await AuthServices().getToken();
      ;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('${Env.BACKEND_URL}/user/like/document/$documentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to like document');
      }
    } catch (error) {
      log('An error occurred while liking document', error: error);
      rethrow;
    }
  }

  static Future<void> unlikeDocument(String documentId) async {
    try {
      final token = await AuthServices().getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('${Env.BACKEND_URL}/user/unlike/document/$documentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to unlike document');
      }
    } catch (error) {
      log('An error occurred while unliking document', error: error);
      rethrow;
    }
  }

  static Future<List<Document>> getLikedDocuments() async {
    try {
      final token = await AuthServices().getToken();
      ;

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('${Env.BACKEND_URL}/user/documents/liked'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get liked documents');
      }

      final documents = jsonDecode(response.body) as List<dynamic>;
      return documents.map((document) => Document.fromJson(document)).toList();
    } catch (error) {
      log('An error occurred while getting liked documents', error: error);
      rethrow;
    }
  }
}
