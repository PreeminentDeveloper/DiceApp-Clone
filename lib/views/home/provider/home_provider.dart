import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/source/dao.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:flutter/material.dart';

enum HomeEnum { initial, busy, idle }

class ConversationList {
  final String? conversationID;
  final List<User> user;

  ConversationList(this.conversationID, this.user);
}

class HomeProvider extends ChangeNotifier {
  HomeEnum homeEnum = HomeEnum.initial;
  final HomeService _homeService;

  List<User>? list = [];
  List<ConversationList>? conversationList = [];
  String? conversationID;

  HomeProvider(this._homeService);

  void listConversations({
    required int pageNumber,
    int perPage = 20,
    String? search,
    required String userID,
  }) async {
    try {
      if (list!.isEmpty) homeEnum = HomeEnum.busy;
      final _response = await _homeService.listConvo(
          pageNumber: pageNumber,
          perPage: perPage,
          search: search ?? '',
          userID: userID);

      if (_response.listConversations!.list!.isNotEmpty) {
        conversationList!.clear();
      }
      _response.listConversations?.list?.map((listData) {
        conversationList?.add(ConversationList(listData.id, listData.users!));
        notifyListeners();
      }).toList();

      homeEnum = HomeEnum.idle;
      notifyListeners();
    } catch (e) {
      logger.e(e);
      homeEnum = HomeEnum.idle;
    }
    notifyListeners();
  }
}
