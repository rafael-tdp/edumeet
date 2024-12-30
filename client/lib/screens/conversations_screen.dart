import 'package:client/core/models/chat/conversation.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/message_services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import '../core/models/event.dart';
import '../core/models/response.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/screens/event_chat_page.dart';

class ConversationsPage extends StatefulWidget {
  static const routeName = '/conversations';
  static navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const ConversationsPage({Key? key}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final MessageServices _messageServices = MessageServices();
  Future<ResponseRequest>? _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _conversationsFuture = _messageServices.getConversations();
  }

  void _navigateToConversation(BuildContext context, Conversation conversation) {
    if (conversation.type.name == 'private') {
      ChatPage.navigateTo(context, conversation.name, conversation.id);
    } else if (conversation.type.name == 'event') {
      EventChatPage.navigateTo(context, conversation.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: FutureBuilder<ResponseRequest>(
        future: _conversationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final response = snapshot.data!;
            if (!response.success || response.data == null) {
              return Center(child: Text('Aucune conversation trouvée'));
            }
            final conversations = response.data as List<Conversation>;
            if (conversations.isEmpty) {
              return Center(child: Text('Aucune conversation trouvée'));
            }
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                final Avatar _avatar = conversation.type.name == 'private'
                    ? DiceBearBuilder(seed: conversation.name, sprite: DiceBearSprite.bottts).build()
                    : DiceBearBuilder(seed: conversation.name, sprite: DiceBearSprite.initials).build();
                return Column(
                  children: [
                    ListTile(
                      leading: _avatar.toImage(height: 50),
                      title: Text(conversation.name),
                      subtitle: Text('${conversation.lastMessageUsername}: ${conversation.lastMessage}'),
                      trailing: Text(custom_date_utils.DateUtils.isoToFormattedTime(conversation.lastMessageDate.toIso8601String())),
                      onTap: () => _navigateToConversation(context, conversation),
                    ),
                    const Divider(height: 1, color: Colors.black12),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('Aucune conversation trouvée'));
          }
        },
      ),
    );
  }
}