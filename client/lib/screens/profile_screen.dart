import 'package:client/core/models/reporting.dart';
import 'package:client/core/models/response.dart';
import 'package:client/core/models/user.dart';
import 'package:client/core/services/badges_service.dart';
import 'package:client/core/services/reporting_services.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/user_services.dart';
import 'package:client/utils/colors.dart';
import 'package:client/components/profile_button.dart';
import 'package:client/screens/edit_profile_page.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/i18n/generated/translations.g.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/services/friends_service.dart';
import '../providers/user_provider.dart';
import 'package:client/core/models/badge.dart' as custom_badge;

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  final String? userId;

  static navigateTo(BuildContext context, [String? userId]) {
    context.push('$routeName/${userId ?? ''}');
  }

  const ProfilePage({
    super.key,
    this.userId,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserServices _userServices = UserServices();
  final FriendsServices _friendsServices = FriendsServices();
  bool _isCurrentUser = false;
  bool _isLoading = true;
  User? _user;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      if(widget.userId == null) {
        ResponseRequest response = await _userServices.getUserInfo();
        if (response.success) {
          setState(() {
            _isCurrentUser = true;
            _user = response.data as User;
          });
        } else {
          setState(() {
            _errorMessage = response.message ?? t.error.general;
          });
        }
      } else {
        ResponseRequest response = await _userServices.getUserById(widget.userId);
        if (response.success) {
          setState(() {
            _isCurrentUser = Provider.of<UserProvider>(context, listen: false).currentUser?.id == widget.userId;
            _user = response.data as User;
          });
        } else {
          setState(() {
            _errorMessage = response.message ?? t.error.general;
          });
        }
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(t.error.details(error: _errorMessage!)),
        ),
      );
    }

    if (_user == null) {
      return Scaffold(
        body: Center(
          child: Text(t.error.no_results),
        ),
      );
    }

    final Avatar avatar = DiceBearBuilder(
      seed: _user!.username,
      sprite: DiceBearSprite.values.firstWhere(
            (sprite) => sprite.name == _user!.picture,
      ),
    ).build();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(t.page.profile),
        leading: _isCurrentUser
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(true);
          },
        ),
        actions: _isCurrentUser
            ? null
            : [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () async {
              final response = await _friendsServices.sendFriendRequest(widget.userId!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.success ? 'Friend request sent' : 'Failed to send friend request'),
                  backgroundColor: response.success ? Colors.green : Colors.red,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.report_problem, color: Colors.orange),
            onPressed: () {
              _showReportDialog(context);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'avatar_${_user!.id}',
                child: avatar.toImage(height: 100),
              ),
              const SizedBox(height: 5),
              _buildUserBadges(),
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
              _buildUserStats(),
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
            Text(_user != null ? _user!.email! : t.app.unknown),
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
                  : t.app.unknown,
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
            final needsToRefresh = await context.push(
              '${ProfilePage.routeName}${EditProfilePage.routeName}',
              extra: _user,
            );
            if (needsToRefresh == true) {
              _loadUser();
            }
          },
        ),
      ],
    );
  }

  Widget _buildUserStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 125,
          height: 80,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _user!.nbFriends.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Amis'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 125,
          height: 80,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _user!.nbParticpatedEvents.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Evenements'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Signaler ${_user!.username} ?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Motif du signalement",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller,
                maxLines: 4, // Permet d'avoir plusieurs lignes de texte
                decoration: InputDecoration(
                  hintText: "Raison du signalement",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.app.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Signaler"),
              onPressed: () {
                String reason = _controller.text;
                _reportUser(reason, widget.userId!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _reportUser(String reason, String userId) {
    Reporting createReporting = Reporting(
      reason: reason,
      type: "USER",
      entityId: userId,
    );

    ReportingServices.createReporting(createReporting).then((response) {
      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message!),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Widget _buildUserBadges() {
    Future<List<custom_badge.Badge>> allBadgesFuture = BadgeServices.getBadges();
    List<custom_badge.Badge> unlockedBadges = _user!.badges ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<custom_badge.Badge>>(
          future: allBadgesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Icon(Icons.error);
            }

            if (snapshot.hasData) {
              List<custom_badge.Badge> allBadges = snapshot.data!;

              return Wrap(
                spacing: 10,
                children: allBadges.map((badge) {
                  bool isUnlocked = unlockedBadges.any((unlockedBadge) => unlockedBadge.id == badge.id);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.string(
                          badge.svg,
                          width: 35,
                          height: 35,
                          colorFilter: isUnlocked
                              ? null
                              : ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.srcIn),
                        ),
                        if (!isUnlocked)
                          Positioned(
                            child: Icon(
                              Icons.lock,
                              color: Colors.red.withOpacity(0.8),
                              size: 25,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }

            return const Icon(Icons.error);
          },
        ),
      ],
    );
  }
}