
class SearchUserResponse {
  String? typename;
  List<SearchUser>? searchUser;


  SearchUserResponse({this.typename, this.searchUser});

  SearchUserResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    searchUser = json["searchUser"]==null ? null : (json["searchUser"] as List).map((e)=>SearchUser.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;

    if(searchUser != null) {
      data["searchUser"] = searchUser?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}


class SearchUser {
  String? age;
  dynamic bio;
  dynamic connection;
  String? id;
  String? name;
  String? phone;
  Photo? photo;
  String? status;
  String? username;

  SearchUser({this.age, this.bio, this.connection, this.id, this.name, this.phone, this.photo, this.status, this.username});

  SearchUser.fromJson(Map<String, dynamic> json) {
    age = json["age"];
    bio = json["bio"];
    connection = json["connection"];
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
    data["id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    if(photo != null) {
      data["photo"] = photo?.toJson();
    }    data["status"] = status;
    data["username"] = username;
    return data;
  }
}

class Photo {
  String? hostname;
  String? url;

  Photo({this.hostname, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
    hostname = json["hostname"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hostname"] = hostname;
    data["url"] = url;
    return data;
  }
}
