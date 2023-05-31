import 'package:language_partner/shared/constants/constants.dart';
import 'package:language_partner/vocabulary/models/word.dart';
import 'package:language_partner/vocabulary/repo/vocabulary_repo.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class VocabularyRepoImpl implements VocabularyRepo {
  /// prefix for api calls concerning the vocabulary
  String apiPrefix(String userId) => '$urlBase/api/user/$userId';

  ///
  /// adds words to the user's vocabulary using the [message] and the [userId]
  ///
  @override
  Future<void> addWords(String message, String userId) async {
    await http.post(
      Uri.parse('${apiPrefix(userId)}/saveVocabularyFromSentence'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'message': message, 'outputLanguage': 'German'}),
    );
  }

  ///
  /// retrieves the user's vocabulary using the [userId]
  ///
  @override
  Future<List<Word>?> getVocabulary(String userId) async {
    Uri uri = Uri.parse('${apiPrefix(userId)}/vocabulary');
    var result = await http.get(uri);
    print(result.body);
    return _sort(result.body);
  }

  ///
  /// sort the [result] of an api request alphabetically
  ///
  List<Word> _sort(String result) {
    List<String> m = result.split(',');
    List<Word> temp = m.map((e) => Word.fromJson(e)).toList();
    temp.sort(
        (a, b) => a.original.toLowerCase().compareTo(b.original.toLowerCase()));
    return temp;
  }
}
