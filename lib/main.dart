import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/vocabulary/bloc/vocabularz_bloc.dart';
import 'package:http/http.dart' as http;

void main() async {
  await _newUser();
  runApp(const App());
}

class UserId {
  static String userId = '';
}

_newUser() async {
  String url = 'https://prefab-bruin-387913.ew.r.appspot.com';
  final generate = await http.post(
    Uri.parse('$url/newUser'),
  );
  UserId.userId = jsonDecode( generate.body)['userId'];
  print(UserId.userId);
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (ctx) => ChatBloc(),
        ),
        BlocProvider<VocabularyBloc>(
          create: (ctx) => VocabularyBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'LaPa',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blueAccent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
