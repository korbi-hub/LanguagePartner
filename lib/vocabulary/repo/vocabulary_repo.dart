import 'package:language_partner/vocabulary/models/word.dart';

abstract class VocabularyRepo {

  Future<List<Word>?> getVocabulary(String userId);

  Future<void> addWords(String msg, String userId);
}
