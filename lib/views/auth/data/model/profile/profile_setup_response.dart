
import 'package:dice_app/core/entity/users_entity.dart';

class ProfileSetUpResponse {
  String? typename;
  CompleteRegistration? completeRegistration;

  ProfileSetUpResponse({this.typename, this.completeRegistration});

  ProfileSetUpResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    completeRegistration = json["completeRegistration"] == null
        ? null
        : CompleteRegistration.fromJson(json["completeRegistration"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (completeRegistration != null) {
      data["completeRegistration"] = completeRegistration?.toJson();
    }
    return data;
  }
}

class CompleteRegistration {
  String? typename;
  User? user;

  CompleteRegistration({this.typename, this.user});

  CompleteRegistration.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}

