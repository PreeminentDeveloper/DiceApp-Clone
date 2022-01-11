class LoginResponse {
  String? typename;
  BeginLogin? beginLogin;

  LoginResponse({this.typename, this.beginLogin});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    beginLogin = json["beginLogin"] == null
        ? null
        : BeginLogin.fromJson(json["beginLogin"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (beginLogin != null) data["beginLogin"] = beginLogin?.toJson();
    return data;
  }
}

class BeginLogin {
  String? typename;
  PhoneVerificationObject? phoneVerificationObject;

  BeginLogin({this.typename, this.phoneVerificationObject});

  BeginLogin.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    phoneVerificationObject = json["phoneVerificationObject"] == null
        ? null
        : PhoneVerificationObject.fromJson(json["phoneVerificationObject"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (phoneVerificationObject != null) {
      data["phoneVerificationObject"] = phoneVerificationObject?.toJson();
    }
    return data;
  }
}

class PhoneVerificationObject {
  String? typename;
  String? phone;

  PhoneVerificationObject({this.typename, this.phone});

  PhoneVerificationObject.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["phone"] = phone;
    return data;
  }
}
