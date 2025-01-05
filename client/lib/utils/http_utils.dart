import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpUtils {
  static dynamic decodeResponse(http.Response response) {
    final utf8DecodedBody = utf8.decode(response.bodyBytes);
    return jsonDecode(utf8DecodedBody);
  }
}
