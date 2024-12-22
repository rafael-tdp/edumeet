import 'package:client/core/models/response.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/valide_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:go_router/go_router.dart';
import '../core/models/auth/registerRequest.dart';
import '../core/services/adresse_services.dart';
import '../core/services/auth_services.dart';
import '../utils/colors.dart';
import '../widgets/password_condition_widget.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String routeName = '/register';
  static navigateTo(BuildContext context) {
    GoRouter.of(context).go(routeName);
    Navigator.pushNamed(context, routeName);
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthServices _authServices = AuthServices();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isPasswordVisible = false;
  bool _isChecked = false;

  bool get _isEmailValid =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text);
  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUpperCase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasDigit => _passwordController.text.contains(RegExp(r'\d'));
  bool get _hasSpecialChar =>
      _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get _isPasswordMatch =>
      _passwordController.text == _confirmPasswordController.text;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_isChecked) {
      setState(() {
        _errorMessage = t.form.haveToAcceptConditions;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      RegisterRequest registerRequest = RegisterRequest(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        birthDate: custom_date_utils.DateUtils.stringToFomattedDateTime(
            _birthDateController.text),
        address: _addressController.text,
      );
      ResponseRequest response = await _authServices.register(registerRequest);
      if (response.success) {
        final userId = response.data["id"];
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ValidateAccountPage(
        //           isResetPassword: false, email: registerRequest.email)),
        // );
        context.go(ValidateAccountPage.routeName, extra: {
          'isResetPassword': false,
          'email': registerRequest.email,
        });
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
                    t.register.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.register.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: t.user.username,
                      hintText: 'cdelmas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyUsername;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      labelText: t.user.firstname,
                      hintText: 'Christiane',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyFirstname;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                      labelText: t.user.name,
                      hintText: 'Delmas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyLastname;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      labelText: t.user.birthdate,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => custom_date_utils.DateUtils.selectDate(
                        context, _birthDateController),
                  ),
                  const SizedBox(height: 16),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyEmail;
                      }
                      if (!_isEmailValid) {
                        return t.form.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty ||
                          textEditingValue.text.length < 5) {
                        return const Iterable<String>.empty();
                      }
                      return fetchAddressSuggestions(textEditingValue.text);
                    },
                    onSelected: (String selection) {
                      _addressController.text = selection;
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextFormField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        decoration: InputDecoration(
                          labelText: t.user.address,
                          hintText: '1 rue de Paris, 75000 Paris',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return t.form.invalidAddress;
                          }
                          return null;
                        },
                      );
                    },
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
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: t.app.confirm,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.form.emptyConfirmPassword;
                      }
                      if (!_isPasswordMatch) {
                        return t.form.passwordMismatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordConditionWidget(
                          text: t.form.shortPassword, isValid: _hasMinLength),
                      PasswordConditionWidget(
                          text: t.form.passwordUpperCase,
                          isValid: _hasUpperCase),
                      PasswordConditionWidget(
                          text: t.form.passwordDigit, isValid: _hasDigit),
                      PasswordConditionWidget(
                          text: t.form.passwordSpecialChar,
                          isValid: _hasSpecialChar),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          t.register.conditions,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.gray,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          await _register();
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              t.app.signup,
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.app.alreadyHaveAccount,
                        style: const TextStyle(color: AppColors.gray),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(LoginPage.routeName);
                        },
                        child: Text(
                          t.app.login,
                          style: const TextStyle(
                            color: AppColors.purple,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
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
}
