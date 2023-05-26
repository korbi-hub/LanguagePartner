import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language_partner/shared/constants/constants.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SearchBar(),
        ContactWindow(
          imagePath: 'imagePath',
          name: contactNameOne,
          onClick: () => print('navigate to $contactNameOne'), options: () { print('navigate to information'); },
        ),
        ContactWindow(
          imagePath: 'imagePath',
          name: contactNameTwo,
          onClick: () => print('navigate to $contactNameTwo'), options: () { print('navigate to information'); },
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: SearchBar(), // TODO: implement SearchBar
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
      child: Container(
        height: 64,
        child: Card(
          elevation: 8,
          child: Padding(
            padding: paddingAllSidesSmall,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: imagePath == imagePath
                      ? Icon(Icons.person)
                      : Image.asset(imagePath),
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
    );
  }
}
