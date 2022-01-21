class LaravelError {
  String? msg;
  int? code;
  bool? success;
  Errors? errors;

  LaravelError({this.msg, this.code, this.success, this.errors});

  LaravelError.fromJson(Map<String, dynamic> json) {
    if (json["msg"] is String) {
      msg = json["msg"];
    }
    if (json["code"] is int) {
      code = json["code"];
    }
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["errors"] is Map) {
      errors = json["errors"] == null ? null : Errors.fromJson(json["errors"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["msg"] = msg;
    data["code"] = code;
    data["success"] = success;
    if (errors != null) {
      data["errors"] = errors?.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email = [];
  List<String>? username = [];
  List<String>? picture = [];
  List<String>? receiverPhoneNo = [];

  Errors({this.email, this.username, this.picture, this.receiverPhoneNo});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json["email"] is List) {
      email = json["email"] == null ? [] : List<String>.from(json["email"]);
    }
    if (json["username"] is List) {
      username =
          json["username"] == null ? [] : List<String>.from(json["username"]);
    }
    if (json["picture"] is List) {
      picture =
          json["picture"] == null ? [] : List<String>.from(json["picture"]);
    }
    if (json["receiver_phone_no"] is List) {
      receiverPhoneNo = json["receiver_phone_no"] == null
          ? []
          : List<String>.from(json["receiver_phone_no"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null) {
      data["email"] = email;
    }
    return data;
  }
}
