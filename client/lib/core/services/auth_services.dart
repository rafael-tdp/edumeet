import 'dart:convert';
import 'package:client/core/models/auth/resetPassword.dart';
import 'package:client/secureStorage.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/auth/login.dart';
import '../models/auth/register.dart';
import '../models/auth/forgotPassword.dart';
import '../models/response.dart';

class AuthServices {
  static Future<ResponseRequest> login(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      SecureStorage().writeSecureData('auth_token', token);
      print('Login ok: $token');
      SecureStorage().readSecureData('auth_token').then((value) => print('Read token: $value'));
      return ResponseRequest(success: true, message: 'Login successful', data: token);
    } else {
      throw Exception('Failed to login: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ResponseRequest> register(RegisterRequest signupRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(signupRequest.toJson()),
    );

    if (response.statusCode == 201) {
      return ResponseRequest(success: true, message: 'Signup successful');
    } else {
      throw Exception('Failed to signup: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ResponseRequest> forgotPassword(ForgotPasswordRequest passwordResetRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(passwordResetRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ResponseRequest> resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    final response = await http.post(
      //TODO: Change the URL to the correct one
      Uri.parse('${Env.BACKEND_URL}/user/reset-password/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'plainPassword': resetPasswordRequest.plainPassword,
        'confirmPassword': resetPasswordRequest.confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}