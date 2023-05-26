import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat_list/bloc/chat_list_bloc.dart';
import 'package:language_partner/chat_list/view/homepage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: BlocProvider(
        create: (BuildContext context) => ChatBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
