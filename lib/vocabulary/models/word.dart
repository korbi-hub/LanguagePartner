
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