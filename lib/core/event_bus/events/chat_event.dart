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

  Message({this.conversationId, this.id, this.message, this.userId});

  Message.fromJson(Map<String, dynamic> json) {
    conversationId = json["conversation_id"];
    id = json["id"];
    message = json["message"];
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["conversation_id"] = conversationId;
    data["id"] = id;
    data["message"] = message;
    data["user_id"] = userId;
    return data;
  }
}

class ChatEventBus {
  final ChatEventModel? payload;
  final String? key;
  ChatEventBus(this.key, this.payload);
}
