

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<RequestOptions>((event, emit) {
      emit(OptionsRequested());
    });

    on<HideOptions>((event, emit) {
      emit(ChatInitial());
    });
  }
}
