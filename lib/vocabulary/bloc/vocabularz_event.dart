part of 'vocabularz_bloc.dart';

@immutable
abstract class VocabularyEvent {}

class RequestNormal extends VocabularyEvent {}

class RequestParam extends VocabularyEvent {

  final Word word;

  RequestParam(this.word);

}
