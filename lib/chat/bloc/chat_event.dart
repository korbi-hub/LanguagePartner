part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final Map<String, dynamic> message;

  SendMessage(this.message);
}

class GetMessages extends ChatEvent {}
