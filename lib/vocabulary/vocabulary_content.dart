
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:language_partner/shared/constants/constants.dart';


class VocabularyContent {

  static Future<List<Word>?> getVocabulary() async {
    var result = await http.get(Uri.parse(url()));
    if (result.statusCode == 200) {
      List<dynamic> messages = jsonDecode(result.body);
      return messages.map((e) => Word.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Word>?> addWords(Map<String, dynamic> word) async {
    final response = await http.put(
      Uri.parse(url()),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode(word), // Convert the object to JSON
    );

    if (response.statusCode == 200) {
      return await getVocabulary();
    } else {
      return null;
    }
  }
}

class Word {
  final String original;
  final String translation;

  Word(this.original, this.translation);

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(json.keys.first, json.values.first);
  }

  Map<String, String> toJson() {
    return {
      original: translation
    };
  }
}
