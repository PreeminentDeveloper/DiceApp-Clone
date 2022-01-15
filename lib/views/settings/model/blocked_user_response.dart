import 'package:dice_app/core/entity/users_entity.dart';

class BlockedUsersResponse {
  String? typename;
  ListBlockedUser? listBlockedUser;

  BlockedUsersResponse({this.typename, this.listBlockedUser});

  BlockedUsersResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listBlockedUser = json["listBlockedUser"] == null
        ? null
        : ListBlockedUser.fromJson(json["listBlockedUser"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listBlockedUser != null) {
      data["listBlockedUser"] = listBlockedUser?.toJson();
    }
    return data;
  }
}

class ListBlockedUser {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListData>? listData;

  ListBlockedUser(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.listData});

  ListBlockedUser.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    listData = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => ListData.fromJson(e)).toList();
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

class ListData {
  String? typename;
  User? list;

  ListData({this.typename, this.list});

  ListData.fromJson(Map<String, dynamic> json) {
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
