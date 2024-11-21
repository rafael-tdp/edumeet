import 'package:client/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;

import '../components/profile_button.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = '/edit-profile';
  static navigateTo(BuildContext context, {required Map<String, dynamic> user}) {
    Navigator.pushNamed(context, routeName, arguments: user);
  }

  const EditProfilePage({super.key, required this.user});
  final Map<String, dynamic> user;

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstnameController =
        TextEditingController(text: widget.user['firstname'] ?? '');
    _lastnameController =
        TextEditingController(text: widget.user['lastname'] ?? '');
    _bioController = TextEditingController(text: widget.user['bio'] ?? '');
    _emailController = TextEditingController(text: widget.user['email'] ?? '');
    _birthDateController =
        TextEditingController(text: widget.user['birthDate'] ?? '');
    _addressController =
        TextEditingController(text: widget.user['address'] ?? '');
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() == true) {
      // final updatedUser = {
      //   'firstname': _firstnameController.text,
      //   'lastname': _lastnameController.text,
      //   'bio': _bioController.text,
      //   'email': _emailController.text,
      //   'birthDate': _birthDateController.text,
      //   'address': _addressController.text,
      // };
      // await AuthServices.updateUserInfo(updatedUser);
      // Navigator.pop(context, updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Modifier mon profil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.user['image'] ?? ''),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.info),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer une adresse e-mail valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => custom_date_utils.DateUtils.selectDate(context, _birthDateController),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileButton(
                    text: 'Enregistrer',
                    backgroundColor: AppColors.purple,
                    onPressed: () async {
                      await _saveProfile();
                    },
                  ),
                  const SizedBox(width: 10),
                  ProfileButton(
                    text: 'Annuler',
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
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
