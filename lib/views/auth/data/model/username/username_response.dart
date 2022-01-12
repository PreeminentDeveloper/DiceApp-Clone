
class UsernameResponse {
  String? typename;
  bool? codeNameExists;

  UsernameResponse({this.typename, this.codeNameExists});

  UsernameResponse.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    codeNameExists = json["codeNameExists"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["codeNameExists"] = codeNameExists;
    return data;
  }
}

// class Data {
//   bool? codeNameExists;
//
//   Data({this.codeNameExists});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     codeNameExists = json["codeNameExists"];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["codeNameExists"] = codeNameExists;
//     return data;
//   }
// }
