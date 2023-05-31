import 'package:bloc/bloc.dart';
import 'package:language_partner/chat/model/message.dart';
import 'package:language_partner/chat/repo/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final ChatRepository repository;

  ChatBloc(this.repository) : super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      List<Message>? messages = await repository.sendMessages(event.message, event.userId, event.botId);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });

    on<GetMessages>((event, emit) async {
      List<Message>? messages = await repository.getMessages(event.userId, event.botId);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });

    on<GetExplanation>((event, emit) async {
      List<Message>? messages = await repository.getExplanation(event.message, event.userId, event.botId);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });

    on<GetTranslation>((event, emit) async {
      List<Message>? messages = await repository.getTranslation(event.message, event.userId, event.botId);
      messages == null
          ? emit(MessageReceivingFailed())
          : emit(MessagesReceived(messages));
    });
  }
}
