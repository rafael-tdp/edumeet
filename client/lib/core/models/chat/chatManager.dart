import '../../services/cache_service.dart';
import 'messageEvent.dart';
import 'messagePrivate.dart';
import 'messageRequest.dart';
import 'sendMessageRequest.dart';
import 'chatMessage.dart';

class ChatManager {
  final Future<String?> currentUsername;
  final List<ChatMessageModel> messages = [];

  ChatManager(this.currentUsername);

  Future<void> addMessageRequest(MessageRequest messageRequest) async {
    final username = await currentUsername;
    messages.add(messageRequest.toChatMessageModel(username ?? ''));
  }

  Future<void> addSendMessageRequest(SendMessageRequest sendMessageRequest) async {
    messages.add(sendMessageRequest.toChatMessageModel());
  }

  Future<void> addMessageEvent(MessageEvent messageEvent) async {
    final username = await currentUsername;
    messages.add(messageEvent.toChatMessageModel(username ?? ''));
  }

  Future<void> addMessagePrivate(MessagePrivate messagePrivate) async {
    final username = await currentUsername;
    messages.add(messagePrivate.toChatMessageModel(username ?? ''));
  }

  List<ChatMessageModel> getAllMessages() {
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return messages;
  }
}