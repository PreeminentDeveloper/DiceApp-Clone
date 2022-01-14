import 'package:dice_app/core/entity/users_entity.dart';

class ConnectionRequestResponse {
  String? typename;
  ListConnectionRequest? listConnectionRequest;

  ConnectionRequestResponse({this.typename, this.listConnectionRequest});

  ConnectionRequestResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listConnectionRequest = json["listConnectionRequest"] == null
        ? null
        : ListConnectionRequest.fromJson(json["listConnectionRequest"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listConnectionRequest != null) {
      data["listConnectionRequest"] = listConnectionRequest?.toJson();
    }
    return data;
  }
}

class ListConnectionRequest {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListData>? listData;

  ListConnectionRequest(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.listData});

  ListConnectionRequest.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  User? requester;

  ListData({this.typename, this.userId, this.requester});

  ListData.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    userId = json["userId"];
    requester =
        json["requester"] == null ? null : User.fromJson(json["requester"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["userId"] = userId;
    if (requester != null) {
      data["requester"] = requester?.toJson();
    }
    return data;
  }
}
