import 'package:client/core/models/user.dart';
import 'package:client/core/services/participant_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ParticipantsList extends StatefulWidget {
  final List<dynamic> participants;
  final bool isCurrentUserEvent;

  const ParticipantsList({
    super.key,
    required this.participants,
    required this.isCurrentUserEvent,
  });

  @override
  _ParticipantsListState createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  late List<dynamic> participantsList;
  User? _currentUser;

  Future<void> _loadCurrentUser() async {
    if (!mounted) return;
    _currentUser =
        await Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    participantsList = List.from(widget.participants);
  }

  void _acceptUser(String participantId) {
    ParticipantServices.processParticipant(participantId, 'accepted');
    setState(() {
      final participant = participantsList
          .firstWhere((p) => p['id'] == participantId, orElse: () => null);
      if (participant != null) {
        participant['status'] = 'accepted';
      }
    });
  }

  void _rejectUser(String participantId) {
    ParticipantServices.processParticipant(participantId, 'rejected');
    setState(() {
      final participant = participantsList
          .firstWhere((p) => p['id'] == participantId, orElse: () => null);
      if (participant != null) {
        participant['status'] = 'rejected';
      }
    });
  }

  void _removeUser(String participantId) {
    ParticipantServices.processParticipant(participantId, 'rejected');
    setState(() {
      participantsList.removeWhere((p) => p['id'] == participantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final acceptedParticipants = widget.participants
        .where((participant) =>
            participant['status'] == 'ACCEPTED' ||
            participant['status'] == 'accepted')
        .toList();

    final pendingParticipantsCount = widget.participants
        .where((participant) =>
            participant['status'] == 'PENDING' ||
            participant['status'] == 'pending')
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.event.participants,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              if (widget.isCurrentUserEvent && pendingParticipantsCount > 0)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.group, size: 28),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Gestion des utilisateurs"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    participantsList.map((participant) {
                                  String status = participant['status'];
                                  return ListTile(
                                    title:
                                        Text(participant['user']['username']),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (status == 'pending') ...[
                                          IconButton(
                                            icon: const Icon(Icons.check),
                                            onPressed: () =>
                                                _acceptUser(participant['id']),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.cancel),
                                            onPressed: () =>
                                                _rejectUser(participant['id']),
                                          ),
                                        ],
                                        if (status == 'accepted') ...[
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () =>
                                                _removeUser(participant['id']),
                                          ),
                                        ],
                                        // rejected status
                                        if (status == 'rejected') ...[
                                          const Text(
                                            'Rejeté',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Fermer"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Positioned(
                      right: 4,
                      top: -4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          pendingParticipantsCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: acceptedParticipants.length,
            itemBuilder: (context, index) {
              final participant = acceptedParticipants[index];
              return GestureDetector(
                onTap: () {
                  final bool isCurrentUser =
                      participant['user']['id'] == _currentUser!.id;
                  // go router
                  context.go(UserProfileWrapper.routeName, extra: {
                    'user': participant,
                    'isCurrentUser': isCurrentUser,
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: participant['user']['picture'] != null
                            ? NetworkImage(participant['user']['picture']!)
                            : null,
                        backgroundColor: participant['user']['picture'] == null
                            ? Colors.grey
                            : Colors.transparent,
                        child: participant['user']['picture'] == null
                            ? Text(
                                participant['user']['firstname']![0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        participant['user']['firstname']! +
                            ' ' +
                            participant['user']['lastname']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.isCurrentUserEvent) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Gestion des utilisateurs"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: participantsList.map((participant) {
                              String status = participant['status'];
                              return ListTile(
                                title: Text(participant['user']['username']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (status == 'pending') ...[
                                      IconButton(
                                        icon: const Icon(Icons.check),
                                        onPressed: () =>
                                            _acceptUser(participant['id']),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () =>
                                            _rejectUser(participant['id']),
                                      ),
                                    ],
                                    if (status == 'accepted') ...[
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _removeUser(participant['id']),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Fermer"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Gérer les utilisateurs",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class UserProfileWrapper extends StatelessWidget {
  static const routeName = '/user-profile';
  static navigateTo(BuildContext context,
      {required Map<String, String> user, required bool isCurrentUser}) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: {
        'user': user,
        'isCurrentUser': isCurrentUser,
      },
    );
  }

  final Map<String, String> user;
  final bool isCurrentUser;

  const UserProfileWrapper({
    super.key,
    required this.user,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isCurrentUser
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: ProfilePage(
        isCurrentUser: isCurrentUser,
      ),
    );
  }
}
