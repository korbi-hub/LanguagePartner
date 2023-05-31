import 'dart:convert';

import 'package:language_partner/chat/model/message.dart';
import 'package:language_partner/chat/repo/chat_repository.dart';
import 'package:language_partner/shared/constants/constants.dart';

import 'package:http/http.dart' as http;

class ChatRepositoryImpl implements ChatRepository {

  String _apiPrefix(String userId, String botId) => '$urlBase/api/user/$userId/chats/$botId';

  @override
  Future<List<Message>?> getExplanation(String message, String userId, String botId) async {
    final generate = await http.post(
      Uri.parse('${_apiPrefix(userId, botId)}/explainGrammar'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'message': message,'outputLanguage':'German'}), // Convert the object to JSON
    );
    return _sort(generate.body);
  }

  @override
  Future<List<Message>?> getMessages(String userId, String botId) async {
    Uri uri = Uri.parse('${_apiPrefix(userId, botId)}/messages');
    var result = await http.get(uri);
    return _sort(result.body);

  }

  @override
  Future<List<Message>?> getTranslation(String message, String userId, String botId) async {
    final generate = await http.post(
      Uri.parse('${_apiPrefix(userId, botId)}/translate'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'message': message,'outputLanguage':'German'}), // Convert the object to JSON
    );
    return _sort(generate.body);
  }

  @override
  Future<List<Message>?> sendMessages(Map<String, dynamic> message, String userId, String botId) async {
    await http.post(
      Uri.parse('${_apiPrefix(userId, botId)}/sendMessage'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode(message), // Convert the object to JSON
    );
    final generate = await http.post(
      Uri.parse('${_apiPrefix(userId, botId)}/generateResponse'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type as JSON
      },
      body: jsonEncode({'language':'English'}), // Convert the object to JSON
    );
    List<Message> messages = _sort(generate.body);
    return messages.isNotEmpty ? messages : null;
  }

  List<Message> _sort(String result) {
    List<dynamic> messages = jsonDecode(result);
    List<Message> temp = messages.map((e) => Message.fromJson(e)).toList();
    temp.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
    return temp;
  }

}