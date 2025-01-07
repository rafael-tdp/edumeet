import 'package:client/core/models/response.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/profile_button.dart';
import '../components/avatar_selector.dart';
import '../core/models/user.dart';
import '../providers/user_provider.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = '/edit-profile';
  static navigateTo(BuildContext context,
      {required Map<String, dynamic> user}) {
    context.go(routeName, extra: user);
  }

  const EditProfilePage({super.key, required this.user});
  final User user;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  late TextEditingController _addressController;
  String? _selectedAvatar;
  late String _currentUsername;
  late Avatar _avatar;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.user.firstname);
    _lastnameController = TextEditingController(text: widget.user.lastname);
    _usernameController = TextEditingController(text: widget.user.username);
    _bioController = TextEditingController(text: widget.user.bio);
    _emailController = TextEditingController(text: widget.user.email);
    _birthDateController = TextEditingController(
        text: custom_date_utils.DateUtils.isoToFormattedDate(
            widget.user.birthDate.toString()));
    _addressController = TextEditingController(text: widget.user.address);
    _selectedAvatar = widget.user.picture; // Initialize with the current avatar
    _currentUsername = widget.user.username;
    _avatar = DiceBearBuilder(
      seed: widget.user.username,
      sprite: DiceBearSprite.values.firstWhere(
        (sprite) => sprite.name == widget.user.picture,
      ),
    ).build();

    _usernameController.addListener(() {
      setState(() {
        if (_currentUsername == _usernameController.text) return;
        _currentUsername = _usernameController.text;
        _avatar = DiceBearBuilder(
          seed: _currentUsername,
          sprite: DiceBearSprite.values.firstWhere(
            (sprite) => sprite.name == _selectedAvatar,
          ),
        ).build();
      });
    });
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() == true) {
      final User updatedUser = User(
        id: widget.user.id,
        email: _emailController.text,
        username: _usernameController.text,
        lastname: _lastnameController.text,
        firstname: _firstnameController.text,
        birthDate: custom_date_utils.DateUtils.stringToFomattedDateTime(
            _birthDateController.text),
        bio: _bioController.text,
        picture: _selectedAvatar,
        address: _addressController.text,
      );
      ResponseRequest response =
          await UserServices().updateUserInfo(updatedUser);
      if (response.success) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.data);
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          t.profile.editProfile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _avatar.toImage(height: 100),
                const SizedBox(height: 20),
                AvatarSelector(
                  username: _currentUsername,
                  onAvatarSelected: (String avatar) {
                    setState(() {
                      _selectedAvatar = avatar;
                      _avatar = DiceBearBuilder(
                        seed: _currentUsername,
                        sprite: DiceBearSprite.values.firstWhere(
                          (sprite) => sprite.name == avatar,
                        ),
                      ).build();
                    });
                  },
                ),
                const SizedBox(height: 30),
                _buildTextFormField(
                  controller: _firstnameController,
                  label: t.profile.firstname,
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.profile.enterFirstname;
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  controller: _lastnameController,
                  label: t.profile.lastname,
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.profile.enterLastname;
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  controller: _usernameController,
                  label: t.user.username,
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.form.emptyUsername;
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  controller: _bioController,
                  label: t.profile.bio,
                  icon: Icons.info,
                ),
                _buildTextFormField(
                  controller: _emailController,
                  label: t.profile.email,
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.profile.enterEmail;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return t.profile.invalidEmail;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    labelText: t.profile.birthdate,
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: AppColors.purple,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.purple,
                    ),
                  ),
                  readOnly: true,
                  onTap: () => custom_date_utils.DateUtils.selectDate(
                      context, _birthDateController),
                ),
                const SizedBox(height: 25),
                _buildTextFormField(
                  controller: _addressController,
                  label: t.profile.address,
                  icon: Icons.location_on,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileButton(
                      text: t.profile.save,
                      backgroundColor: AppColors.purple,
                      onPressed: () async {
                        await _saveProfile();
                      },
                    ),
                    const SizedBox(width: 10),
                    ProfileButton(
                      text: t.profile.cancel,
                      backgroundColor: Colors.redAccent,
                      onPressed: () {
                        ProfilePage.navigateTo(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: AppColors.purple,
              width: 2.0,
            ),
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.purple,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          // suffixIcon: controller.text.isNotEmpty
          //     ? IconButton(
          //         icon: const Icon(Icons.clear, color: Colors.grey),
          //         onPressed: () {
          //           controller.clear();
          //         },
          //       )
          //     : null,
        ),
        validator: validator,
      ),
    );
  }
}
