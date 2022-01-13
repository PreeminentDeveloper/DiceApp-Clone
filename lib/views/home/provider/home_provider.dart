import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:flutter/material.dart';

enum HomeEnum { initial, busy, idle }

class HomeProvider extends ChangeNotifier {
  HomeEnum homeEnum = HomeEnum.initial;
  final HomeService _homeService;

  List<dynamic>? list = [];

  HomeProvider(this._homeService);

  void listConversations({
    required int pageNumber,
    int perPage = 20,
    required String search,
    required String userID,
  }) async {
    try {
      homeEnum = HomeEnum.busy;
      final _response = await _homeService.listConvo(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search,
          userID: userID);
      list = _response.data?.listConversations?.list ?? [];
      homeEnum = HomeEnum.idle;
    } catch (e) {
      logger.e(e);
      homeEnum = HomeEnum.idle;
    }
    notifyListeners();
  }
}
