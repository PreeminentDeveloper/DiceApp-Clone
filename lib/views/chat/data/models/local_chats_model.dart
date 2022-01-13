import 'dart:convert';

class LocalChatModel {
  final String? conversationID;
  final int? id;
  final String? userID;
  final String? time;
  final String? message;

  LocalChatModel(
      {this.conversationID, this.id, this.userID, this.time, this.message});

  Map<String, dynamic> toMap() {
    return {
      'conversationID': conversationID,
      'id': id,
      'userID': userID,
      'time': time,
      'message': message,
    };
  }

  factory LocalChatModel.fromMap(Map<String, dynamic> map) {
    return LocalChatModel(
      conversationID: map['conversationID'],
      id: map['id']?.toInt(),
      userID: map['userID'],
      time: map['time'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalChatModel.fromJson(String source) =>
      LocalChatModel.fromMap(json.decode(source));
}
