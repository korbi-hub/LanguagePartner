import 'package:flutter/material.dart';
import 'package:language_partner/chat/view/chat_view/chat.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/shared/shared_widgets/circular_image.dart';

import '../contact_info/contact_info.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ContactWindow(
          imagePath: imgPathJuergen,
          name: contactNameOne,
          onClick: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Chat(name: contactNameOne))),
          options: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactInfo(
                image: imgPathJuergen,
                name: contactNameOne,
                description: descriptionContactOne,
              ),
            ),
          ),
        ),
        ContactWindow(
          imagePath: imgPathLaura,
          name: contactNameTwo,
          onClick: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Chat(name: contactNameTwo),
            ),
          ),
          options: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactInfo(
                image: imgPathLaura,
                name: contactNameTwo,
                description: descriptionContactTwo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactWindow extends StatelessWidget {
  final String imagePath;
  final String name;
  final Function() onClick;
  final Function() options;

  const ContactWindow({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onClick,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingAllSidesRegular,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            height: 64,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: paddingAllSidesSmall,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: CircularImage(
                        path: imagePath,
                        size: 48,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        name,
                        style: textStyleRegular,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline_rounded),
                      onPressed: options,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

