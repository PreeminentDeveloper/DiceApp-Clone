import 'package:dice_app/core/entity/users_entity.dart';

class GetUserDataResponse {
  String? typename;
  User? getProfile;

  GetUserDataResponse({this.typename, this.getProfile});

  GetUserDataResponse.fromJson(json) {
    // typename = json["__typename"] ?? '';
    getProfile =
        json["getProfile"] == null ? null : User.fromJson(json["getProfile"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["__typename"] = typename;
    if (getProfile != null) data["getProfile"] = getProfile?.toJson();
    return data;
  }
}
