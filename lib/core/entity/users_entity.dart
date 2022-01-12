class User {
  String? typename;
  String? id;
  String? name;
  String? phone;
  Photo? photo;
  String? status;
  String? username;

  User(
      {this.typename,
      this.id,
      this.name,
      this.phone,
      this.photo,
      this.status,
      this.username});

  User.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    status = json["status"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["id"] = id;
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
