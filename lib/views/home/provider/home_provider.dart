import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:flutter/material.dart';

enum HomeEnum { initial, busy, idle }

class HomeProvider extends ChangeNotifier {
  HomeEnum homeEnum = HomeEnum.initial;
  final HomeService _homeService;
  User? user;
  List<dynamic>? list = [];

  HomeProvider(this._homeService);

  void getUsersInformations({bool notifyListeners = false}) {
    user = User.fromJson(SessionManager.instance.usersData);
    if (notifyListeners) this.notifyListeners();
  }

  void listConversations(
      {required int pageNumber,
      int perPage = 20,
      required String search}) async {
    try {
      homeEnum = HomeEnum.busy;

      /// Todo:=> Replace the static userID with a dynamic userID
      /// line 32
      final _response = await _homeService.listConvo(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search,
          userID: '087a51cb-0aaf-42eb-8708-eb76bb5ff051');
      list = _response.data?.listConversations?.list ?? [];
      homeEnum = HomeEnum.idle;
    } catch (e) {
      logger.e(e);
      homeEnum = HomeEnum.idle;
    }
    notifyListeners();
  }
}
