class ChatMessageModel {
  final String id;
  final String content;
  final String username;
  final DateTime createdAt;
  final bool isSentByCurrentUser;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.username,
    required this.createdAt,
    required this.isSentByCurrentUser,
  });
}
