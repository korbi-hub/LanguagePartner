part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessagesReceived extends ChatState {

  final List<Message> messages;

  MessagesReceived(this.messages);

}

class MessageReceivingFailed extends ChatState {}
