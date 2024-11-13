import 'package:flutter/material.dart';
import 'package:client/screens/profile_screen.dart';

class ParticipantsList extends StatelessWidget {
  final List<Map<String, String>> participants;

  const ParticipantsList({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Participants",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return GestureDetector(
                onTap: () {
                  final bool isCurrentUser =
                      participant['id'] == 'test'; // userId;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileWrapper(
                        user: participant,
                        isCurrentUser: isCurrentUser,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(participant['image']!),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        participant['name']!,
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
      ],
    );
  }
}

class UserProfileWrapper extends StatelessWidget {
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
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: ProfilePage(
        user: user,
        isCurrentUser: isCurrentUser,
      ),
    );
  }
}
