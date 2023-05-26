class Message {
  final DateTime timestamp;
  final String user;
  final String id;
  final String message;
  final String description;

  Message(this.timestamp, this.user, this.id, this.message, this.description);
}



class Messages {
  static List<Message> createTestMsg() {
    List<Message> temp = [];
    for (int i = 0; i < 9; i++) {
      temp.add(Message(DateTime.now(), i % 2 == 0 ? 'A' : 'B', i.toString(), 'message with the number $i', 'description for the message with the number $i'));
    }
    return temp;
  }

  static Future<List<Message>> getMessages() async {
    return [];
  }

}