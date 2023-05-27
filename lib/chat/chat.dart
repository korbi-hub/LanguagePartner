import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat/chat_message.dart';
import 'package:language_partner/chat/message.dart';
import 'package:language_partner/chat_list/chat_list.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';

class Chat extends StatefulWidget {
  final String name;
  late String b;

  Chat({super.key, required this.name}) {
    b = name == 'Jürgen' ? '1' : '2';
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
    bloc = context.read<ChatBloc>()..add(GetMessages('user', widget.b));
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        children: [
          Expanded(
            flex: 9,
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
          Expanded(
            child: Padding(
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
          b: widget.b,
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
            widget.b,
          ),
        );
      });
    }
  }
}
