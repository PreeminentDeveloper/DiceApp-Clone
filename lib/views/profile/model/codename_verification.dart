class CodeNameVerification {
  String? typename;
  bool? codeNameExists;

  CodeNameVerification({this.typename, this.codeNameExists});

  CodeNameVerification.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    codeNameExists = json["codeNameExists"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["__typename"] = typename;
    data["codeNameExists"] = codeNameExists;
    return data;
  }
}
