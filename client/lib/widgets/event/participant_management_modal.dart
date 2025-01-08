import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:client/components/confirmation_dialog.dart';

class ParticipantManagementModal extends StatelessWidget {
  final List<dynamic> participantsList;
  final dynamic currentUser;
  final Function(String) acceptUser;
  final Function(String) rejectUser;
  final Function(String) removeUser;

  const ParticipantManagementModal({
    Key? key,
    required this.participantsList,
    required this.currentUser,
    required this.acceptUser,
    required this.rejectUser,
    required this.removeUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Gestion des utilisateurs",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: participantsList.map((participant) {
          String status = participant['status'];

          return ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: DiceBearBuilder(
                    seed: participant['user']['username'],
                    sprite: DiceBearSprite.values.firstWhere(
                      (sprite) =>
                          sprite.name == (participant['user']['picture']),
                      orElse: () => DiceBearSprite.bottts,
                    ),
                  ).build().toImage(width: 24, height: 24),
                ),
                const SizedBox(width: 8),
                Text(participant['user']['username'] == currentUser?.username
                    ? '(vous)'
                    : participant['user']['username']),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status == 'PENDING') ...[
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      final bool? confirmed = await ConfirmationDialog.show(
                        context,
                        title: "Accepter l'utilisateur",
                        message:
                            "Êtes-vous sûr de vouloir accepter cet utilisateur ?",
                        confirmText: "Accepter",
                        cancelText: "Annuler",
                        confirmColor: Colors.green,
                        cancelColor: Colors.red,
                        icon: Icons.check,
                      );

                      if (confirmed == true) {
                        acceptUser(participant['id']);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () async {
                      final bool? confirmed = await ConfirmationDialog.show(
                        context,
                        title: "Rejeter l'utilisateur",
                        message:
                            "Êtes-vous sûr de vouloir rejeter cet utilisateur ?",
                        confirmText: "Rejeter",
                        cancelText: "Annuler",
                        confirmColor: Colors.red,
                        cancelColor: Colors.green,
                        icon: Icons.cancel,
                      );

                      if (confirmed == true) {
                        rejectUser(participant['id']);
                      }
                    },
                  ),
                ],
                if (status == 'ACCEPTED' &&
                    participant['user']['id'] != currentUser?.id) ...[
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final bool? confirmed = await ConfirmationDialog.show(
                        context,
                        title: "Supprimer l'utilisateur",
                        message:
                            "Êtes-vous sûr de vouloir supprimer cet utilisateur ?",
                        confirmText: "Supprimer",
                        cancelText: "Annuler",
                        confirmColor: Colors.red,
                        icon: Icons.delete,
                      );

                      if (confirmed == true) {
                        removeUser(participant['id']);
                      }
                    },
                  ),
                ],
                if (status == 'REJECTED') ...[
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
  }
}
