part of 'vocabularz_bloc.dart';

@immutable
abstract class VocabularyState {}

class VocabularyInitial extends VocabularyState {}

class LoadingSuccess extends VocabularyState {
  final List<Word> words;

  LoadingSuccess(this.words);
}
class LoadingFailed extends VocabularyState {}
