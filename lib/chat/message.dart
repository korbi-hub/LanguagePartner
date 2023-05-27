import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:language_partner/main.dart';

class Message {
  final String user;
  final String id;
  final String message;
  final String? description;
  final int? timestamp;

  Message(this.user, this.id, this.message, this.description, this.timestamp);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['user'],
      json['id'].toString(),
      json['messages'],
      json['description'],
      json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

class Messages {

  static String url = 'https://prefab-bruin-387913.ew.r.appspot.com';

  static Future<List<Message>> getMessages(String user, String bot) async {
    Uri uri = Uri.parse('$url/api/user/${UserId.userId}/chats/$bot/messages');
    var result = await http.get(uri);
    return _sort(result.body);
  }

  static Future<List<Message>?> sendMessage(Map<String, dynamic> message, String bot) async {
    await http.post(
      Uri.parse('$url/api/user/${UserId.userId}/chats/$bot/sendMessage'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode(message), // Convert the object to JSON
    );
    final generate = await http.post(
      Uri.parse('$url/api/user/${UserId.userId}/chats/$bot/generateResponse'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'language':'English'}), // Convert the object to JSON
    );
    print(generate.body);
    return _sort(generate.body);
  }

  static Future<List<Message>?> explain(String message, String bot) async {
    final generate = await http.post(
      Uri.parse('$url/api/user/${UserId.userId}/chats/$bot/explainGrammar'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'message': message,'outputLanguage':'German'}), // Convert the object to JSON
    );
    print(generate.body);
    return _sort(generate.body);
  }

  static Future<List<Message>?> translate(String message, String bot) async {
    final generate = await http.post(
      Uri.parse('$url/api/user/${UserId.userId}/chats/$bot/translate'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'message': message,'outputLanguage':'German'}), // Convert the object to JSON
    );
    print(generate.body);
    return _sort(generate.body);
  }

  static List<Message> _sort(String result) {
    List<dynamic> messages = jsonDecode(result);
    List<Message> temp = messages.map((e) => Message.fromJson(e)).toList();
    temp.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
    return temp;
  }

}