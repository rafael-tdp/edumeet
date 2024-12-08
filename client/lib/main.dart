import 'package:client/core/guard/auth_gard.dart';
import 'package:client/core/models/user.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/screens/forgot_password_screen.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/swipe_cards_screen.dart';
import 'screens/events_screen.dart';
import 'utils/colors.dart';
import 'screens/conversations_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(TranslationProvider(child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, build) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const AuthGuard(child: HomePage()),
              LoginPage.routeName: (context) => const LoginPage(),
              RegisterPage.routeName: (context) => const RegisterPage(),
              HomePage.routeName: (context) => const HomePage(),
              ForgotPasswordPage.routeName: (context) =>
                  const ForgotPasswordPage(),
            },
            onGenerateRoute: (routeSettings) {
              switch (routeSettings.name) {
                case EditProfilePage.routeName:
                  return MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                          user: routeSettings.arguments as User));
              }
              return null;
            },
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            locale: provider.currentLocale.flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
          );
        },
      );
}

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  static navigateTo(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SwipeCardsPage(),
    const EventsPage(),
    const ConversationsPage(),
    const ProfilePage(
      isCurrentUser: true,
    ),
    // LoginPage(),
    // const SettingsPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          LanguageDropdown(parentContext: context),
        ],
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'images/logo-bold.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        iconSize: 30,
        selectedItemColor: AppColors.purple,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

// Exemple de page 3 (Paramètres)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page'),
    );
  }
}
