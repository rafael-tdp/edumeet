import 'package:client/core/services/friends_service.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:client/core/models/friendship/friendRequest.dart';
import 'package:client/core/enums/FriendStatus.dart';
import 'package:go_router/go_router.dart';

import '../core/services/user_services.dart';
import '../i18n/generated/translations.g.dart';

class FriendsListPage extends StatefulWidget {
  static const routeName = '/friends';
  static navigateTo(BuildContext context) {
    context.go(routeName);
  }

  const FriendsListPage({super.key});

  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  FriendsServices _friendsServices = FriendsServices();
  List<FriendRequest> _friends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final response = await UserServices().getUserFriends();
    if (response.success) {
      setState(() {
        _friends = response.data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.error.general),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _acceptFriendRequest(String friendId) async {
    final response = await _friendsServices.acceptFriendRequest(friendId);
    if (response.success) {
      _loadFriends();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.error.general),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _declineFriendRequest(String friendId) async {
    final response = await _friendsServices.declineFriendRequest(friendId);
    if (response.success) {
      _loadFriends();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.error.general),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteFriendRequest(String friendId) async {
    final response = await _friendsServices.declineFriendRequest(friendId);
    if (response.success) {
      _loadFriends();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.error.general),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final acceptedFriends =
    _friends.where((friend) => friend.status == FriendStatus.accepted).toList();
    final pendingFriends =
    _friends.where((friend) => friend.status == FriendStatus.pending).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste d'amis"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _friends.isEmpty
          ? const Center(child: Text("Aucun ami trouvé."))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (acceptedFriends.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Amis",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: acceptedFriends.length,
                itemBuilder: (context, index) {
                  final friend = acceptedFriends[index];

                  return ListTile(
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: DiceBearBuilder(
                          seed: friend.friendUsername,
                          sprite: DiceBearSprite.values.firstWhere(
                                (sprite) => sprite.name == (friend.friendPicture),
                            orElse: () => DiceBearSprite.bottts,
                          ),
                        ).build().toImage(height: 50)),
                    title: Text(friend.friendUsername),
                    onTap: () {
                      ProfilePage.navigateTo(context, friend.friendId);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chat),
                          onPressed: () {
                            ChatPage.navigateTo(context, friend.friendUsername, friend.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteFriendRequest(friend.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
            if (pendingFriends.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Demandes en attente",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pendingFriends.length,
                itemBuilder: (context, index) {
                  final friend = pendingFriends[index];
                  return ListTile(
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: DiceBearBuilder(
                          seed: friend.friendUsername,
                          sprite: DiceBearSprite.values.firstWhere(
                                (sprite) => sprite.name == (friend.friendPicture),
                            orElse: () => DiceBearSprite.bottts,
                          ),
                        ).build().toImage(height: 50)),
                    title: Text(friend.friendUsername),
                    onTap: () {
                      ProfilePage.navigateTo(context, friend.friendId);
                    },
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            ElevatedButton(
                              onPressed: () {
                                _acceptFriendRequest(friend.id);
                              },
                              child: const Text("Accepter"),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                _declineFriendRequest(friend.id);
                              },
                              child: const Text("Refuser"),
                            ),
                        ],
                      )
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
