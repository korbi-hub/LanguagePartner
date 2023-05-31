import 'package:flutter/material.dart';
import 'package:language_partner/chat/view/chat_view/chat_bubble.dart';

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String message;
  final int timestamp;
  final String botId;

  const ChatMessage(
      {super.key,
        required this.isUser,
        required this.message,
        required this.timestamp,
        required this.botId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          flex: !isUser ? 2 : 1,
          child: isUser
              ? SizedBox()
              : ChatBubble(
            isUser: isUser,
            message: message,
            timestamp: timestamp,
            botId: botId,
          ),
        ),
        Expanded(
          flex: isUser ? 2 : 1,
          child: isUser
              ? ChatBubble(
            isUser: isUser,
            message: message,
            timestamp: timestamp,
            botId: botId,
          )
              : SizedBox(),
        ),
      ],
    );
  }
}
