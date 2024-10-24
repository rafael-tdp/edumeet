import 'package:client/screens/login_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/fake_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> user = FakeData.user;

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
                  user['image']!,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                user['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user['bio']!,
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
                        user['email']!,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: AppColors.purple),
                      title: const Text('Téléphone'),
                      subtitle: Text(user['phone']!),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on,
                          color: AppColors.purple),
                      title: const Text('Localisation'),
                      subtitle: Text(user['location']!),
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
                    onPressed: () {
                      // todo: Action to edit profile
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
