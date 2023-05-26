import 'package:flutter/material.dart';
import 'package:language_partner/chat/chat.dart';
import 'package:language_partner/chat_list/chat_list.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';

class ContactInfo extends StatelessWidget {

  final String image;
  final String name;
  final String description;

  const ContactInfo({super.key, required this.image, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NavigateBackButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen())),
        ),
        title: Text(
          'persona information',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: CircularImage(
              path: image,
              size: 64,
            ),
          ),Expanded(
            flex: 1,
            child: Text(
              name,
              style: textStyleLarge,
            ),
          ),Expanded(
            flex: 4,
            child: Text(
              description,
              style: textStyleRegular,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Chat(name: name))),
        child: Icon(
          Icons.chat,
        ),
      ),
    );
  }

}