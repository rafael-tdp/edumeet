import 'package:client/core/models/event.dart';
import 'package:client/main.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/screens/conversations_screen.dart';
import 'package:client/screens/create_documents_screen.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:client/screens/event_details_page.dart';
import 'package:client/screens/events_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/valide_account_screen.dart';
import 'package:flutter/material.dart';
import 'components/event/participants_list.dart';
import 'core/models/user.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/screens/forgot_password_screen.dart';
import 'package:client/core/guard/auth_gard.dart';
import 'package:client/screens/create_event_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _router =
GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
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
            routes: [
              GoRoute(
                path: '${EventChatPage.routeName}',
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
            ]
          ),
        ],
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
        routes: [
          GoRoute(
            path: EditProfilePage.routeName,
            name: EditProfilePage.routeName.replaceAll("/", ""),
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => EditProfilePage(
              user: state.extra as User,
            ),
          ),
        ]
      ),
    ],
  ),
  GoRoute(
      path: '/',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthGuard(child: HomePage())),
  GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.routeName.replaceAll("/", ""),
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage()),
  GoRoute(
      path: RegisterPage.routeName,
      name: RegisterPage.routeName.replaceAll("/", ""),
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RegisterPage()),
  GoRoute(
      path: HomePage.routeName,
      name: HomePage.routeName.replaceAll("/", ""),
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HomePage()),
  GoRoute(
      path: ForgotPasswordPage.routeName,
      name: ForgotPasswordPage.routeName.replaceAll("/", ""),
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ForgotPasswordPage()),
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
]);

GoRouter get router => _router;