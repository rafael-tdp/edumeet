import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/auth/login.dart';
import '../models/auth/register.dart';
import '../models/auth/resetPassword.dart';
import '../models/response.dart';

class AuthServices {
  static Future<ResponseRequest> login(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse(Env.BACKEND_URL + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ResponseRequest> signup(SignupRequest signupRequest) async {
    final response = await http.post(
      Uri.parse(Env.BACKEND_URL + '/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(signupRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to signup: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ResponseRequest> resetPassword(PasswordResetRequest passwordResetRequest) async {
    final response = await http.post(
      Uri.parse(Env.BACKEND_URL + '/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(passwordResetRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}