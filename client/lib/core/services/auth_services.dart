import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/core/models/auth/resetPassword.dart';
import 'package:client/core/models/auth/verifyCode.dart';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../models/auth/login.dart';
import '../models/auth/register.dart';
import '../models/auth/forgotPassword.dart';
import '../models/response.dart';

class AuthServices {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    final token = await getToken();

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('${Env.BACKEND_URL}/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<ResponseRequest> login(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      return ResponseRequest(success: true, message: 'Login successful', data: token);
    } else {
      return ResponseRequest(success: false, message: jsonDecode(response.body)['error']);
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print('Logged out');
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
      return ResponseRequest(success: false, message: jsonDecode(response.body)['error']);
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
      Uri.parse('${Env.BACKEND_URL}/user/reset-password/${resetPasswordRequest.code}'),
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

  static Future<ResponseRequest> valideCode(VerifyCodeRequest verifyCodeRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/validate-user'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code': verifyCodeRequest.code,
        'email': verifyCodeRequest.email,
      }),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception('Failed to verify code: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}