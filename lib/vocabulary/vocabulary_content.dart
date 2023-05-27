import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:language_partner/chat/message.dart';
import 'package:language_partner/main.dart';

class VocabularyContent {
  static Future<List<Word>?> getVocabulary() async {
    Uri uri = Uri.parse('${Messages.url}/api/user/${UserId.userId}/vocabulary');
    var result = await http.get(uri);
    print(result.body);
    return _sort(result.body);
  }

  static Future<void> addWords(String msg) async {
    await http.post(
      Uri.parse(
          '${Messages.url}/api/users/${UserId.userId}/saveVocabularyFromSentence'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({
        'message': msg,
        'outputLanguage': 'German'
      }), // Convert the object to JSON
    );
  }

  static List<Word> _sort(String result) {
    List<String> m = result.split(',');
    List<Word> temp = m.map((e) => Word.fromJson(e)).toList();
    temp.sort(
        (a, b) => a.original.toLowerCase().compareTo(b.original.toLowerCase()));
    return temp;
  }
}

class Word {
  final String original;
  final String translation;

  Word(this.original, this.translation);

  factory Word.fromJson(String s) {
    List<String> sub = s.split(':');
    return Word(
      sub.first.replaceAll('"', "").replaceAll('{', "").replaceAll('}', ""),
      sub.last.replaceAll('"', "").replaceAll('{', "").replaceAll('}', ""),
    );
  }

  Map<String, String> toJson() {
    // fuck me
    return {
      'key': original,
      'value': translation,
    };
  }
}
