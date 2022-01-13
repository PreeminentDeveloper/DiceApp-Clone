import 'package:dice_app/core/entity/users_entity.dart';

class ListOfConversationResponse {
  Data? data;

  ListOfConversationResponse({this.data});

  ListOfConversationResponse.fromJson(json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  ListConversations? listConversations;

  Data({this.listConversations});

  Data.fromJson(Map<String, dynamic> json) {
    listConversations = json["listConversations"] == null
        ? null
        : ListConversations.fromJson(json["listConversations"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listConversations != null) {
      data["listConversations"] = listConversations?.toJson();
    }
    return data;
  }
}

class ListConversations {
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  List<ListOfData>? list;
  int? nextPage;
  int? page;
  int? prevPage;

  ListConversations(
      {this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.list,
      this.nextPage,
      this.page,
      this.prevPage});

  ListConversations.fromJson(Map<String, dynamic> json) {
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => ListOfData.fromJson(e)).toList();
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstPage"] = firstPage;
    data["hasNext"] = hasNext;
    data["hasPrev"] = hasPrev;
    if (list != null) {
      data["list"] = list?.map((e) => e.toJson()).toList();
    }
    data["nextPage"] = nextPage;
    data["page"] = page;
    data["prevPage"] = prevPage;
    return data;
  }
}

class ListOfData {
  String? id;
  dynamic name;
  String? type;
  String? updatedAt;
  String? userId;
  List<User>? users;

  ListOfData(
      {this.id, this.name, this.type, this.updatedAt, this.userId, this.users});

  ListOfData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    updatedAt = json["updatedAt"];
    userId = json["userId"];
    users = json["users"] == null
        ? null
        : (json["users"] as List).map((e) => User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["type"] = type;
    data["updatedAt"] = updatedAt;
    data["userId"] = userId;
    if (users != null) {
      data["users"] = users?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
