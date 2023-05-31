part of 'vocabularz_bloc.dart';

@immutable
abstract class VocabularyEvent {}

class RequestNormal extends VocabularyEvent {}

class RequestParam extends VocabularyEvent {

  final String word;

  RequestParam(this.word);
}

class AddWords extends VocabularyEvent {
  final String message;
  final String userId;

  AddWords(this.message, this.userId);
}
