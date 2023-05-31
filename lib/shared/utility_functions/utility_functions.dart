import 'dart:convert';

import 'package:language_partner/chat/model/message.dart';

List<Message> sort(String result) {
  List<dynamic> messages = jsonDecode(result);
  List<Message> temp = messages.map((e) => Message.fromJson(e)).toList();
  temp.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
  return temp;
}
