import 'package:client/core/models/auth/verifyCodeRequest.dart';
import 'package:client/core/models/response.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/colors.dart';
import 'login_screen.dart';

class ValidateAccountPage extends StatefulWidget {
  static const String routeName = '/validate-account';
  static navigateTo(BuildContext context,
      {required bool isResetPassword, required String email}) {
    Navigator.pushNamed(context, routeName,
        arguments: {'isResetPassword': isResetPassword, 'email': email});
  }
  final bool isResetPassword;
  final String email;

  const ValidateAccountPage(
      {super.key, required this.isResetPassword, required this.email});

  @override
  _ValidateAccountPageState createState() => _ValidateAccountPageState();
}

class _ValidateAccountPageState extends State<ValidateAccountPage> {
  final AuthServices _authServices = AuthServices();
  final PageController _pageController = PageController();
  final _codeController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _validateCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ValidateAccountRequest verifyCodeRequest = ValidateAccountRequest(
        code: _codeController.text,
        email: widget.email,
      );
      if (widget.isResetPassword) {
        ResponseRequest response =
            await _authServices.verify(verifyCodeRequest);
        if (!response.success) {
          setState(() {
            _errorMessage = response.message;
          });
          return;
        }
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        ResponseRequest response =
            await _authServices.validateAccount(verifyCodeRequest);
        if (!response.success) {
          setState(() {
            _errorMessage = response.message;
          });
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.register.registerConfirm)),
        );
        context.go(LoginPage.routeName);
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
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildVerifyCodeForm(),
              if (widget.isResetPassword)
                ResetPasswordPage(
                    email: widget.email, code: _codeController.text)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyCodeForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.verify.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.verify.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _codeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: t.verify.inputLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: const Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return t.verify.error;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  await _validateCode();
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
                      t.verify.button,
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
    );
  }
}
