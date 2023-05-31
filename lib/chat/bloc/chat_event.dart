part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String botId;
  final String userId;
  final Map<String, dynamic> message;

  SendMessage(this.message, this.botId, this.userId);
}

class GetMessages extends ChatEvent {
  final String botId;
  final String userId;

  GetMessages(this.botId, this.userId);
}

class GetExplanation extends ChatEvent {
  final String botId;
  final String userId;
  final String message;

  GetExplanation(this.message, this.botId, this.userId);
}

class GetTranslation extends ChatEvent {
  final String botId;
  final String userId;
  final String message;

  GetTranslation(this.message, this.botId, this.userId);
}
