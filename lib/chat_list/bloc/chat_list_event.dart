part of 'chat_list_bloc.dart';

@immutable
abstract class ChatEvent {}

class RequestOptions extends ChatEvent {}

class HideOptions extends ChatEvent {}