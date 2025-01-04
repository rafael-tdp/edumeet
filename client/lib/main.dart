import 'package:client/core/services/sse_services.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/router.dart';
import 'package:client/screens/friends_list_screen.dart';
import 'package:client/screens/settings_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:client/screens/profile_screen.dart';
import 'core/services/cache_service.dart';
import 'screens/swipe_cards_screen.dart';
import 'screens/events_screen.dart';
import 'screens/conversations_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());

  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.loadUserFromCache();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: TranslationProvider(child: const MyApp()),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, build) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
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
    context.go(HomePage.routeName);
  }

  final Widget? child;
  const HomePage({super.key, this.child});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SseServices _sseServices = SseServices();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SwipeCardsPage(),
    const EventsPage(),
    const ConversationsPage(),
    const FriendsListPage(),
    const SettingsPage(),
  ];

  void _onTabTapped(int index) {
    switch (index) {
      case 0:
        context.go(HomePage.routeName);
        break;
      case 1:
        context.go(EventsPage.routeName);
        break;
      case 2:
        context.go(ConversationsPage.routeName);
        break;
      case 3:
        context.go(FriendsListPage.routeName);
        break;
      case 4:
        context.go(SettingsPage.routeName);
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _isFirstLaunch() async {
    final isFirstLaunch = await CacheService.getDataFromCache("first_launch");
    if (isFirstLaunch == null) {
      await CacheService.saveDataToCache("first_launch", "false");
    }
  }

  @override
  void initState() {
    super.initState();
    _sseServices.connectToSse();
    _isFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: '',
          ),
          //Sous menu pour les amis
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}