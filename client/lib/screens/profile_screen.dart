import 'package:client/core/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:client/widgets/language_dropdown.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/utils/colors.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/core/services/auth_services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/i18n/generated/translations.g.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  final String? userId;

  static navigateTo(BuildContext context, String userId) {
    context.push('$routeName/$userId');
  }

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  bool _isCurrentUser = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final currentUser =
          await Provider.of<UserProvider>(context, listen: false).getUser();

      setState(() {
        _isCurrentUser = (currentUser?.id == widget.userId);
      });

      if (widget.userId != null) {
        final response = await UserServices().getUserById(widget.userId);
        print("response: $response");
        if (response.success && response.data is User) {
          setState(() {
            _user = response.data as User;
          });
        } else {
          setState(() {
            _errorMessage = response.message ?? 'Failed to fetch user';
          });
        }
      } else {
        setState(() {
          _user = currentUser;
          _isCurrentUser = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text('Erreur : $_errorMessage'),
        ),
      );
    }

    if (_user == null) {
      return const Scaffold(
        body: Center(child: Text('Utilisateur non trouvé.')),
      );
    }

    final Avatar avatar = DiceBearBuilder(
      seed: _user!.username,
      sprite: DiceBearSprite.bottts,
    ).build();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Profile'),
        leading: _isCurrentUser
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              avatar.toImage(height: 100),
              const SizedBox(height: 20),
              Text(
                _user?.username ?? t.user.anonymous,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _user!.bio != null && _user!.bio!.isNotEmpty
                    ? _user!.bio!
                    : t.user.noDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              LanguageDropdown(parentContext: context),
              const SizedBox(height: 20),
              _buildUserInfoCard(),
              const SizedBox(height: 20),
              if (_isCurrentUser) _buildProfileActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
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
            title: Text(t.user.email),
            subtitle:
                Text(_user != null ? _user!.email! : "Aucun email renseigné"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: AppColors.purple),
            title: Text(t.user.username),
            subtitle: Text(_user!.username),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone, color: AppColors.purple),
            title: Text(t.user.birthdate),
            subtitle: Text(
              _user != null && _user?.birthDate != null
                  ? custom_date_utils.DateUtils.isoToFormattedDate(
                      _user!.birthDate.toString(),
                    )
                  : "Aucune date de naissance renseignée",
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on, color: AppColors.purple),
            title: Text(t.user.location),
            subtitle: Text(_user!.address ?? t.user.noAddress),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileActions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        ProfileButton(
          text: t.profile.editProfile,
          backgroundColor: AppColors.purple,
          onPressed: () async {
            final updatedUser = await context.push(
              '${ProfilePage.routeName}${EditProfilePage.routeName}',
              extra: _user,
            ) as dynamic;
            if (updatedUser != null) {
              setState(() {
                _user = updatedUser;
              });
            }
          },
        ),
        ProfileButton(
          text: t.profile.logout,
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            await AuthServices().logout();
            Provider.of<UserProvider>(context, listen: false).clearUser();
            context.go(LoginPage.routeName);
          },
        ),
      ],
    );
  }
}
