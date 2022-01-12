import 'package:dice_app/core/entity/users_entity.dart';

class OtpResponse {
  String? typename;
  VerifyOtp? verifyOtp;

  OtpResponse({this.typename, this.verifyOtp});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    verifyOtp = json["verifyOtp"] == null
        ? null
        : VerifyOtp.fromJson(json["verifyOtp"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (verifyOtp != null) {
      data["verifyOtp"] = verifyOtp?.toJson();
    }
    return data;
  }
}

class VerifyOtp {

  String? typename;
  AuthSession? authSession;

  VerifyOtp({this.typename, this.authSession});

  VerifyOtp.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    authSession = json["authSession"] == null
        ? null
        : AuthSession.fromJson(json["authSession"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (authSession != null) {
      data["authSession"] = authSession?.toJson();
    }
    return data;
  }
}

class AuthSession {

  String? typename;
  String? refreshToken;
  String? token;
  User? user;

  AuthSession({this.typename, this.refreshToken, this.token, this.user});

  AuthSession.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    refreshToken = json["refreshToken"];
    token = json["token"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["refreshToken"] = refreshToken;
    data["token"] = token;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}
