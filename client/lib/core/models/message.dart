class Message {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? content;
  final String? eventMessages;
  final String? userMessages;

  Message({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.content,
    this.eventMessages,
    this.userMessages,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      content: json['content'],
      eventMessages: json['eventMessages'],
      userMessages: json['userMessages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'content': content,
      'eventMessages': eventMessages,
      'userMessages': userMessages,
    };
  }
}