import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/settings/source/remote.dart';
import 'package:flutter/material.dart';

enum SetUpEnum { initial, busy, idle }

class SetUpProvider extends ChangeNotifier {
  SetUpEnum setUpEnum = SetUpEnum.initial;
  final SetUpService _setUpService;

  List<User>? ignoreList = [];
  List<User>? blockedList = [];

  // 087a51cb-0aaf-42eb-8708-eb76bb5ff051
  SetUpProvider(this._setUpService);

  void listIgnoredAndBlockedUsers({
    required int pageNumber,
    int perPage = 20,
    String? search,
    required String userID,
  }) async {
    try {
      setUpEnum = SetUpEnum.busy;
      final _ignoreResponse = await _setUpService.listIgnoreUser(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search ?? '',
          userID: userID);

      final _blockedResponse = await _setUpService.listBlockedUser(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search ?? '',
          userID: userID);

      ignoreList = _ignoreResponse.listIgnoredUsers?.ignoredData ?? [];
      blockedList = _blockedResponse.listBlockedUsers?.listData ?? [];
      setUpEnum = SetUpEnum.idle;
    } catch (e) {
      logger.e(e);
      setUpEnum = SetUpEnum.idle;
    }
    notifyListeners();
  }

  void unignoreUser(
      {required String? userID, required String? receiverID}) async {
    try {
      await _setUpService.unignoreUser(userID: userID, receiverID: receiverID);
      await _setUpService.listIgnoreUser(
          pageNumber: 1, perPage: 20, search: '', userID: userID!);
    } catch (e) {
      logger.e(e);
      setUpEnum = SetUpEnum.idle;
    }
    notifyListeners();
  }

  void unblockUser(
      {required String? userID, required String? receiverID}) async {
    try {
      await _setUpService.unblockUser(userID: userID, receiverID: receiverID);
      await _setUpService.listBlockedUser(
          pageNumber: 1, perPage: 20, search: '', userID: userID!);
    } catch (e) {
      logger.e(e);
      setUpEnum = SetUpEnum.idle;
    }
    notifyListeners();
  }
}
