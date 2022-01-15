import 'package:dice_app/core/entity/users_entity.dart';

class IgnoreUsersResponse {
  String? typename;
  ListIgnoredUsers? listIgnoredUsers;

  IgnoreUsersResponse({this.typename, this.listIgnoredUsers});

  IgnoreUsersResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listIgnoredUsers = json["listIgnoredUsers"] == null
        ? null
        : ListIgnoredUsers.fromJson(json["listIgnoredUsers"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listIgnoredUsers != null) {
      data["listIgnoredUsers"] = listIgnoredUsers?.toJson();
    }
    return data;
  }
}

class ListIgnoredUsers {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<User>? ignoredData;

  ListIgnoredUsers(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.ignoredData});

  ListIgnoredUsers.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    ignoredData = json["list"] == null
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
    if (ignoredData != null) {
      data["list"] = ignoredData?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

// class IgnoredData {
//   String? typename;
//   User? list;
//
//   IgnoredData({this.typename, this.list});
//
//   IgnoredData.fromJson(Map<String, dynamic> json) {
//     typename = json["__typename"];
//     list = json["list"] == null ? null : User.fromJson(json["list"]);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["__typename"] = typename;
//     if (list != null) {
//       data["list"] = list?.toJson();
//     }
//     return data;
//   }
// }
