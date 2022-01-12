
class OtpResponse {
  Data? data;

  OtpResponse({this.data});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  VerifyOtp? verifyOtp;

  Data({this.verifyOtp});

  Data.fromJson(Map<String, dynamic> json) {
    verifyOtp = json["verifyOtp"] == null ? null : VerifyOtp.fromJson(json["verifyOtp"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(verifyOtp != null) {
      data["verifyOtp"] = verifyOtp?.toJson();
    }
    return data;
  }
}

class VerifyOtp {
  AuthSession? authSession;

  VerifyOtp({this.authSession});

  VerifyOtp.fromJson(Map<String, dynamic> json) {
    authSession = json["authSession"] == null ? null : AuthSession.fromJson(json["authSession"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if(authSession != null) {
      data["authSession"] = authSession?.toJson();
    }
    return data;
  }
}

class AuthSession {
  String? refreshToken;
  String? token;
  User? user;

  AuthSession({this.refreshToken, this.token, this.user});

  AuthSession.fromJson(Map<String, dynamic> json) {
    refreshToken = json["refreshToken"];
    token = json["token"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["refreshToken"] = refreshToken;
    data["token"] = token;
    if(user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? phone;
  Photo? photo;
  String? status;
  String? username;

  User({this.id, this.name, this.phone, this.photo, this.status, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    status = json["status"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    if(photo != null) {
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
