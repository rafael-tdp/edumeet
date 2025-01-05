import '../enums/MessageType.dart';
import 'chat/sendMessageRequest.dart';

class MessageOffline {
  final SendMessageRequest message;
  final MessageType type;

  MessageOffline({required this.message, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'message': message.toJson(),
      'type': type.toString(),
    };
  }

  factory MessageOffline.fromJson(Map<String, dynamic> json) {
    return MessageOffline(
      message: SendMessageRequest.fromJson(json['message']),
      type: MessageType.values.firstWhere((e) => e.toString() == json['type']),
    );
  }
}