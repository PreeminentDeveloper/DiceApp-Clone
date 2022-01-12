import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:dice_app/views/profile/source/remote.dart';
import 'package:flutter/material.dart';

enum ProfileEnum { initial, busy, idle }

class ProfileProvider extends ChangeNotifier {
  ProfileEnum profileEnum = ProfileEnum.initial;
  final ProfileService _profileService;
  User? user;
  List<dynamic>? list = [];

  ProfileProvider(this._profileService);

  void getUsersInformations({bool notifyListeners = false}) {
    user = User.fromJson(SessionManager.instance.usersData);
    logger.d(user?.toJson());
    if (notifyListeners) this.notifyListeners();
  }

  void uploadFile(File? file) async {
    try {
      profileEnum = ProfileEnum.busy;
      await _profileService.profileImageUpdate(file);
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }
}
