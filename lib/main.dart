import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/auth/view/auth_gate.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat/repo_impl/chat_repository_impl.dart';
import 'package:language_partner/vocabulary/bloc/vocabularz_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:language_partner/vocabulary/repo_impl/vocabulary_repo_impl.dart';

import 'shared/constants/constants.dart';

void main() async {
  await _newUser();
  runApp(const App());
}

// TODO: replace this dirty step by proper auth gate
class UserId {
  static String userId = '';
}

_newUser() async {
  String url = 'https://prefab-bruin-387913.ew.r.appspot.com';
  final generate = await http.post(
    Uri.parse('$url/newUser'),
  );
  UserId.userId = jsonDecode(generate.body)['userId'];
  print(UserId.userId);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (ctx) => ChatBloc(ChatRepositoryImpl()),
        ),
        BlocProvider<VocabularyBloc>(
          create: (ctx) => VocabularyBloc(VocabularyRepoImpl()),
        ),
      ],
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blueAccent,
        ),
        home: AuthGate(),
      ),
    );
  }
}
