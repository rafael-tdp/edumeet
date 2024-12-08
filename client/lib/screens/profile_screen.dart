import 'package:client/core/models/user.dart';
import 'package:client/generated/locale_keys.g.dart';
import 'package:client/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/i18n/generated/translations.g.dart';

import '../widgets/language_dropdown_button.dart';

class ProfilePage extends StatefulWidget {
  final bool isCurrentUser;

  const ProfilePage({
    super.key,
    this.isCurrentUser = false,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();
  late User user = User(
    id: '',
    email: '',
    username: '',
    lastname: '',
    firstname: '',
    birthDate: DateTime.now(),
    bio: '',
    picture: '',
    reportNumber: 0,
    address: '',
    role: '',
  );

  @override
  void initState() {
    super.initState();
    _userServices.getUserInfo().then((value) {
      setState(() {
        user = value.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  user.picture ?? '',
                  scale: 1,
                ),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
              const SizedBox(height: 20),
              Text(
                (user.firstname.isNotEmpty && user.lastname.isNotEmpty)
                  ? '${user.firstname.substring(0, 1).toUpperCase()}${user.firstname.substring(1)} ${user.lastname.substring(0, 1).toUpperCase()}${user.lastname.substring(1)} !'
                  : 'Anonyme',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.bio != null && user.bio!.isNotEmpty ? user.bio! : "Aucune description",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              LanguageDropdownButton(appContext: context),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: AppColors.purple),
                      title: Text(LocaleKeys.user_email.tr()),
                      subtitle: Text(
                        user.email,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person, color: AppColors.purple),
                      title: Text(LocaleKeys.user_username.tr()),
                      subtitle: Text(
                        user.username,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: AppColors.purple),
                      title: Text(LocaleKeys.user_birthdate.tr()),
                      subtitle: Text(custom_date_utils.DateUtils.isoToFormattedDate(user.birthDate.toString())),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.purple),
                      title: Text(LocaleKeys.user_location.tr()),
                      subtitle: Text(
                        user.address ?? 'Adresse non disponible',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.report, color: AppColors.purple),
                      title: Text(LocaleKeys.user_nbReports.tr()),
                      subtitle: Text(
                        user.reportNumber?.toString() ?? 'Nombre de signalements non disponible',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileButton(
                    text: 'Modifier le profil',
                    backgroundColor: AppColors.purple,
                    onPressed: () async {
                      final updatedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(user: user),
                        ),
                      );
                      if (updatedUser != null) {
                        setState(() {
                          user = updatedUser;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ProfileButton(
                    text: 'Se déconnecter',
                    backgroundColor: Colors.redAccent,
                    onPressed: () async {
                      await _authServices.logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}