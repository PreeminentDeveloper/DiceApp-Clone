class SearchUserResponse {
  String? typename;
  List<SearchUser>? searchUser;

  SearchUserResponse({this.typename, this.searchUser});

  SearchUserResponse.fromJson(json) {
    typename = json["__typename"];
    searchUser = json["searchUser"] == null
        ? null
        : (json["searchUser"] as List)
            .map((e) => SearchUser.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (searchUser != null) {
      data["searchUser"] = searchUser?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class SearchUser {
  String? typename;
  String? name;
  String? id;
  String? phone;
  String? username;
  dynamic connection;
  Photo? photo;
  String? age;
  dynamic bio;
  String? status;

  SearchUser(
      {this.typename,
      this.name,
      this.id,
      this.phone,
      this.username,
      this.connection,
      this.photo,
      this.age,
      this.bio,
      this.status});

  SearchUser.fromJson(json) {
    typename = json["__typename"];
    name = json["name"];
    id = json["id"];
    phone = json["phone"];
    username = json["username"];
    connection = json["connection"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    age = json["age"];
    bio = json["bio"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["name"] = name;
    data["id"] = id;
    data["phone"] = phone;
    data["username"] = username;
    data["connection"] = connection;
    if (photo != null) {
      data["photo"] = photo?.toJson();
    }
    data["age"] = age;
    data["bio"] = bio;
    data["status"] = status;
    return data;
  }
}

class Photo {
  String? hostname;
  String? type;
  String? url;

  Photo({this.hostname, this.type, this.url});

  Photo.fromJson(json) {
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
