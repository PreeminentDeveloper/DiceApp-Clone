import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/invite/model/connection_request/connection_request_response.dart';
import 'package:dice_app/views/invite/model/contact/contacts_exists_response.dart';
import 'package:dice_app/views/invite/model/contact/contacts_model.dart';
import 'package:dice_app/views/invite/model/find_people/search_users_response.dart';
import 'package:dice_app/views/invite/model/my_connections/my_connections_response.dart';
import 'package:dice_app/views/invite/source/invite_remote.dart';
import 'package:flutter/material.dart';

enum InviteEnum { initial, busy, idle }

class InviteProvider extends ChangeNotifier {
  InviteEnum inviteEnum = InviteEnum.initial;
  final InviteService _inviteService;
  User? user;
  List<Contacts>? mContacts = [];

  List<ListOfData>? list = [];
  List<ListOfData> searchUser = [];
  List<ListData> myRequest = [];

  InviteProvider(this._inviteService);

  @override
  void dispose() {
    mContacts = [];
    list = [];
    searchUser = [];
    myRequest = [];
    user = null;
    super.dispose();
  }

  void checkIfConnections(List<String> contacts) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService
          .checkIfContactsExists(ContactsModel(contacts: contacts));
      _response?.comparePhoneContactWithDiceContact?.map((compare) {
        mContacts = compare.contacts ?? [];
      }).toList();
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }

  void getConnections(
      {required int pageNumber, int perPage = 20, required String? id}) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService.getConnections(
          pageNumber: pageNumber, perPage: perPage, userID: id!);
      list = ((_response?.listConnections?.listOfData ?? []));
      inviteEnum = InviteEnum.idle;
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }

  void findPeople({required String name}) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService.findPeople(name: name);
      searchUser = (_response?.searchUser ?? []);
      inviteEnum = InviteEnum.idle;
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }

  void getMyConnectionRequest(
      {@required HomeProvider? homeProvider,
      required int pageNumber,
      int perPage = 20,
      required String? id}) async {
    try {
      inviteEnum = InviteEnum.busy;
      final _response = await _inviteService.myConnectionRequest(
          pageNumber: pageNumber, perPage: perPage, userID: id!);

      /// Call this line to perform an updated request
      homeProvider!
          .listConversations(pageNumber: 1, userID: id, saveConvo: false);

      myRequest = (_response?.listConnectionRequest?.listData ?? []);
      inviteEnum = InviteEnum.idle;
    } catch (e) {
      inviteEnum = InviteEnum.idle;
    }
    notifyListeners();
  }
}
