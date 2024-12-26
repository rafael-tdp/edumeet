class MessageRequest {
  final String message;
  final String? eventId;
  final String? receiverId;

  MessageRequest({
    required this.message,
    this.eventId,
    this.receiverId,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      message: json['message'],
      eventId: json['eventId'],
      receiverId: json['receiverId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'eventId': eventId ?? '',
      'receiverId': receiverId ?? '',
    };
  }
}
