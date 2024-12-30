import 'chatMessage.dart';

class MessagePrivate {
  final String id;
  final String? type;
  final String? username;
  final String? messageId;
  final String? senderId;
  final String? receiverId;
  final DateTime? creationDate;
  final String? content;

  MessagePrivate({
    required this.id,
    this.type,
    this.username,
    this.messageId,
    this.senderId,
    this.receiverId,
    this.creationDate,
    this.content,
  });

  factory MessagePrivate.fromJson(Map<String, dynamic> json) {
    return MessagePrivate(
      id: json['messageId'],
      type: json['type'],
      username: json['username'],
      messageId: json['messageId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      content: json['content'],
    );
  }
}

extension MessageEventAdapter on MessagePrivate {
  ChatMessageModel toChatMessageModel(String currentUsername) {
    return ChatMessageModel(
      id: this.id,
      content: this.content ?? '',
      username: this.username ?? 'Unknown',
      createdAt: this.creationDate ?? DateTime.now(),
      isSentByCurrentUser: this.username == currentUsername,
    );
  }
}
