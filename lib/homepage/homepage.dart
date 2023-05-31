
import 'package:flutter/material.dart';
import 'package:language_partner/chat/view/contact_list/chat_list.dart';
import 'package:language_partner/vocabulary/view/vocabulary.dart';
import 'package:language_partner/shared/shared_widgets/back_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      appBar: AppBar(
        leading: NavigateBackButton(
          onPressed: () {},
        ),
        title: Text('Chat'),
      ),
      body: ChatList(),
    ),
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vocabulary'),
      ),
      body: Vocabulary(),
    ),
    // Scaffold(
      //appBar: AppBar(
        //title: Text('Settings'),
      //),
      //body: Text(''),
    //),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_sharp),
            label: 'vocabulary',
          ),
          //BottomNavigationBarItem(
            //icon: Icon(Icons.settings),
            //label: 'settings',
          //),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
