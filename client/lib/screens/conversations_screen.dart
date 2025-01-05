import 'package:client/core/models/chat/conversation.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/core/services/message_services.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:provider/provider.dart';
import '../core/models/response.dart';
import 'package:client/screens/chat_page.dart';
import 'package:client/screens/event_chat_page.dart';
import 'package:go_router/go_router.dart';

import '../i18n/generated/translations.g.dart';
import '../providers/user_provider.dart';


class ConversationsPage extends StatefulWidget {
  static const routeName = '/conversations';
  static navigateTo(BuildContext context) {
    context.go(routeName);
  }

  const ConversationsPage({Key? key}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final MessageServices _messageServices = MessageServices();
  Future<ResponseRequest>? _conversationsFuture;

  final TextEditingController _searchController = TextEditingController();
  List<Conversation> _filteredConversations = [];
  List<Conversation> _allConversations = [];

  @override
  void initState() {
    super.initState();
    _conversationsFuture = _messageServices.getConversations();
  }

  void _filterConversations(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredConversations = List.from(_allConversations);
      });
    } else {
      setState(() {
        _filteredConversations = _allConversations
            .where((conversation) =>
            conversation.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
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
    final _currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Conversations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Recherche de conversation...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              onChanged: _filterConversations,
            ),
          ),
          Expanded(
            child: FutureBuilder<ResponseRequest>(
              future: _conversationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final response = snapshot.data!;
                  if (!response.success || response.data == null) {
                    return const Center(
                        child: Text('Aucune conversation trouvée'));
                  }
                  _allConversations = response.data as List<Conversation>;
                  _filteredConversations =
                  _filteredConversations.isEmpty && _searchController.text.isEmpty
                      ? List.from(_allConversations)
                      : _filteredConversations;

                  if (_filteredConversations.isEmpty) {
                    return const Center(
                        child: Text('Aucune conversation trouvée'));
                  }

                  return ListView.builder(
                    itemCount: _filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = _filteredConversations[index];

                      return Column(
                        children: [
                          ListTile(
                            leading: conversation.type.name == 'private'
                                ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: DiceBearBuilder(
                                  seed: conversation.name,
                                  sprite: DiceBearSprite.values.firstWhere((sprite) => sprite.name == (conversation.pictureConversation),
                                    orElse: () => DiceBearSprite.bottts,
                                  ),
                                ).build().toImage(height: 50))
                                : CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: DiceBearBuilder(
                                  seed: conversation.name,
                                  sprite: DiceBearSprite.initials,
                                ).build().toImage(height: 50)),
                            title: Text(conversation.name),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${conversation.lastMessageUsername == _currentUser?.username ? t.user.you : conversation.lastMessageUsername}: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: conversation.lastMessage,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(custom_date_utils.DateUtils
                                .isoToFormattedTime(conversation.lastMessageDate
                                .toIso8601String())),
                            onTap: () =>
                                _navigateToConversation(context, conversation),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 80.0),
                            child: const Divider(
                                height: 1, color: Colors.black12),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Aucune conversation trouvée'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
