part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String b;
  final Map<String, dynamic> message;

  SendMessage(this.message, this.b);
}

class GetMessages extends ChatEvent {
  final String msg;
  final String b;

  GetMessages(this.msg, this.b);
}

class GetExplanation extends ChatEvent {
  final String m;
  final String b;

  GetExplanation(this.m, this.b);
}

class GetTranslation extends ChatEvent {
  final String m;
  final String b;

  GetTranslation(this.m, this.b);
}
