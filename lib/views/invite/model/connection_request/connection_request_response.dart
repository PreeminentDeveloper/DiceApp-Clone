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
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  List? list;
  int? nextPage;
  int? page;
  int? prevPage;

  ListConnectionRequest(
      {this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.list,
      this.nextPage,
      this.page,
      this.prevPage});

  ListConnectionRequest.fromJson(Map<String, dynamic> json) {
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    list = json["list"] == null
        ? null
        : (json["list"]).map((e) => ListOfData.fromJson(e)).toList();
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
      data["list"] = list?.map((e) => ListOfData.fromJson(e)).toList();
    }
    data["nextPage"] = nextPage;
    data["page"] = page;
    data["prevPage"] = prevPage;
    return data;
  }
}

class ListOfData {
  dynamic connection;
  String? id;
  String? message;
  Requester? requester;
  String? requesterId;
  String? userId;

  ListOfData(
      {this.connection,
      this.id,
      this.message,
      this.requester,
      this.requesterId,
      this.userId});

  ListOfData.fromJson(Map<String, dynamic> json) {
    connection = json["connection"];
    id = json["id"];
    message = json["message"];
    requester = json["requester"] == null
        ? null
        : Requester.fromJson(json["requester"]);
    requesterId = json["requesterId"];
    userId = json["userId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["connection"] = connection;
    data["id"] = id;
    data["message"] = message;
    if (requester != null) {
      data["requester"] = requester?.toJson();
    }
    data["requesterId"] = requesterId;
    data["userId"] = userId;
    return data;
  }
}

class Requester {
  String? age;
  String? bio;
  String? id;
  dynamic connection;
  String? deviceId;
  String? name;
  String? phone;
  Photo? photo;
  String? status;
  String? username;

  Requester(
      {this.age,
      this.bio,
      this.id,
      this.connection,
      this.deviceId,
      this.name,
      this.phone,
      this.photo,
      this.status,
      this.username});

  Requester.fromJson(Map<String, dynamic> json) {
    age = json["age"];
    bio = json["bio"];
    id = json["id"];
    connection = json["connection"];
    deviceId = json["deviceId"];
    name = json["name"];
    phone = json["phone"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    status = json["status"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["age"] = age;
    data["bio"] = bio;
    data["id"] = id;
    data["connection"] = connection;
    data["deviceId"] = deviceId;
    data["name"] = name;
    data["phone"] = phone;
    if (photo != null) {
      data["photo"] = photo?.toJson();
    }
    data["status"] = status;
    data["username"] = username;
    return data;
  }
}

class Photo {
  String? hostname;
  String? type;
  String? url;

  Photo({this.hostname, this.type, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
    hostname = json["hostname"];
    type = json["type"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hostname"] = hostname;
    data["type"] = type;
    data["url"] = url;
    return data;
  }
}
