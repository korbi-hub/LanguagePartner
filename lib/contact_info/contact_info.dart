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

  const ContactInfo(
      {super.key,
      required this.image,
      required this.name,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: NavigateBackButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text(
          'contacts',
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularImage(
                path: image,
                size: 128,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: paddingAllSidesRegular.copyWith(right: 8, left: 8),
                child: Card(
                  elevation: 8,
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
                            child: Text(
                              name,
                              style: textStyleLarge,
                            ),
                          ),
                          Padding(
                            padding: paddingAllSidesRegular,
                            child: Text(
                              description,
                              style: textStyleRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'language difficulty level',
                style: textStyleRegular,
              ),
              RadioListDifficulty(),
              SizedBox(
                height: 64,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Chat(name: name))),
        child: Icon(
          Icons.chat,
        ),
      ),
    );
  }
}

enum DifficultyLevel { beginner, intermediate, advanced }

class RadioListDifficulty extends StatefulWidget {
  const RadioListDifficulty({super.key});

  @override
  State<RadioListDifficulty> createState() => _RadioListDifficultyState();
}

class _RadioListDifficultyState extends State<RadioListDifficulty> {
  DifficultyLevel? _character = DifficultyLevel.beginner;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<DifficultyLevel>(
          title: const Text('beginner'),
          value: DifficultyLevel.beginner,
          groupValue: _character,
          onChanged: (DifficultyLevel? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile<DifficultyLevel>(
          title: const Text('intermediate'),
          value: DifficultyLevel.intermediate,
          groupValue: _character,
          onChanged: (DifficultyLevel? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile<DifficultyLevel>(
          title: const Text('advanced'),
          value: DifficultyLevel.advanced,
          groupValue: _character,
          onChanged: (DifficultyLevel? value) {
            setState(() {
              _character = value;
            });
          },
        ),
      ],
    );
  }
}
