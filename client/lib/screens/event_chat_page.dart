import 'package:dice_bear/dice_bear.dart'; 
import 'package:client/core/models/event.dart';
import 'package:flutter/material.dart';
import 'package:client/core/enums/MessageAction.dart';
import 'package:client/core/models/chat/chatManager.dart';
import 'package:client/core/services/message_services.dart';
import 'package:client/core/services/sse_services.dart';
import 'package:client/components/messages/message_input_field.dart';
import 'package:client/components/messages/chat_message.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/models/chat/chatMessage.dart';
import '../core/services/event_services.dart';
import '../providers/user_provider.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import '../core/enums/MessageType.dart';
import '../core/models/chat/sendMessageRequest.dart';

class EventChatPage extends StatefulWidget {
  static const String routeName = '/event-chat';
  static navigateTo(BuildContext context, String eventId) {
    context.go('$routeName/$eventId');
  }

  final String eventId;

  const EventChatPage({super.key, required this.eventId});

  @override
  _EventChatPageState createState() => _EventChatPageState();
}

class _EventChatPageState extends State<EventChatPage> {
  final MessageServices _messageServices = MessageServices();
  final SseServices _sseServices = SseServices();
  late final ChatManager _chatManager;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Event? _event;

  @override
  void initState() {
    super.initState();
    _chatManager = ChatManager(Future.value(Provider.of<UserProvider>(context, listen: false).currentUser?.username));
    _sseServices.connectToSse();
    _sseServices.messageStream.listen((messageEvent) async {
      if (messageEvent.type == MessageAction.DELETE.name) {
        setState(() {
          _chatManager.messages.removeWhere((message) => message.id == messageEvent.id);
        });
      } else if (messageEvent.type == MessageAction.CREATE.name) {
        await _chatManager.addMessageEvent(messageEvent);
        setState(() {});
        _scrollToBottom();
      }
    });
    _loadEvent();
  }

Future<void> _loadEvent() async {
  try {
    final event = await EventServices.getEventDetails(widget.eventId);
    setState(() {
      _event = event;
    });
    _loadMessages();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erreur lors du chargement de l\'événement.')),
    );
  }
}

  Future<void> _loadMessages() async {
    try {
      final response = await _messageServices.getEventMessages(widget.eventId);
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
      eventId: widget.eventId,
      content: messageText,
    );

    try {
      await _messageServices.sendMessage(sendMessageRequest, MessageType.event);
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
      await _messageServices.deleteMessage(widget.eventId, messageId);
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
    if (_event == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chargement...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final groupedMessages = <String, List<ChatMessageModel>>{};
    final messages = _chatManager.getAllMessages();
    final Avatar _avatar = DiceBearBuilder(
      seed: _event!.title,
      sprite: DiceBearSprite.initials,
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
              _event!.title, 
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: groupedMessages.keys.length,
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

                        return Row(
                          mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isCurrentUser) _avatar.toImage(height: 25),
                            Expanded(
                              child: ChatMessage(
                                sender: message.username,
                                message: message.content,
                                isCurrentUser: isCurrentUser,
                                createdAt: message.createdAt,
                                onDelete: () => _deleteMessage(message.id),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MessageInputField(
                controller: _messageController,
                onSendMessage: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}