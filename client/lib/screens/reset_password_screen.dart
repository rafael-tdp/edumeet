import 'package:client/core/models/auth/resetPassword.dart';
import 'package:flutter/material.dart';
import '../core/services/auth_services.dart';
import '../utils/colors.dart';
import '../widgets/password_condition_widget.dart';
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;

  const ResetPasswordPage({super.key, required this.token});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
        plainPassword: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        code: widget.token,
      );
      final response = await AuthServices.resetPassword(resetPasswordRequest);
      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mot de passe réinitialisé avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage())
        );
      } else {
        setState(() {
          _errorMessage = 'La réinitialisation a échoué';
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
                  const Text(
                    'Réinitialiser le mot de passe',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Entrez votre nouveau mot de passe',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Nouveau mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (!_hasMinLength) {
                        return 'Le mot de passe doit comporter au moins 8 caractères';
                      }
                      if (!_hasUpperCase) {
                        return 'Le mot de passe doit comporter au moins une lettre majuscule';
                      }
                      if (!_hasDigit) {
                        return 'Le mot de passe doit comporter au moins un chiffre';
                      }
                      if (!_hasSpecialChar) {
                        return 'Le mot de passe doit comporter au moins un caractère spécial';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le nouveau mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      }
                      if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordConditionWidget(text: "Au moins 8 caractères", isValid: _hasMinLength),
                      PasswordConditionWidget(text: "Au moins une lettre majuscule", isValid: _hasUpperCase),
                      PasswordConditionWidget(text: "Au moins un chiffre", isValid: _hasDigit),
                      PasswordConditionWidget(text: "Au moins un caractère spécial", isValid: _hasSpecialChar),
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
                          : const Text(
                        'Réinitialiser le mot de passe',
                        style: TextStyle(
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
