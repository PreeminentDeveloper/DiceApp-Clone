import 'dart:convert';

import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'sending_images.dart' as local;

class LocalChatModel {
  final String? conversationID;
  final String? id;
  final String? userID;
  final String? time;
  final String? message;
  final String? insertLocalTime;
  final String? messageType;
  local.ImageSending? imageSending;
  Message? messageFromEvent;

  LocalChatModel(
      {this.conversationID,
      this.id,
      this.userID,
      this.time,
      this.message,
      this.insertLocalTime,
      this.messageFromEvent,
      this.messageType,
      this.imageSending});

  Map<String, dynamic> toMap() {
    return {
      'conversationID': conversationID,
      'id': id,
      'userID': userID,
      'time': time,
      'message': message,
      'insertLocalTime': insertLocalTime,
      'localImage': imageSending?.toJson(),
      'messageType': messageType,
      'messageFromEvent': messageFromEvent?.toJson(),
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
      messageType: map['messageType'],
      imageSending: local.ImageSending.fromMap(map['localImage']),
      messageFromEvent: map['messageFromEvent'] != null
          ? Message.fromJson(map['messageFromEvent'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalChatModel.fromJson(String source) =>
      LocalChatModel.fromMap(json.decode(source));
}
