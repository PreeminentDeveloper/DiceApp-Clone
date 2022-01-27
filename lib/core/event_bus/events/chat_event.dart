import 'package:dice_app/core/util/helper.dart';

class ChatEventModel {
  Data? data;
  dynamic status;

  ChatEventModel({this.data, this.status});

  ChatEventModel.fromJson(json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) data["data"] = this.data?.toJson();
    data["status"] = status;
    return data;
  }
}

class Data {
  Message? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message =
        json["message"] == null ? null : Message.fromJson(json["message"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) data["message"] = message?.toJson();
    return data;
  }
}

class Message {
  String? conversationId;
  int? id;
  String? message;
  String? userId;
  String? insertedAt;
  List<Medias>? medias;

  Message(
      {this.conversationId,
      this.id,
      this.message,
      this.userId,
      this.insertedAt,
      this.medias});

  Message.fromJson(Map<String, dynamic> json) {
    conversationId = json["conversation_id"];
    id = json["id"];
    message = json["message"];
    userId = json["user_id"];
    insertedAt = json["inserted_at"];
    medias = json["medias"] == null
        ? null
        : (json["medias"] as List).map((e) => Medias.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["conversation_id"] = conversationId;
    data["id"] = id;
    data["message"] = message;
    data["user_id"] = userId;
    data["inserted_at"] = insertedAt;

    if (medias != null) {
      data["medias"] = medias?.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class ChatEventBus {
  final ChatEventModel? payload;
  final String? key;
  ChatEventBus(this.key, this.payload);
}

class Medias {
  String? caption;
  String? hostname;
  int? id;
  String? insertedAt;
  String? size;
  String? type;
  String? url;
  String? userId;

  Medias(
      {this.caption,
      this.hostname,
      this.id,
      this.insertedAt,
      this.size,
      this.type,
      this.url,
      this.userId});

  Medias.fromJson(Map<String, dynamic> json) {
    caption = json["caption"];
    hostname = json["hostname"];
    id = json["id"];
    insertedAt = json["inserted_at"];
    size = json["size"];
    type = json["type"];
    url = json["url"];
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["caption"] = caption;
    data["hostname"] = hostname;
    data["id"] = id;
    data["inserted_at"] = insertedAt;
    data["size"] = size;
    data["type"] = type;
    data["url"] = url;
    data["user_id"] = userId;
    return data;
  }
}
