import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/model/conversation_list.dart';
import 'package:dice_app/views/home/data/source/dao.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum HomeEnum { initial, busy, idle }

class HomeProvider extends ChangeNotifier {
  HomeEnum homeEnum = HomeEnum.initial;
  final HomeService _homeService;

  List<User>? list = [];
  List<ConversationList>? conversationList = [];
  String? conversationID;

  HomeProvider(this._homeService);

  void listConversations(
      {int? pageNumber = 1,
      int perPage = 20,
      String? search,
      required String userID,
      bool saveConvo = true}) async {
    try {
      // if (list!.isEmpty) homeEnum = HomeEnum.busy;
      final _response = await _homeService.listConvo(
          pageNumber: pageNumber ?? 1,
          perPage: perPage,
          search: search ?? '',
          userID: userID);

      if (_response.listConversations!.list!.isNotEmpty) {
        conversationList!.clear();
      }

      _response.listConversations?.list?.map((listData) {
        conversationList?.add(ConversationList(
            id: DateTime.now().toString(),
            conversationID: listData.id,
            viewersCount: listData.viewersCount,
            lastMessage: listData.lastMessage,
            user: listData.users));
        notifyListeners();
      }).toList();

      if (saveConvo) listOfConversationsDao!.myconversations(conversationList!);
      homeEnum = HomeEnum.idle;

      notifyListeners();
    } catch (e) {
      logger.e(e);
      homeEnum = HomeEnum.idle;
    }
    notifyListeners();
  }

  void removeConversation(
      {required String conversationId, required String userID}) async {
    try {
      await _homeService.removeConvo(
          conversationId: conversationId, userID: userID);
      listConversations(userID: userID);
      notifyListeners();
    } catch (e) {
      logger.e(e);
      homeEnum = HomeEnum.idle;
    }
    notifyListeners();
  }
}
