import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';

class ListOfConversationResponse {
  String? typename;
  ListConversations? listConversations;

  ListOfConversationResponse({this.typename, this.listConversations});

  ListOfConversationResponse.fromJson(json) {
    typename = json["__typename"];
    listConversations = json["listConversations"] == null
        ? null
        : ListConversations.fromJson(json["listConversations"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listConversations != null) {
      data["listConversations"] = listConversations?.toJson();
    }
    return data;
  }
}

class ListConversations {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListOfData>? list;

  ListConversations(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.list});

  ListConversations.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => ListOfData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["firstPage"] = firstPage;
    data["hasNext"] = hasNext;
    data["hasPrev"] = hasPrev;
    data["nextPage"] = nextPage;
    data["page"] = page;
    data["prevPage"] = prevPage;
    if (list != null) data["list"] = list?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ListOfData {
  String? typename;
  String? id;
  dynamic name;
  String? status;
  String? type;
  String? updatedAt;
  String? userId;
  int? viewersCount;
  int? unread;
  LastMessage? lastMessage;
  List<User>? users;

  ListOfData(
      {this.typename,
      this.id,
      this.name,
      this.status,
      this.type,
      this.updatedAt,
      this.lastMessage,
      this.userId,
      this.viewersCount,
      this.unread,
      this.users});

  ListOfData.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    id = json["id"];
    name = json["name"];
    status = json["status"];
    viewersCount = json["viewersCount"];
    unread = json["unread"];
    lastMessage = json["lastMessage"] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
    type = json["type"];
    updatedAt = json["updatedAt"];
    userId = json["userId"];
    users = json["users"] == null
        ? null
        : (json["users"] as List).map((e) => User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["id"] = id;
    data["name"] = name;
    data["status"] = status;
    data["viewersCount"] = viewersCount;
    data["unread"] = unread;
    data["type"] = type;
    data["updatedAt"] = updatedAt;
    data["userId"] = userId;
    if (users != null) data["users"] = users?.map((e) => e.toJson()).toList();
    logger.d(lastMessage?.toJson());

    data["lastMessage"] = lastMessage?.toJson();
    return data;
  }
}

class LastMessage {
  String? insertedAt;
  String? message;

  LastMessage({this.insertedAt, this.message});

  LastMessage.fromJson(json) {
    insertedAt = json["insertedAt"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["insertedAt"] = insertedAt;
    return data;
  }
}
