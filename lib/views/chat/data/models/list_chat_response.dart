class ListOoChatResponse {
  String? typename;
  ListMessages? listMessages;

  ListOoChatResponse({this.typename, this.listMessages});

  ListOoChatResponse.fromJson(json) {
    typename = json["__typename"];
    listMessages = json["listMessages"] == null
        ? null
        : ListMessages.fromJson(json["listMessages"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listMessages != null) {
      data["listMessages"] = listMessages?.toJson();
    }
    return data;
  }
}

class ListMessages {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListOfMessages>? list;

  ListMessages(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.list});

  ListMessages.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    list = json["list"] == null
        ? null
        : (json["list"] as List)
            .map((e) => ListOfMessages.fromJson(e))
            .toList();
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
    if (list != null) {
      data["list"] = list?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListOfMessages {
  String? typename;
  String? insertedAt;
  String? id;
  String? message;
  User? user;
  List<dynamic>? medias;

  ListOfMessages(
      {this.typename,
      this.insertedAt,
      this.id,
      this.message,
      this.user,
      this.medias});

  ListOfMessages.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    insertedAt = json["insertedAt"];
    id = json["id"];
    message = json["message"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    medias = json["medias"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["insertedAt"] = insertedAt;
    data["id"] = id;
    data["message"] = message;
    if (user != null) data["user"] = user?.toJson();
    if (medias != null) data["medias"] = medias;
    return data;
  }
}

class User {
  String? typename;
  String? id;
  String? name;
  String? phone;
  String? status;
  String? username;

  User(
      {this.typename,
      this.id,
      this.name,
      this.phone,
      this.status,
      this.username});

  User.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    status = json["status"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    data["status"] = status;
    data["username"] = username;
    return data;
  }
}
