import 'dart:io';

import 'package:dio/dio.dart';

class FeatureModel {
  File? key;
  String? value;
  MultipartFile? file;
  String? caption;
  String? message;
  String? conversation_id;
  String? user_id;

  FeatureModel({
    this.key,
    this.value,
    this.file,
    this.caption,
    this.message,
    this.conversation_id,
    this.user_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'caption': caption,
      'message': message,
      'conversation_id': conversation_id,
      'user_id': user_id,
    };
  }
}
