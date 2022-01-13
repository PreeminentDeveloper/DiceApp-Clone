
class MyConnectionResponse {
  String? typename;

  ListConnections? listConnections;

  MyConnectionResponse({this.typename, this.listConnections});

  MyConnectionResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listConnections = json["listConnections"] == null ? null : ListConnections.fromJson(json["listConnections"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if(listConnections != null) {
      data["listConnections"] = listConnections?.toJson();
    }
    return data;
  }
}

class ListConnections {
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  List? list;
  int? nextPage;
  int? page;
  int? prevPage;

  ListConnections({this.firstPage, this.hasNext, this.hasPrev, this.list, this.nextPage, this.page, this.prevPage});

  ListConnections.fromJson(Map<String, dynamic> json) {
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    list = json["list"] ?? [];

    // list = json["list"]==null ? null : (json["list"]).map((e)=>List.fromJson(e)).toList();
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstPage"] = firstPage;
    data["hasNext"] = hasNext;
    data["hasPrev"] = hasPrev;
    if(list != null) {
      data["list"] = list;
          // ?.map((e)=>e.toJson()).toList();
    }
    data["nextPage"] = nextPage;
    data["page"] = page;
    data["prevPage"] = prevPage;
    return data;
  }
}

class List {
  String? age;
  String? bio;
  dynamic connection;
  String? deviceId;
  String? id;
  String? name;
  String? phone;
  Photo? photo;
  String? status;
  String? username;

  List({this.age, this.bio, this.connection, this.deviceId, this.id, this.name, this.phone, this.photo, this.status, this.username});

  List.fromJson(Map<String, dynamic> json) {
    age = json["age"];
    bio = json["bio"];
    connection = json["connection"];
    deviceId = json["deviceId"];
    id = json["id"];
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
    data["connection"] = connection;
    data["deviceId"] = deviceId;
    data["id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    if(photo != null) {
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
