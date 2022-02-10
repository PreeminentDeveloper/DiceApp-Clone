import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/username/username_model.dart';
import 'package:dice_app/views/auth/data/source/authorization.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool acceptedUsername = false;

  final AuthService _authService;

  AuthProvider(this._authService);

  void verifyUserName(String codename) async {
    try {
      final response =
          await _authService.verifyUsername(CodeNameModel(codename));
      if (response.codeNameExists == false) {
        acceptedUsername = true;
      } else {
        acceptedUsername = false;
      }
    } catch (e) {
      logger.e(e);
      acceptedUsername = false;
    }
    notifyListeners();
  }
}
