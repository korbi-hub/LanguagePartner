import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat_list/bloc/chat_list_bloc.dart';
import 'package:language_partner/shared/constants/constants.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String message;
  final DateTime timestamp;

  const ChatMessage(
      {super.key,
      required this.isUser,
      required this.message,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          child: child,
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: Card(),
    );
  }
}

class OptionsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
