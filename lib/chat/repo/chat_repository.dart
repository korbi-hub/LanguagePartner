import 'package:language_partner/chat/model/message.dart';

abstract class ChatRepository {
  Future<List<Message>?> getMessages(String userId, String botId);

  Future<List<Message>?> sendMessages(Map<String, dynamic> message, String userId, String botId);

  Future<List<Message>?> getExplanation(String message, String userId, String botId);

  Future<List<Message>?> getTranslation(String message, String userId, String botId);

}