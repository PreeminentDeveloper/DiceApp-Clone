import 'dart:io';

import 'package:dio/dio.dart';

class ImageSending {
  List<Medias>? medias;
  Message? message;

  ImageSending({this.medias, this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medias != null) {
      data["medias"] = medias?.map((e) => e.toJson()).toList();
    }
    if (message != null) {
      data['message'] = message?.toJson();
    }

    return data;
  }
}

class Message {
  String? message;
  String? conversationID;
  String? userID;

  Message({this.message, this.conversationID, this.userID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["conversation_id"] = conversationID;
    data["user_id"] = userID;
    return data;
  }
}

class ConversationID {
  String? id;

  ConversationID({this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["conversation_id"] = id;
    return data;
  }
}

class UserID {
  String? id;

  UserID({this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = id;
    return data;
  }
}

class Medias {
  String? caption;
  MultipartFile? file;

  Medias({this.caption, this.file});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["caption"] = caption;
    data["file"] = file;
    return data;
  }
}
