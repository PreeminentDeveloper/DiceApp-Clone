class User {
  String? typename;
  String? connection;
  String? name;
  String? id;
  dynamic bio;
  String? phone;
  String? username;
  String? status;
  Photo? photo;
  dynamic conversation;

  User(
      {this.typename,
      this.connection,
      this.name,
      this.id,
      this.bio,
      this.phone,
      this.username,
      this.status,
      this.photo,
      this.conversation});

  User.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    connection = json["connection"];
    name = json["name"];
    id = json["id"];
    bio = json["bio"];
    phone = json["phone"];
    username = json["username"];
    status = json["status"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    conversation = json["conversation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["connection"] = connection;
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["phone"] = phone;
    data["username"] = username;
    data["status"] = status;
    if (photo != null) data["photo"] = photo?.toJson();
    data["conversation"] = conversation;
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
