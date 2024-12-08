import 'package:client/core/models/auth/resetPasswordRequest.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import '../core/services/auth_services.dart';
import '../utils/colors.dart';
import '../widgets/password_condition_widget.dart';
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String code;
  final String email;

  const ResetPasswordPage({super.key, required this.email, required this.code});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthServices _authServices = AuthServices();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUpperCase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasDigit => _passwordController.text.contains(RegExp(r'\d'));
  bool get _hasSpecialChar => _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(
        email: widget.email,
        code: widget.code,
        password: _passwordController.text,
      );
      final response = await _authServices.resetPassword(resetPasswordRequest);
      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.auth.passwordResertSuccess)),
        );
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage())
        );
      } else {
        setState(() {
          _errorMessage = t.error.failedToResetPassword;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.auth.resetPassword,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.auth.enterNewPassword,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: t.user.newPassword,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyPassword;
                      }
                      if (!_hasMinLength) {
                        return t.form.shortPassword;
                      }
                      if (!_hasUpperCase) {
                        return t.form.passwordUpperCase;
                      }
                      if (!_hasDigit) {
                        return t.form.passwordDigit;
                      }
                      if (!_hasSpecialChar) {
                        return t.form.passwordSpecialChar;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: t.form.confirmPassword,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.pleaseConfirmPassword;
                      }
                      if (value != _passwordController.text) {
                        return t.form.passwordNotMatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordConditionWidget(text: t.form.shortPassword, isValid: _hasMinLength),
                      PasswordConditionWidget(text: t.form.passwordUpperCase, isValid: _hasUpperCase),
                      PasswordConditionWidget(text: t.form.passwordDigit, isValid: _hasDigit),
                      PasswordConditionWidget(text: t.form.passwordSpecialChar, isValid: _hasSpecialChar),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          await _resetPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Text(
                        t.auth.resetPassword,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
