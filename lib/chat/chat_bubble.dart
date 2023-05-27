import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/vocabulary/vocabulary_content.dart';

class ChatBubble extends StatefulWidget {
  final bool isUser;
  final String message;
  final int timestamp;
  final String b;

  const ChatBubble(
      {super.key,
      required this.isUser,
      required this.message,
      required this.timestamp,
      required this.b});

  @override
  State<StatefulWidget> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: GestureDetector(
        onLongPress: () {
          if (!widget.isUser) {
            _showMyDialog();
          }
        },
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
                    if (!widget.isUser)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: paddingAllSidesRegular,
                          child: GestureDetector(
                            onTap: () {
                              _showMyDialog();
                            },
                            child: SvgPicture.asset(
                              'images/kebab_menu.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        )
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
      barrierDismissible: false,
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
                        onTap: () {
                          context
                              .read<ChatBloc>()
                              .add(GetTranslation(widget.message, widget.b));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'translate text',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<ChatBloc>()
                              .add(GetExplanation(widget.message, widget.b));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'explain grammar',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: widget.message,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'copy text',
                          style: textStyleRegular,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          await VocabularyContent.addWords(widget.message).then(
                            (value) {
                              const snackBar = SnackBar(
                                content: Text('saved vocabulary'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          );
                        },
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
              child: Text('close'),
            ),
          ],
        );
      },
    );
  }
}
