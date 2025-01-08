import 'package:client/core/models/user.dart';
import 'package:client/core/services/participant_services.dart';
import 'package:client/i18n/generated/translations.g.dart';
import 'package:client/providers/user_provider.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:client/components/event/participant_management_modal.dart';

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
  bool _isLoading = true;

  Future<void> _loadCurrentUser() async {
    try {
      final user =
          await Provider.of<UserProvider>(context, listen: false).getUser();
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    participantsList = List.from(widget.participants);
    _loadCurrentUser();
  }

  void _acceptUser(String participantId) {
    try {
      ParticipantServices.processParticipant(participantId, 'ACCEPTED');
      setState(() {
        final participant = participantsList
            .firstWhere((p) => p['id'] == participantId, orElse: () => null);
        if (participant != null) {
          participant['status'] = 'ACCEPTED';
        }
      });
      _showMessage("Utilisateur accepté avec succès.");
      Navigator.of(context).pop();
    } catch (e) {
      _showMessage("Erreur lors de l'acceptation de l'utilisateur.");
    }
  }

  void _rejectUser(String participantId) {
    try {
      ParticipantServices.processParticipant(participantId, 'REJECTED');
      setState(() {
        final participant = participantsList
            .firstWhere((p) => p['id'] == participantId, orElse: () => null);
        if (participant != null) {
          participant['status'] = 'REJECTED';
        }
      });
      _showMessage("Utilisateur refusé.");
      Navigator.of(context).pop();
    } catch (e) {
      _showMessage("Erreur lors du rejet de l'utilisateur.");
    }
  }

  void _removeUser(String participantId) {
    try {
      ParticipantServices.processParticipant(participantId, 'REJECTED');
      setState(() {
        participantsList =
            participantsList.where((p) => p['id'] != participantId).toList();
      });
      _showMessage("Utilisateur supprimé.");
      Navigator.of(context).pop();
    } catch (e) {
      _showMessage("Erreur lors de la suppression de l'utilisateur.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final filteredParticipants = participantsList
          .where((participant) =>
              participant['status'] == 'ACCEPTED' ||
              participant['status'] == 'PENDING')
          .toList();

      final pendingParticipantsCount = participantsList
          .where((participant) => participant['status'] == 'PENDING')
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
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ParticipantManagementModal(
                              participantsList: participantsList,
                              currentUser: _currentUser,
                              acceptUser: _acceptUser,
                              rejectUser: _rejectUser,
                              removeUser: _removeUser,
                            );
                          },
                        ),
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
              itemCount: filteredParticipants.length,
              itemBuilder: (context, index) {
                final participant = filteredParticipants[index];
                return GestureDetector(
                  key: ValueKey(participant['id']),
                  onTap: () {
                    ProfilePage.navigateTo(context, participant['user']['id']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: DiceBearBuilder(
                              seed: participant['user']['username'],
                              sprite: DiceBearSprite.values.firstWhere(
                                (sprite) =>
                                    sprite.name ==
                                    (participant['user']['picture']),
                                orElse: () => DiceBearSprite.bottts,
                              ),
                            ).build().toImage(width: 50, height: 50)),
                        const SizedBox(height: 8),
                        Text(
                          participant['user']['username']! ==
                                  _currentUser?.username
                              ? t.user.you
                              : participant['user']['username'],
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
                          return ParticipantManagementModal(
                            participantsList: participantsList,
                            currentUser: _currentUser,
                            acceptUser: _acceptUser,
                            rejectUser: _rejectUser,
                            removeUser: _removeUser,
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Gérer les utilisateurs",
                      style: TextStyle(
                        fontSize: 15,
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
}
