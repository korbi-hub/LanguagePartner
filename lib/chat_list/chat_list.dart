import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language_partner/chat/chat.dart';
import 'package:language_partner/contact_info/contact_info.dart';
import 'package:language_partner/shared/constants/constants.dart';

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
                      icon: SvgPicture.asset('/kebab_menu.svg'),
                      iconSize: 48,
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

class CircularImage extends StatelessWidget {
  final String path;
  final double size;

  const CircularImage({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90.0),
        child: Image.asset(
          path,
          height: size,
          width: size,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
