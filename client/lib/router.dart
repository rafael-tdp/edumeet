import 'package:client/main.dart';
import 'package:client/screens/admin/admin_page.dart';
import 'package:client/screens/admin/badge_page.dart';
import 'package:client/screens/admin/dashboard_page.dart';
import 'package:client/screens/admin/event_page.dart';
import 'package:client/screens/admin/subject_page.dart';
import 'package:client/screens/admin/user_page.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/screens/conversations_screen.dart';
import 'package:client/screens/create_documents_screen.dart';
import 'package:client/screens/document_viewer_screen.dart';
import 'package:client/screens/edit_event_screen.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/screens/event_details_page.dart';
import 'package:client/screens/events_screen.dart';
import 'package:client/screens/favorite_documents_screen.dart';
import 'package:client/screens/friends_list_screen.dart';
import 'package:client/screens/language_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/settings_screen.dart';
import 'package:client/screens/subjects_screen.dart';
import 'package:client/screens/valide_account_screen.dart';
import 'package:flutter/material.dart';
import 'core/models/user.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/forgot_password_screen.dart';
import 'package:client/core/guard/auth_gard.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final initialRoute = kIsWeb ? AdminPage.routeName : '/home';

List<RouteBase> mobileRoutes = [
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => Scaffold(
      body: const AuthGuard(child: HomePage()),
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
        routes: [
          GoRoute(
            path: CreateEventPage.routeName,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const CreateEventPage(),
            routes: [
              GoRoute(
                path: CreateDocumentsPage.routeName,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final eventId = state.extra as String;
                  return CreateDocumentsPage(eventId: eventId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/:eventId/details',
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
          GoRoute(
            path: '/:eventId/edit',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final eventId = state.pathParameters['eventId']!;
              return EditEventPage(eventId: eventId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: ConversationsPage.routeName,
        parentNavigatorKey: _shellNavigatorKey,
        builder: (context, state) => const ConversationsPage(),
      ),
      GoRoute(
        path: SettingsPage.routeName,
        name: SettingsPage.routeName.replaceAll("/", ""),
        parentNavigatorKey: _shellNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: FriendsListPage.routeName,
        name: FriendsListPage.routeName.replaceAll("/", ""),
        parentNavigatorKey: _shellNavigatorKey,
        builder: (context, state) => const FriendsListPage(),
      ),
    ],
  ),
  GoRoute(
    path: LanguagePage.routeName,
    name: LanguagePage.routeName.replaceAll("/", ""),
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const LanguagePage(),
  ),
  GoRoute(
    path: SubjectsPage.routeName,
    name: SubjectsPage.routeName.replaceAll("/", ""),
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const SubjectsPage(),
  ),
  GoRoute(
    path: ValidateAccountPage.routeName,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      if (extra == null || !extra.containsKey('email')) {
        throw Exception('Missing required data: email or isResetPassword');
      }

      return ValidateAccountPage(
        isResetPassword: extra['isResetPassword'] as bool,
        email: extra['email'] as String,
      );
    },
  ),
  GoRoute(
    path: ProfilePage.routeName,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const ProfilePage(
      userId: null,
    ),
    routes: [
      GoRoute(
        path: EditProfilePage.routeName,
        name: EditProfilePage.routeName.replaceAll("/", ""),
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => EditProfilePage(
          user: state.extra as User,
        ),
      ),
    ],
  ),
  GoRoute(
    path: "${ProfilePage.routeName}/:userId",
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => ProfilePage(
      userId: state.pathParameters['userId'],
    ),
  ),
  GoRoute(
    path: '${ChatPage.routeName}/:userName',
    parentNavigatorKey: _rootNavigatorKey,
    name: ChatPage.routeName.replaceAll("/", ""),
    builder: (context, state) {
      final userName = state.pathParameters['userName']!;
      final conversationId = state.extra as String;
      return ChatPage(userName: userName, friendId: conversationId);
    },
  ),
  GoRoute(
    path: '${EventChatPage.routeName}/:eventId',
    parentNavigatorKey: _rootNavigatorKey,
    name: EventChatPage.routeName.replaceAll("/", ""),
    builder: (context, state) {
      final eventId = state.pathParameters['eventId']!;
      return EventChatPage(eventId: eventId);
    },
  ),
  GoRoute(
    path: FavoriteDocumentsPage.routeName,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const FavoriteDocumentsPage(),
  ),
  GoRoute(
    path: DocumentViewerPage.routeName,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) {
      final documentId = state.pathParameters['documentId']!;
      return DocumentViewerPage(
        documentId: documentId,
      );
    },
  ),
];

List<RouteBase> commonRoutes = [
  GoRoute(
    path: LoginPage.routeName,
    name: LoginPage.routeName.replaceAll("/", ""),
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: RegisterPage.routeName,
    name: RegisterPage.routeName.replaceAll("/", ""),
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const RegisterPage(),
  ),
  GoRoute(
    path: ForgotPasswordPage.routeName,
    name: ForgotPasswordPage.routeName.replaceAll("/", ""),
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const ForgotPasswordPage(),
  ),
];

List<RouteBase> _webRoutes() {
  return [
    GoRoute(
        path: '/',
        redirect: (context, state) {
          return AdminPage.routeName;
        }),
    GoRoute(
      path: AdminPage.routeName,
      builder: (context, state) {
        return const AuthGuard(child: AdminPage());
      },
      routes: [
        GoRoute(
          path: SubjectPage.routeName,
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(
          path: SubjectPage.routeName,
          builder: (context, state) => SubjectPage(),
        ),
        GoRoute(
          path: BadgePage.routeName,
          builder: (context, state) => BadgePage(),
        ),
        GoRoute(
          path: EventsPageAdmin.routeName,
          builder: (context, state) => EventsPageAdmin(),
        ),
        GoRoute(
          path: UserPageAdmin.routeName,
          builder: (context, state) => UserPageAdmin(),
        ),
      ],
    ),
  ];
}

final _router = GoRouter(
  initialLocation: initialRoute,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ...commonRoutes,
    if (kIsWeb) ..._webRoutes(),
    if (!kIsWeb) ...mobileRoutes,
  ],
);

GoRouter get router => _router;
