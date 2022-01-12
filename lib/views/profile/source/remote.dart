import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  ProfileService();

  Future<dynamic> profileImageUpdate(File? file) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(UrlConfig.uploadBaseUrl));

      logger.d(SessionManager.instance.authToken);
      //Header....
      request.headers['Authorization'] =
          'Bearer ${SessionManager.instance.authToken}';

      request.fields['type'] = "profile_picture";
      request.files.add(await http.MultipartFile.fromPath('image', file!.path));
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      return res.body;
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }
}
