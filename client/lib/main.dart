import 'package:client/core/models/event.dart';
import 'package:client/core/services/sse_services.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/core/guard/auth_gard.dart';
import 'package:client/core/models/user.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/core/services/message_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/screens/event_details_page.dart';
import 'package:client/screens/valide_account_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/forgot_password_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'components/event/participants_list.dart';
import 'screens/swipe_cards_screen.dart';
import 'screens/events_screen.dart';
import 'screens/conversations_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:http/http.dart' as http;
import 'package:client/core/services/sse_client_services.dart' as customSSE;

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => Scaffold(
            body: HomePage(child: child),
          ),
        routes: [
          GoRoute(
            path: HomePage.routeName,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: EventsPage.routeName,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const EventsPage(),
          ),
          GoRoute(
            path: ConversationsPage.routeName,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ConversationsPage(),
            routes: [
              GoRoute(
                path: ':userName/details',
                builder: (context, state) {
                  final userName = state.extra as String;
                  return ChatPage(userName: userName);
                },
              )
            ],
          ),
          GoRoute(
            path: ProfilePage.routeName,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ProfilePage(isCurrentUser: true),
          ),
        ],
      ),
      GoRoute(
          path: '/',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const AuthGuard(child: HomePage())
      ),
      GoRoute(
          path: LoginPage.routeName,
          name: LoginPage.routeName.replaceAll("/", ""),
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const LoginPage()
      ),
      GoRoute(
          path: RegisterPage.routeName,
          name: RegisterPage.routeName.replaceAll("/", ""),
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const RegisterPage()
      ),
      GoRoute(
          path: HomePage.routeName,
          name: HomePage.routeName.replaceAll("/", ""),
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const HomePage()
      ),
      GoRoute(
          path: ForgotPasswordPage.routeName,
          name: ForgotPasswordPage.routeName.replaceAll("/", ""),
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const ForgotPasswordPage()
      ),
      GoRoute(
        path: EditProfilePage.routeName,
        name: EditProfilePage.routeName.replaceAll("/", ""),
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => EditProfilePage(
          user: state.extra as User,
        ),
      ),
      GoRoute(
        path: ValidateAccountPage.routeName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ValidateAccountPage(
          isResetPassword: state.pathParameters['isResetPassword'] == 'true',
          email: state.pathParameters['email']!,
        ),
      ),
      GoRoute(
        path: ProfilePage.routeName,
        parentNavigatorKey: _rootNavigatorKey,
        name: ProfilePage.routeName.replaceAll("/", ""),
        builder: (context, state) => const ProfilePage(
          isCurrentUser: false,
        ),
      ),
      GoRoute(
          path: UserProfileWrapper.routeName,
          parentNavigatorKey: _rootNavigatorKey,
          name: UserProfileWrapper.routeName.replaceAll("/", ""),
          builder: (context, state) => UserProfileWrapper(
            user: state.pathParameters['user'] as Map<String, String>,
            isCurrentUser: state.pathParameters['isCurrentUser'] as bool,
          )
      ),
      GoRoute(
          path: '${EventChatPage.routeName}/:eventId',
          parentNavigatorKey: _rootNavigatorKey,
          name: EventChatPage.routeName.replaceAll("/", ""),
          builder: (context, state) {
            final eventId = state.pathParameters['eventId']!;
            final event = state.extra as Event;
            return EventChatPage(
              eventId: eventId,
              event: event,
            );
          },
      ),
      GoRoute(
        path: '${EventsPage.routeName}/:eventId/details',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final eventId = state.pathParameters['eventId']!;
          final currentUser = state.extra as User;
          return EventDetailsPage(
            eventId: eventId,
            currentUser: currentUser,
          );
        },
      ),
]);

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => TranslationProvider(child: const MyApp()),
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
            routerConfig: _router,
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
    context.go(routeName);
  }
  final Widget? child;
  const HomePage({super.key, this.child});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SseServices _sseServices = SseServices();
  final List<String> _messages = [];
  late customSSE.SSEClient _sseClient;
  late Stream<String> _sseStream;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SwipeCardsPage(),
    const EventsPage(),
    const ConversationsPage(),
    const ProfilePage(
      isCurrentUser: true,
    ),
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
        context.go(ProfilePage.routeName);
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SSEClient.subscribeToSSE(
        method: SSERequestType.GET,
        url:
        'http://localhost:3000/chats/connect',
        header: {
          "Authorization":
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1ha2FuQHVzZXIuY29tIiwidXNlcl9pZCI6IjAxSkZaS1ROUlRXWFpLVlo1RzlDUks4UU5DIiwicm9sZSI6IlVTRVIiLCJleHAiOjE3Mzc3NDYwODN9.hMGvta5zzF97gE1Kg_Odsh2GM_iYQPZNTlbiv_-Cods',
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
        }).listen((event) {
      print('Id: ' + event.id!);
      print('Event: ' + event.event!);
      print('Data: ' + event.data!);
    },
    );
    // _sseServices.connectToSse();
  
    // _sseClient = customSSE.SSEClient('http://localhost:3000/chats/connect');
    // _sseStream = _sseClient.connect();
    // _listenToSSE();
  }

  void _listenToSSE() {
    _sseStream.listen((message) {
      setState(() {
        print('Message reçu : $message');
        _messages.add(message);
      });
    }, onError: (error) {
      print('Erreur : $error');
    }, onDone: () {
      print('Connexion SSE terminée');
    });
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
    return Center(
      child: Text(t.page.settingsPage),
    );
  }
}
