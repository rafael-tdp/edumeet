class Document {
  final String id;
  final String name;
  final String? path;
  final String? type;
  final String? eventId;
  final String? messageId;
  final String? content;

  Document({
    required this.id,
    required this.name,
    this.path,
    this.type,
    this.eventId,
    this.messageId,
    this.content,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      path: json['path'],
      eventId: json['eventId'],
      messageId: json['messageId'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'path': path,
      'eventId': eventId,
      'messageId': messageId,
      'content': content,
    };
  }
}
