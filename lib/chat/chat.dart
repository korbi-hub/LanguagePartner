import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat/message.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/vocabulary/vocabulary.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';

class Chat extends StatefulWidget {
  final String name;

  const Chat({super.key, required this.name});

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
    bloc = context.read<ChatBloc>()..add(GetMessages());
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
                  )),
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
          isUser: msg.user == 'A',
          message: msg.message,
          timestamp: msg.timestamp!,
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
          ),
        );
      });
    }
  }
}

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String message;
  final String timestamp;

  const ChatMessage(
      {super.key,
      required this.isUser,
      required this.message,
      required this.timestamp});

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
                ),
        ),
        Expanded(
          flex: isUser ? 2 : 1,
          child: isUser
              ? ChatBubble(
                  isUser: isUser,
                  message: message,
                  timestamp: timestamp,
                )
              : SizedBox(),
        ),
      ],
    );
  }

}

class ChatBubble extends StatefulWidget {
  final bool isUser;
  final String message;
  final String timestamp;

  const ChatBubble(
      {super.key,
      required this.isUser,
      required this.message,
      required this.timestamp});

  @override
  State<StatefulWidget> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: GestureDetector(
        onLongPress: () => _showMyDialog(),
        child: Container(
          child: Card(
            elevation: 4,
            color: widget.isUser ? Colors.lightBlue : colorBot,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: paddingAllSidesRegular,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.message,
                          style: textStyleRegular,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: paddingAllSidesRegular,
                      child: Row(
                        mainAxisAlignment: !widget.isUser
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          Text(widget.timestamp),
                          if (!widget.isUser)
                            IconButton(
                              icon: SvgPicture.asset('/kebab_menu.svg'),
                              iconSize: 48,
                              onPressed: () => _showMyDialog(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: Padding(
              padding: paddingAllSidesRegular,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => print('fetch translation'),
                        child: Text(
                          'translate',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () => print('fetch grammar'),
                        child: Text(
                          'grammar',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () async => await Clipboard.setData(
                            ClipboardData(text: widget.message)),
                        child: Text(
                          'copy',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Vocabulary(message: widget.message)),
                        ),
                        child: Text(
                          'get vocabulary',
                          style: textStyleRegular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('close'))
          ],
        );
      },
    );
  }
}
