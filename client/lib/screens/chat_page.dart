import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:client/components/messages/chat_message.dart';
import 'package:client/components/messages/message_input_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import '../core/enums/MessageAction.dart';
import '../core/enums/MessageType.dart';
import '../core/models/chat/chatManager.dart';
import '../core/models/chat/chatMessage.dart';
import '../core/models/chat/sendMessageRequest.dart';
import '../core/services/message_services.dart';
import '../core/services/sse_services.dart';
import '../providers/user_provider.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/private-chat';
  static navigateTo(BuildContext context, String userName, String friendId) {
    context.push('$routeName/$userName', extra: friendId);
  }

  final String userName;
  final String friendId;

  const ChatPage({super.key, required this.userName, required this.friendId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final MessageServices _messageServices = MessageServices();
  final SseServices _sseServices = SseServices();
  late final ChatManager _chatManager;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatManager = ChatManager(Future.value(Provider.of<UserProvider>(context, listen: false).currentUser?.username));
    _sseServices.connectToSse();
    _sseServices.messageStream.listen((messagePrivate) async {
      if (messagePrivate.type == MessageAction.DELETE.name) {
        setState(() {
          _chatManager.messages.removeWhere((message) => message.id == messagePrivate.id);
        });
      } else if (messagePrivate.type == MessageAction.CREATE.name) {
        await _chatManager.addMessagePrivate(messagePrivate);
        setState(() {});
        _scrollToBottom();
      }
    });
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final response = await _messageServices.getPrivateMessages(widget.friendId);
      final eventMessages = response.data;
      for (var message in eventMessages) {
        await _chatManager.addMessageRequest(message);
      }
      setState(() {});
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du chargement des messages.')),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    final sendMessageRequest = SendMessageRequest(
      eventId: widget.friendId,
      content: messageText,
    );

    try {
      await _messageServices.sendMessage(sendMessageRequest, MessageType.private);
      await _chatManager.addSendMessageRequest(sendMessageRequest);
      _messageController.clear();
      setState(() {});
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue lors de l\'envoi du message.')),
      );
    }
  }

  void _deleteMessage(String messageId) async {
    try {
      await _messageServices.deleteMessage(widget.friendId, messageId);
      setState(() {
        _chatManager.messages.removeWhere((message) => message.id == messageId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message supprimé avec succès.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue lors de la suppression du message.')),
      );
    }
  }

  @override
  void dispose() {
    _sseServices.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedMessages = <String, List<ChatMessageModel>>{};
    final messages = _chatManager.getAllMessages();
    final Avatar _avatar = DiceBearBuilder(
      seed: widget.userName,
      sprite: DiceBearSprite.bottts,
    ).build();

    for (var message in messages) {
      final date = custom_date_utils.DateUtils.DateTimeToShortDate(message.createdAt);
      groupedMessages.putIfAbsent(date, () => []).add(message);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _avatar.toImage(height: 25),
            const SizedBox(width: 8),
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: groupedMessages.length,
              itemBuilder: (context, index) {
                final date = groupedMessages.keys.elementAt(index);
                final messagesForDate = groupedMessages[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    ...messagesForDate.map((message) {
                      bool isCurrentUser = message.username == Provider.of<UserProvider>(context, listen: false).currentUser?.username || "Moi" == message.username;
                      final Avatar _avatar = DiceBearBuilder(
                        seed: message.username,
                        sprite: DiceBearSprite.bottts,
                      ).build();

                      return Wrap(
                        alignment: isCurrentUser ? WrapAlignment.end : WrapAlignment.start,
                        children: [
                          if (!isCurrentUser) _avatar.toImage(height: 25),
                          ChatMessage(
                            showName: false,
                            sender: widget.userName,
                            message: message.content,
                            isCurrentUser: message.isSentByCurrentUser,
                            createdAt: message.createdAt,
                            onDelete: () => _deleteMessage(message.id),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MessageInputField(
              controller: _messageController,
              onSendMessage: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
