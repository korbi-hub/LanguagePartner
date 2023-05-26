import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/chat/bloc/chat_bloc.dart';
import 'package:language_partner/chat_list/view/homepage.dart';
import 'package:language_partner/vocabulary/bloc/vocabularz_bloc.dart';

void main() {
  runApp(const App());
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
