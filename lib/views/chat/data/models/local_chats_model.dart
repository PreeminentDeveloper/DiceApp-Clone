import 'dart:convert';

class LocalChatModel {
  final String? conversationID;
  final String? id;
  final String? userID;
  final String? time;
  final String? message;
  final String? insertLocalTime;

  LocalChatModel(
      {this.conversationID,
      this.id,
      this.userID,
      this.time,
      this.message,
      this.insertLocalTime});

  Map<String, dynamic> toMap() {
    return {
      'conversationID': conversationID,
      'id': id,
      'userID': userID,
      'time': time,
      'message': message,
      'insertLocalTime': insertLocalTime,
    };
  }

  factory LocalChatModel.fromMap(Map<String, dynamic> map) {
    return LocalChatModel(
      conversationID: map['conversationID'],
      id: map['id']?.toString(),
      userID: map['userID'],
      time: map['time'],
      message: map['message'],
      insertLocalTime: map['insertLocalTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalChatModel.fromJson(String source) =>
      LocalChatModel.fromMap(json.decode(source));
}
