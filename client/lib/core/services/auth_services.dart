import 'dart:async';
import 'dart:convert';
import 'package:client/core/exceptions/app_exception.dart';
import 'package:client/core/models/auth/resetPasswordRequest.dart';
import 'package:client/core/models/auth/verifyCodeRequest.dart';
import 'package:client/core/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../env/env.dart';
import '../models/auth/loginRequest.dart';
import '../models/auth/registerRequest.dart';
import '../models/auth/forgotPasswordRequest.dart';
import '../models/response.dart';
import 'cache_service.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthServices {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<String?> getToken() async {
    return await CacheService.getDataFromCache('auth_token');
  }

  Future<ResponseRequest> login(
      LoginRequest loginRequest, BuildContext context) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = HttpUtils.decodeResponse(response);

      final token = responseData['token'];
      await CacheService.saveDataToCache('auth_token', token);

      // final isFirstLaunch = await CacheService.getDataFromCache('first_launch');
      // if (isFirstLaunch == null) {
      //   await CacheService.saveDataToCache('first_launch', "true");
      // }

      final userJson = responseData['user'];
      await CacheService.saveDataToCache('user_data', jsonEncode(userJson));

      final currentUser = User.fromJson(userJson);

      Provider.of<UserProvider>(context, listen: false).setUser(currentUser);

      _controller.add(AuthenticationStatus.authenticated);

      return ResponseRequest(
          success: true, message: 'Login successful', data: token);
    } else {
      return ResponseRequest(
          success: false, message: jsonDecode(response.body)['error']);
    }
  }

  Future<void> logout() async {
    await CacheService.removeDataFromCache('auth_token');
    _controller.add(AuthenticationStatus.unauthenticated);
    print('Logged out');
  }

  Future<ResponseRequest> register(RegisterRequest signupRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signupRequest.toJson()),
    );

    if (response.statusCode == 201) {
      final data = {"id": jsonDecode(response.body)['id']};
      return ResponseRequest(
          success: true, message: 'Signup successful', data: data);
    } else {
      return ResponseRequest(
          success: false, message: jsonDecode(response.body)['error']);
    }
  }

  Future<ResponseRequest> forgotPassword(
      ForgotPasswordRequest passwordResetRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(passwordResetRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(
          success: true, message: jsonDecode(response.body)['message']);
    } else {
      // throw Exception('Failed to reset password: ${jsonDecode(response.body)['error']}');
      throw AppException(message: jsonDecode(response.body)['error']);
    }
  }

  Future<ResponseRequest> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(resetPasswordRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(
          success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception(
          'Failed to reset password: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<ResponseRequest> validateAccount(
      ValidateAccountRequest verifyCodeRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/validate-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(verifyCodeRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(
          success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception(
          'Failed to verify code: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<ResponseRequest> verify(
      ValidateAccountRequest verifyCodeRequest) async {
    final response = await http.post(
      Uri.parse('${Env.BACKEND_URL}/user/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(verifyCodeRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseRequest(
          success: true, message: jsonDecode(response.body)['message']);
    } else {
      throw Exception(
          'Failed to verify code: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  void dispose() => _controller.close();
}
