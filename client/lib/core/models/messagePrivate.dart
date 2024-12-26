class MessagePrivate {
  final String id;
  final String? type;
  final String? username;
  final String? senderId;
  final String? receiverId;
  final DateTime? creationDate;
  final String? content;

  MessagePrivate({
    required this.id,
    this.type,
    this.username,
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
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': id,
      'type': type,
      'username': username,
      'senderId': senderId,
      'receiverId': receiverId,
      'creationDate': creationDate?.toIso8601String(),
      'content': content,
    };
  }
}
