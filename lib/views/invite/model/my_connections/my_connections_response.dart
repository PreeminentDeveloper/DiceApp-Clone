class MyConnectionResponse {
  String? typename;
  ListConnections? listConnections;

  MyConnectionResponse({this.typename, this.listConnections});

  MyConnectionResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    listConnections = json["listConnections"] == null
        ? null
        : ListConnections.fromJson(json["listConnections"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (listConnections != null) {
      data["listConnections"] = listConnections?.toJson();
    }
    return data;
  }
}

class ListConnections {
  String? typename;
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  int? nextPage;
  int? page;
  int? prevPage;
  List<ListOfData>? listOfData;

  ListConnections(
      {this.typename,
      this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.nextPage,
      this.page,
      this.prevPage,
      this.listOfData});

  ListConnections.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
    listOfData = json["list"] == null
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
    if (listOfData != null) {
      data["list"] = listOfData?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListOfData {
  String? typename;
  String? name;
  String? id;
  String? phone;
  String? username;
  dynamic connection;
  Photo? photo;

  ListOfData(
      {this.typename,
      this.name,
      this.id,
      this.phone,
      this.username,
      this.connection,
      this.photo});

  ListOfData.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    name = json["name"];
    id = json["id"];
    phone = json["phone"];
    username = json["username"];
    connection = json["connection"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["name"] = name;
    data["id"] = id;
    data["phone"] = phone;
    data["username"] = username;
    data["connection"] = connection;
    if (photo != null) data["photo"] = photo?.toJson();
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
