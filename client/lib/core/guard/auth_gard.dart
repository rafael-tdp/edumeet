import 'package:client/core/services/cache_service.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/welcome/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AuthGuardState createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  bool _isFirstLaunch = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isFirstLaunch = await CacheService.getDataFromCache("first_launch");
    final isLoggedIn = await CacheService.getDataFromCache("auth_token");
    setState(() {
      _isFirstLaunch = isFirstLaunch == null;
      _isLoggedIn = isLoggedIn != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLaunch && !kIsWeb) {
      return const WelcomeScreen();
    }
    else if (!_isLoggedIn) {
      return const LoginPage();
    } else {
      return widget.child;
    }
  }
}