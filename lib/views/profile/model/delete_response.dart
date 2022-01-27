class DeleteResponse {
  String? typename;
  RemoveProfilePhoto? removeProfilePhoto;

  DeleteResponse({this.typename, this.removeProfilePhoto});

  DeleteResponse.fromJson(json) {
    typename = json["__typename"];
    removeProfilePhoto = json["removeProfilePhoto"] == null
        ? null
        : RemoveProfilePhoto.fromJson(json["removeProfilePhoto"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (removeProfilePhoto != null) {
      data["removeProfilePhoto"] = removeProfilePhoto?.toJson();
    }
    return data;
  }
}

class RemoveProfilePhoto {
  String? typename;
  String? name;
  String? phone;
  dynamic? photo;
  String? status;
  String? id;
  String? bio;
  String? username;
  dynamic? connection;
  dynamic? conversation;

  RemoveProfilePhoto(
      {this.typename,
      this.name,
      this.phone,
      this.photo,
      this.status,
      this.id,
      this.bio,
      this.username,
      this.connection,
      this.conversation});

  RemoveProfilePhoto.fromJson(json) {
    typename = json["__typename"];
    name = json["name"];
    phone = json["phone"];
    photo = json["photo"];
    status = json["status"];
    id = json["id"];
    bio = json["bio"];
    username = json["username"];
    connection = json["connection"];
    conversation = json["conversation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["name"] = name;
    data["phone"] = phone;
    data["photo"] = photo;
    data["status"] = status;
    data["id"] = id;
    data["bio"] = bio;
    data["username"] = username;
    data["connection"] = connection;
    data["conversation"] = conversation;
    return data;
  }
}
