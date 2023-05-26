import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language_partner/chat/message.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';

class Chat extends StatefulWidget {
  final String name;

  const Chat({super.key, required this.name});

  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages = Messages.createTestMsg();

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
    return Scaffold(
        appBar: AppBar(
          leading: NavigateBackButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen()),
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
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (ctx, index) {
                  Message msg = messages.elementAt(index);
                  return ChatMessage(
                    isUser: msg.user == 'A',
                    message: msg.message,
                    timestamp: msg.timestamp,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: paddingAllSidesRegular,
                child: Row(
                  children: [
                    Expanded(
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
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String text = _controller.text;
      _controller.text = '';
      setState(() {
        messages.add(
          Message(
            DateTime.now(),
            'A',
            messages.length.toString(),
            text,
            'description for $text',
          ),
        );
      });
    }
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
                  timestamp: _formatTimestamp(timestamp),
                ),
        ),
        Expanded(
          flex: isUser ? 2 : 1,
          child: isUser
              ? ChatBubble(
                  isUser: isUser,
                  message: message,
                  timestamp: _formatTimestamp(timestamp),
                )
              : SizedBox(),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '10:00';
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
      child: Container(
        child: Card(
          elevation: 8,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.message,
                          style: textStyleRegular,
                          textAlign: TextAlign.start,
                        )
                      ],
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
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
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
                      Text(
                        'translate',
                        style: textStyleRegular,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'grammar',
                        style: textStyleRegular,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'copy',
                        style: textStyleRegular,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'get vocabulary',
                        style: textStyleRegular,
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
