import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat/model/message.dart';
import 'package:language_partner/chat/view/chat_view/chat_message.dart';
import 'package:language_partner/homepage/homepage.dart';
import 'package:language_partner/main.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';
import 'package:language_partner/shared/shared_widgets/circular_image.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  final String name;
  late String botId;

  Chat({super.key, required this.name}) {
    botId = name == 'Jürgen' ? '1' : '2';
  }

  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<ChatBloc>()..add(GetMessages('user', widget.botId));
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        leading: NavigateBackButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
        title: Text(
          widget.name,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircularImage(
              path: widget.name == 'Laura' ? imgPathLaura : imgPathJuergen,
              size: 48,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              bloc: bloc,
              builder: (ctx, state) {
                if (state is ChatInitial) {
                  return _createList([]);
                } else if (state is MessagesReceived) {
                  return _createList(state.messages);
                } else {
                  return _createList([]);
                }
              },
            ),
          ),
          Padding(
            padding: paddingAllSidesRegular,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'enter a message',
                        contentPadding: const EdgeInsets.only(
                          left: 8.0,
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => _sendMessage(),
                          icon: Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createList(List<Message> messages) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (ctx, index) {
        Message msg = messages.elementAt(messages.length - 1 - index);
        return ChatMessage(
          isUser: msg.user == 'Human',
          message: msg.message,
          timestamp: msg.timestamp!,
          botId: widget.botId,
        );
      },
    );
  }

  _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String text = _controller.text;
      _controller.text = '';
      setState(() {
        bloc.add(
          SendMessage(
            Message(
              'user',
              'id',
              text,
              null,
              null,
            ).toJson(),
            widget.botId,
            UserId.userId,
          ),
        );
      });
    }
  }
}
