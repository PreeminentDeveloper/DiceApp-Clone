import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/settings/source/remote.dart';
import 'package:flutter/material.dart';

enum SetUpEnum { initial, busy, idle }

class SetUpProvider extends ChangeNotifier {
  SetUpEnum setUpEnum = SetUpEnum.initial;
  final SetUpService _setUpService;

  List? list = [];
  // 087a51cb-0aaf-42eb-8708-eb76bb5ff051
  SetUpProvider(this._setUpService);

  void listIgnoredUsers({
    required int pageNumber,
    int perPage = 20,
    String? search,
    required String userID,
  }) async {
    try {
      setUpEnum = SetUpEnum.busy;
      final _response = await _setUpService.listIgnoreUserd(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search ?? '',
          userID: userID);

      _response.listIgnoreUser?.listData ?? [];
      setUpEnum = SetUpEnum.idle;
    } catch (e) {
      logger.e(e);
      setUpEnum = SetUpEnum.idle;
    }
    notifyListeners();
  }
}
