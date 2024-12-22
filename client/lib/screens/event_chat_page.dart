import 'package:client/core/models/event.dart';
import 'package:flutter/material.dart';
import 'package:client/components/messages/message_input_field.dart';
import 'package:client/components/messages/chat_message.dart';
import 'package:go_router/go_router.dart';

class EventChatPage extends StatefulWidget {
  static const String routeName = '/event-chat/:eventId';
  static navigateTo(BuildContext context, Event event, String eventId) {
    // Navigator.pushNamed(context, routeName, arguments: event);
    final routeNameEventChat = routeName.replaceAll(':eventId', eventId);
    context.go(routeNameEventChat, extra: {'event': event, 'eventId': event.id});
  }
  final Event event;
  final String eventId;

  const EventChatPage({super.key, required this.event, required this.eventId});

  @override
  // ignore: library_private_types_in_public_api
  _EventChatPageState createState() => _EventChatPageState();
}

class _EventChatPageState extends State<EventChatPage> {
  final List<Map<String, String>> messages = [
    {
      'sender': 'Alice',
      'message': 'Bonjour tout le monde !',
    },
    {
      'sender': 'Bob',
      'message': 'Salut Alice !',
    },
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'sender': 'Moi',
          'message': _messageController.text,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.event.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  bool isMe = message['sender'] == 'Moi';
                  return ChatMessage(
                    sender: message['sender']!,
                    message: message['message']!,
                    isMe: isMe,
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
      ),
    );
  }
}
