import 'chatMessage.dart';
import 'package:client/utils/date_utils.dart' as customDate;

class SendMessageRequest {
  final String username = 'Moi';
  final String eventId;
  final DateTime createdAt = customDate.DateUtils.now();
  final String content;

  SendMessageRequest({
    required this.eventId,
    required this.content,
  });

}

extension SendMessageRequestAdapter on SendMessageRequest {
  ChatMessageModel toChatMessageModel() {
    return ChatMessageModel(
      id: '',
      content: this.content,
      username: this.username,
      createdAt: this.createdAt,
      isSentByCurrentUser: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': this.eventId,
      'content': this.content,
      'createdAt': this.createdAt,
    };
  }
}
