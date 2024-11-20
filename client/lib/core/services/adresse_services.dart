import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchAddressSuggestions(String query) async {
  final response = await http.get(Uri.parse('https://api-adresse.data.gouv.fr/search/?q=$query'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return (data['features'] as List)
        .map((feature) => feature['properties']['label'] as String)
        .toList();
  } else {
    throw Exception('Failed to load address suggestions');
  }
}