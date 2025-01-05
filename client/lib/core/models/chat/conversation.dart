import 'package:client/core/enums/MessageType.dart';

class Conversation {
  final String id;
  final String name;
  final MessageType type;
  final String lastMessage;
  final String lastMessageUsername;
  final DateTime lastMessageDate;
  final String? pictureConversation;

  Conversation({
    required this.id,
    required this.name,
    required this.type,
    required this.lastMessage,
    required this.lastMessageUsername,
    required this.lastMessageDate,
    this.pictureConversation,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['conversationId'],
      name: json['conversationName'],
      type: MessageType.values.firstWhere((e) => e.name == json['type']),
      lastMessage: json['lastMessage'],
      lastMessageUsername: json['lastMessageUsername'],
      lastMessageDate: DateTime.parse(json['lastMessageDate'].replaceAll(" UTC", "")),
      pictureConversation: json['pictureConversation'],
    );
  }
}