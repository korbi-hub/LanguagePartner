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