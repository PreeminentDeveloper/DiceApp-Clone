import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/profile/get_user_data_response.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/source/remote.dart';
import 'package:flutter/material.dart';

enum ProfileEnum { initial, busy, idle }

class ProfileProvider extends ChangeNotifier {
  ProfileEnum profileEnum = ProfileEnum.initial;
  final ProfileService _profileService;
  User? user;
  GetUserDataResponse? getUserDataResponse;

  ProfileProvider(this._profileService);

  void getUsersInformations({bool notifyListeners = false}) {
    user = User.fromJson(SessionManager.instance.usersData);
    if (notifyListeners) this.notifyListeners();
  }

  void getMyProfile() async {
    try {
      getUsersInformations();
      final _response = await _profileService
          .getUsersProfile(ProfileSetupModel(id: user?.id), isMyProfile: true);
      getUserDataResponse = _response;
    } catch (e) {
      logger.e(e);
    }
    notifyListeners();
  }

  void uploadFile(File? file) async {
    try {
      profileEnum = ProfileEnum.busy;
      await _profileService.profileImageUpdate(file);
      notifyListeners();
      await _profileService.getUsersProfile(ProfileSetupModel(id: user?.id));
      getUsersInformations(notifyListeners: true);
      profileEnum = ProfileEnum.idle;
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }

  void updateUsersInfo(BuildContext context, String key, String value) async {
    try {
      profileEnum = ProfileEnum.busy;

      await _profileService.updateUsersInfo(key, value, user!.id!);
      getUsersInformations(notifyListeners: true);
      isExists = false;
      notifyListeners();
      profileEnum = ProfileEnum.idle;
      PageRouter.goBack(context);
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }

    notifyListeners();
  }

  void getMyFriendsProfile(String id) async {
    try {
      if (getUserDataResponse == null) profileEnum = ProfileEnum.busy;
      final _response = await _profileService
          .getUsersProfile(ProfileSetupModel(id: id), isMyProfile: false);
      getUserDataResponse = _response;
      profileEnum = ProfileEnum.idle;
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }

  void requestConnection({String? msg, required String? receiverID}) async {
    try {
      await _profileService.requestConnection(
          msg: msg, senderID: user!.id!, receiverID: receiverID);
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }

  void acceptConnection(
      {HomeProvider? homeProvider,
      String? msg,
      required String? receiverID}) async {
    try {
      await _profileService.acceptConnection(
          msg: msg, senderID: user!.id!, receiverID: receiverID);
      homeProvider!.listConversations(pageNumber: 1, userID: user!.id!);
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }

  /// ignore a user
  void ignoreUser({required String? receiverID}) async {
    try {
      await _profileService.ignoreUser(
          userID: user!.id!, receiverID: receiverID);
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }

  bool isExists = false;

  void verifyUserName(String username) async {
    try {
      final _response = await _profileService.verifyUserName(username);
      isExists = _response!.codeNameExists!;
      profileEnum = ProfileEnum.idle;
      notifyListeners();
    } catch (e) {
      logger.e(e);
      profileEnum = ProfileEnum.idle;
    }
    notifyListeners();
  }
}
