import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/fake_data.dart';
import 'package:client/screens/chat_page.dart';
import 'package:go_router/go_router.dart';

class ConversationsPage extends StatelessWidget {
  static const String routeName = '/conversations';
  static navigateTo(BuildContext context) {
    context.go(routeName);
  }
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> conversations = FakeData.conversations;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final conversation = conversations[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.purple,
                backgroundImage: conversation['user'].containsKey('image')
                    ? NetworkImage(conversation['user']['image']!)
                    : null,
                child: conversation['user'].containsKey('image')
                    ? null
                    : Text(
                        conversation['user']['name']![0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
              title: Text(conversation['user']['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  )),
              subtitle: Text(conversation['lastMessage']!),
              trailing: Text(custom_date_utils.DateUtils.isoToFormattedTime(
                conversation['date']!,
              )),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 150),
                    reverseTransitionDuration: const Duration(milliseconds: 150),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      // context.go(EventDetailsPage.routeName, extra: {eventId, _currentUser});
                      ChatPage.navigateTo(context, conversation['user']['name']!);
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child:
                            ChatPage(userName: conversation['user']['name']!),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
