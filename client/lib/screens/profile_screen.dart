import 'package:client/screens/login_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/fake_data.dart';
import 'package:intl/intl.dart';

import '../core/services/auth_services.dart';
import 'edit_profil_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    AuthServices.getUserInfo().then((value) {
      setState(() {
        user = value;
        debugPrint(user.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> fakeUser = FakeData.user;

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
                  fakeUser['image']!,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  "${(user?['firstname']?.isNotEmpty ?? false) && (user?['lastname']?.isNotEmpty ?? false) ? '${user?['firstname']?.substring(0, 1).toUpperCase()}${user?['firstname']?.substring(1)} ${user?['lastname']?.substring(0, 1).toUpperCase()}${user?['lastname']?.substring(1)} !' : 'Anonyme'}",                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user?['bio'] != null && user!['bio'].isNotEmpty ? user!['bio'] : "Aucune description",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
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
                      title: const Text('Email'),
                      subtitle: Text(
                        user?['email'] ?? 'Email non disponible',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: AppColors.purple),
                      title: const Text('Date de naissance'),
                      subtitle: Text(
                        user?['birthDate'] != null
                            ? DateFormat('dd MMMM yyyy').format(DateTime.parse(user!['birthDate']))
                            : 'Date de naissance non disponible',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.purple),
                      title: const Text('Localisation'),
                      subtitle: Text(
                        user?['address'] ?? 'Adresse non disponible',
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
                          builder: (context) => EditProfilePage(user: user!),
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
                    onPressed: () {
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