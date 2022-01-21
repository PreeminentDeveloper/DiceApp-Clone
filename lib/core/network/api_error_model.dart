class ApiErrorModel {
  int? code;
  String? message;
  bool? success;

  ApiErrorModel({
    this.code,
    this.message,
    this.success,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: json["code"],
        message: json["message"],
        success: json["success"],
      );
}
