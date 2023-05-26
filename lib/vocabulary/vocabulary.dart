import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/vocabulary/bloc/vocabularz_bloc.dart';

class Vocabulary extends StatefulWidget {
  final String? message;

  const Vocabulary({super.key, required this.message});

  @override
  State<StatefulWidget> createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: BlocBuilder<VocabularyBloc, VocabularyState>(
        bloc: context.read<VocabularyBloc>()..add(RequestNormal()),
        builder: (ctx, state) {
          if (state is VocabularyInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadingSuccess) {
            return ListView.builder(
              itemCount: state.words.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: paddingAllSidesRegular,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.words[i].original,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: VerticalDivider(
                          thickness: 2,
                          width: 20,
                          color: Colors.black38,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            state.words[i].original
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
