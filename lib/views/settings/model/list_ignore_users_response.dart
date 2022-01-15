import 'package:dice_app/core/entity/users_entity.dart';

class IgnoreUsersResponse {
  String? typename;
  ListIgnoreUser? listIgnoreUser;

  IgnoreUsersResponse({this.typename, this.listIgnoreUser});

  IgnoreUsersResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listIgnoreUser = json["listIgnoreUser"] == null
        ? null
        : ListIgnoreUser.fromJson(json["listIgnoreUser"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listIgnoreUser != null) {
      data["listIgnoreUser"] = listIgnoreUser?.toJson();
    }
    return data;
  }
}

class ListIgnoreUser {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListData>? listData;

  ListIgnoreUser(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.listData});

  ListIgnoreUser.fromJson(Map<String, dynamic> json) {
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
