import 'package:bloc/bloc.dart';
import 'package:language_partner/chat/message.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      List<Message>? messages = await Messages.sendMessage(event.message, event.b);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });

    on<GetMessages>((event, emit) async {
      List<Message> messages = await Messages.getMessages(event.msg, event.b);
      emit(MessagesReceived(messages));
    });

    on<GetExplanation>((event, emit) async {
      List<Message>? messages = await Messages.explain(event.m, event.b);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });

    on<GetTranslation>((event, emit) async {
      List<Message>? messages = await Messages.translate(event.m, event.b);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });
  }
}
