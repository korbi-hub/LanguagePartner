import 'package:flutter/material.dart';
import 'package:language_partner/chat/chat_bubble.dart';

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String message;
  final int timestamp;
  final String b;

  const ChatMessage(
      {super.key,
      required this.isUser,
      required this.message,
      required this.timestamp,
      required this.b});

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
                  b: b,
                ),
        ),
        Expanded(
          flex: isUser ? 2 : 1,
          child: isUser
              ? ChatBubble(
                  isUser: isUser,
                  message: message,
                  timestamp: timestamp,
                  b: b,
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
