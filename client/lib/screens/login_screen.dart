import 'package:client/components/edumeet_button.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:flutter/foundation.dart';
import 'package:client/screens/subjects_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/core/models/auth/loginRequest.dart';
import 'package:client/core/models/response.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/forgot_password_screen.dart';
import '../core/services/cache_service.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';
  static navigateTo(BuildContext context) {
    GoRouter.of(context).go(routeName);
    Navigator.pushNamed(context, routeName);
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthServices _authServices = AuthServices();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isPasswordVisible = false;

  Future<bool> _isFirstLogin() async {
    final isFirstLogin = await CacheService.getDataFromCache("first_launch");
    if (isFirstLogin == null) {
      return true;
    }
    return false;
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      LoginRequest loginRequest = LoginRequest(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ResponseRequest response =
          await _authServices.login(loginRequest, context);
      if (response.success) {
        if(kIsWeb){
          context.push(AdminPage.routeName);
        }
        bool isFirstLogin = await _isFirstLogin();
        if (isFirstLogin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubjectsPage()),
          );
        } else {
          context.push(HomePage.routeName);
        }
      } else {
        setState(() {
          _errorMessage = response.message;
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

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ResponseRequest response = await _authServices.loginWithGoogle(context);
      if (response.success) {
        bool isFirstLogin = await _isFirstLogin();
        if (isFirstLogin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubjectsPage()),
          );
        } else {
          context.go(HomePage.routeName);
        }
      } else {
        setState(() {
          _errorMessage = response.message;
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
                    t.login.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.login.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: t.user.email,
                      hintText: 'exemple@mail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: t.user.password,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyPassword;
                      }
                      if (value.length < 6) {
                        return t.form.shortPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.go(ForgotPasswordPage.routeName);
                      },
                      child: Text(
                        t.login.forgotPassword,
                        style: const TextStyle(color: AppColors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  EdumeetButton(
                    text: t.app.login,
                    backgroundColor: AppColors.purple,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        await _login();
                      }
                    },
                    isLoader: _isLoading,
                    width: 250,
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  if (!kIsWeb)
                  Hero(
                    tag: 'edumeet-google-login',
                    child: EdumeetButton(
                      text: "Se connecter avec Google",
                      backgroundColor: Colors.red,
                      icon: SvgPicture.asset(
                        'icons/google-white.svg',
                        width: 20,
                        height: 20,
                      ),
                      width: 250,
                      onPressed: () async {
                        await _loginWithGoogle();
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (!kIsWeb)
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(t.login.noAccount),
                        TextButton(
                          onPressed: () {
                            context.go(RegisterPage.routeName);
                          },
                          child: Text(
                            t.login.createAccount,
                            style: const TextStyle(color: AppColors.purple),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
