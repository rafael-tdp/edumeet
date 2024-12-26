class MessageEvent {
  final String id;
  final String? type;
  final String? username;
  final String? eventId;
  final DateTime? creationDate;
  final String? content;

  MessageEvent({
    required this.id,
    this.type,
    this.username,
    this.eventId,
    this.creationDate,
    this.content,
  });

  factory MessageEvent.fromJson(Map<String, dynamic> json) {
    return MessageEvent(
      id: json['messageId'],
      type: json['type'],
      username: json['username'],
      eventId: json['eventId'],
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
      'eventId': eventId,
      'creationDate': creationDate?.toIso8601String(),
      'content': content,
    };
  }
}
