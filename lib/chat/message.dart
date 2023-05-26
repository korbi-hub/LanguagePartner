import 'dart:convert';

import 'package:http/http.dart' as http;

import '../shared/constants/constants.dart';

class Message {
  final String user;
  final String id;
  final String message;
  final String description;
  final String? timestamp;

  Message(this.user, this.id, this.message, this.description, this.timestamp);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['user'],
      json['id'],
      json['message'],
      json['description'],
      json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'id': id,
      'message': message,
      'description': description,
      'timestamp': timestamp,
    };
  }
}



class Messages {

  static Future<List<Message>> getMessages() async {
    var result = await http.get(Uri.parse(url()));
    List<dynamic> messages = jsonDecode(result.body);
    return messages.map((e) => Message.fromJson(e)).toList();
  }

  static Future<List<Message>?> sendMessage(Map<String, dynamic> message) async {
    final response = await http.put(
      Uri.parse(url()),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode(message), // Convert the object to JSON
    );

    if (response.statusCode == 200) {
      return await getMessages();
    } else {
      return null;
    }
  }

}