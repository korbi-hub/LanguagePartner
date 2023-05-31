import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/vocabulary/bloc/vocabularz_bloc.dart';

class Vocabulary extends StatefulWidget {
  const Vocabulary({super.key});

  @override
  State<StatefulWidget> createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  late VocabularyBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<VocabularyBloc>();
    bloc.add(RequestNormal());
    return Padding(
      padding: paddingAllSidesRegular,
      child: BlocBuilder<VocabularyBloc, VocabularyState>(
        bloc: bloc,
        builder: (ctx, state) {
          if (state is LoadingSuccess) {
            return ListView.builder(
              itemCount: state.words.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: paddingAllSidesRegular,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.words[i].original,
                          style: textStyleRegular,
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
                          state.words[i].translation,
                          style: textStyleRegular,
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
