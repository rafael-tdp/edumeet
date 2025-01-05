import 'chatMessage.dart';

class MessageRequest {
  final String id;
  final String message;
  final String username;
  final String createdBy;
  final DateTime createdAt;

  MessageRequest({
    required this.id,
    required this.message,
    required this.username,
    required this.createdBy,
    required this.createdAt,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      id: json['id'],
      message: json['message'],
      username: json['username'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt'].replaceAll(" UTC", "")),
    );
  }
}

extension MessageRequestAdapter on MessageRequest {
  ChatMessageModel toChatMessageModel(String currentUsername) {
    return ChatMessageModel(
      id: this.id,
      content: this.message,
      username: this.username,
      createdAt: this.createdAt,
      isSentByCurrentUser: this.username == currentUsername,
    );
  }
}
