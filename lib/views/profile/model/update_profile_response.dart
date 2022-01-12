import 'package:dice_app/core/entity/users_entity.dart';

class UpdateUserDataResponse {
  String? typename;
  UpdateUser? updateUser;

  UpdateUserDataResponse({this.typename, this.updateUser});

  UpdateUserDataResponse.fromJson(json) {
    typename = json["__typename"];
    updateUser = json["updateUser"] == null
        ? null
        : UpdateUser.fromJson(json["updateUser"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (updateUser != null) data["updateUser"] = updateUser?.toJson();
    return data;
  }
}

class UpdateUser {
  String? typename;
  User? user;

  UpdateUser({this.typename, this.user});

  UpdateUser.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (user != null) data["user"] = user?.toJson();
    return data;
  }
}
