import 'package:client/screens/conversations_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/components/messages/chat_message.dart';
import 'package:client/components/messages/message_input_field.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = 'details';
  static navigateTo(BuildContext context, String userName) {
    context.push(
      '${ConversationsPage.routeName}/$userName/$routeName',
      extra: userName,
    );
  }

  final String userName;

  const ChatPage({super.key, required this.userName});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'message': "Salut, comment ça va ?", 'isSent': true},
    {'message': "Ça va bien, et toi ?", 'isSent': false},
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'message': _messageController.text,
          'isSent': true,
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
        title: Text(widget.userName),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessage(
                  showName: false,
                  sender: widget.userName,
                  message: message['message'],
                  isMe: message['isSent'],
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
