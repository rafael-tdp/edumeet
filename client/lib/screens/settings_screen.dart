import 'package:client/screens/favorite_documents_screen.dart';
import 'package:client/screens/language_screen.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/subjects_screen.dart';
import 'package:client/utils/language.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/edumeet_button.dart';
import '../core/models/user.dart';
import '../core/services/auth_services.dart';
import '../i18n/generated/translations.g.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  static navigateTo(BuildContext context) {
    context.push(routeName);
  }

  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<User?> _userFuture;
  final AuthServices _authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    _userFuture = Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final local = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.page.settings),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text(t.user.anonymous));
          }

          final User user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    t.settings.account,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: DiceBearBuilder(
                        seed: user.username,
                        sprite: DiceBearSprite.values.firstWhere(
                              (sprite) => sprite.name == (user.picture),
                          orElse: () => DiceBearSprite.bottts,
                        ),
                      ).build().toImage(height: 40)),
                  title: Text(user.firstname ?? t.user.anonymous),
                  subtitle: Text(user.username),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () async {
                    await context.push(
                      ProfilePage.routeName,
                    );
                    setState(() {
                      _userFuture =
                          Provider.of<UserProvider>(context, listen: false)
                              .getUser();
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book, color: Colors.green),
                  title: Text(t.settings.manageSubjects),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    SubjectsPage.navigateTo(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title:  Text(t.app.favoriteDocuments),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    FavoriteDocumentsPage.navigateTo(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    t.settings.settings,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.orange),
                  title: Text(t.settings.language),
                  subtitle: Text(languageNames[local] ?? t.app.unknown),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    LanguagePage.navigateTo(context);
                  },
                ),
                const SizedBox(height: 50),
                Center(
                  child: EdumeetButton(
                    text: t.profile.logout,
                    backgroundColor: Colors.redAccent,
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await _authServices.logout();
                      Provider.of<UserProvider>(context, listen: false)
                          .clearUser();
                      context.go(LoginPage.routeName);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
