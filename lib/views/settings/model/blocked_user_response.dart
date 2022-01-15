import 'package:dice_app/core/entity/users_entity.dart';

class BlockedUsersResponse {
  String? typename;
  ListBlockedUsers? listBlockedUsers;

  BlockedUsersResponse({this.typename, this.listBlockedUsers});

  BlockedUsersResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listBlockedUsers = json["listBlockedUsers"] == null
        ? null
        : ListBlockedUsers.fromJson(json["listBlockedUsers"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listBlockedUsers != null) {
      data["listBlockedUsers"] = listBlockedUsers?.toJson();
    }
    return data;
  }
}

class ListBlockedUsers {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<User>? listData;

  ListBlockedUsers(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.listData});

  ListBlockedUsers.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    listData = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => User.fromJson(e)).toList();
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
    if (listData != null) {
      data["list"] = listData?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class BlockedData {
  String? typename;
  User? list;

  BlockedData({this.typename, this.list});

  BlockedData.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    list = json["list"] == null ? null : User.fromJson(json["list"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (list != null) {
      data["list"] = list?.toJson();
    }
    return data;
  }
}
