import 'package:client/core/models/user.dart';

class Message {
  final String id;
  final String content;
  final User user;

  Message({
    required this.id,
    required this.content,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.toJson(),
    };
  }
}
