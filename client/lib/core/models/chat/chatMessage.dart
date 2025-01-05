class ChatMessageModel {
  final String id;
  final String content;
  final String username;
  final String? picture;
  final DateTime createdAt;
  final bool isSentByCurrentUser;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.username,
    this.picture,
    required this.createdAt,
    required this.isSentByCurrentUser,
  });
}
