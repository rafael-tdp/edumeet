import 'package:flutter/material.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/date_utils.dart' as custom_date_utils;
import 'package:client/fake_data.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> conversations = FakeData.conversations;

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
                child: Text(
                  conversation['name']![0],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(conversation['name']!),
              subtitle: Text(conversation['lastMessage']!),
              trailing: Text(custom_date_utils.DateUtils.isoToFormattedTime(
                conversation['date']!,
              )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(conversation['name']!),
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

class ChatPage extends StatelessWidget {
  final String userName;

  const ChatPage(this.userName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat avec $userName'),
        backgroundColor: const Color(0xFF6cc5f3),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    message: "Salut, comment ça va ?",
                    isSent: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: "Ça va bien, et toi ?",
                    isSent: false,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tapez votre message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF6cc5f3)),
                  onPressed: () {
                    // Todo: Send message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSent;

  const ChatBubble({required this.message, required this.isSent, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSent ? const Color(0xFF6cc5f3) : const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSent ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ConversationsPage(),
  ));
}
