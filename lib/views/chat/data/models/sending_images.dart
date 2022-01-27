import 'package:dio/dio.dart';

class ImageSending {
  List<Medias>? medias = [];
  Message? message;

  ImageSending({this.medias, this.message});
  Map<String, dynamic> toJson({bool addMultipath = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medias != null) {
      data["medias"] =
          medias?.map((e) => e.toJson(addMultipath: addMultipath)).toList();
    }
    if (message != null) {
      data['message'] = message?.toJson();
    }

    return data;
  }

  factory ImageSending.fromMap(map) {
    return ImageSending(
      medias: map != null && map['medias'] != null
          ? List<Medias>.from(map['medias']?.map((x) => Medias.fromMap(x)))
          : null,
      message: map != null && map['message'] != null
          ? Message.fromMap(map['message'])
          : null,
    );
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

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      conversationID: map['conversationID'],
      userID: map['userID'],
    );
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

  factory ConversationID.fromMap(Map<String, dynamic> map) {
    return ConversationID(
      id: map['id'],
    );
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

  factory UserID.fromMap(Map<String, dynamic> map) {
    return UserID(
      id: map['id'],
    );
  }
}

class Medias {
  String? caption;
  MultipartFile? file;
  String? filePath;

  Medias({this.caption, this.file, this.filePath});

  Map<String, dynamic> toJson({bool addMultipath = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["caption"] = caption;
    if (addMultipath) data["file"] = file;
    data["filePath"] = filePath;
    return data;
  }

  factory Medias.fromMap(Map<String, dynamic> map) {
    return Medias(
      caption: map['caption'],
      filePath: map['filePath'],
    );
  }
}
